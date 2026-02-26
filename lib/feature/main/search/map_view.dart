import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:health_club/feature/main/search/widgets/cluster.dart';
import 'package:health_club/feature/main/search/widgets/markers_helper.dart';
import 'package:health_club/router/app_router.gr.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../data/network/model/map/map_point_response.dart';
import '../../../domain/core/core.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> with MarkersHelper {
  late final YandexMapController yandexMapController;
  double _currentZoom = 14;
  List<PlacemarkMapObject> _placemarks = [];
  ClusterizedPlacemarkCollection? _clusterCollection;

  Future<void> _buildMapObjects() async {
    final List<PlacemarkMapObject> placemarks = [];

    for (final mapPoint in points.where((e) => e.lat != null && e.long != null)) {
      final lat = double.tryParse(mapPoint.lat ?? '');
      final lon = double.tryParse(mapPoint.long ?? '');
      if (lat == null || lon == null) continue;
      late final PlacemarkIconStyle iconStyle;
      if (mapPoint.type == 'place') {
        iconStyle = _placeIcon;
      } else {
        final markerBytes = await markerCircleBytesFromUrl(mapPoint.imageUrl, size: 150);
        iconStyle = (markerBytes != null)
            ? PlacemarkIconStyle(image: BitmapDescriptor.fromBytes(markerBytes))
            : _defaultIcon;
      }
      placemarks.add(
        PlacemarkMapObject(
          mapId: MapObjectId('${mapPoint.id}'),
          onTap: (mapObject, point) {
            final userLocationState = context.read<UserLocationCubit>().state;
            context.read<MapPointDetailCubit>().getMapPointDetail(
              mapPoint.type ?? '',
              mapPoint.id ?? 0,
              (userLocationState is UserLocationLoaded) ? userLocationState.latLng : null,
            );
          },
          point: Point(latitude: lat, longitude: lon),
          opacity: 1,
          icon: PlacemarkIcon.single(iconStyle),
        ),
      );
    }

    _placemarks = placemarks;
    _clusterCollection = _getClusterizedCollection(placemarks: _placemarks);

    if (mounted) setState(() {});
  }

  List<MapPointResponse> points = [];

  @override
  void dispose() {
    yandexMapController.dispose();
    super.dispose();
  }

  ClusterizedPlacemarkCollection _getClusterizedCollection({required List<PlacemarkMapObject> placemarks}) {
    final res = ClusterizedPlacemarkCollection(
      mapId: const MapObjectId('clusterized-1'),
      placemarks: placemarks,
      radius: 50,
      minZoom: 12,
      onClusterAdded: (self, cluster) async {
        return cluster.copyWith(
          appearance: cluster.appearance.copyWith(
            opacity: 1.0,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromBytes(await ClusterIconPainter(cluster.size).getClusterIconBytes()),
              ),
            ),
          ),
        );
      },
      onClusterTap: (self, cluster) async {
        await yandexMapController.moveCamera(
          animation: const MapAnimation(type: MapAnimationType.linear, duration: 0.3),
          CameraUpdate.newCameraPosition(
            CameraPosition(target: cluster.placemarks.first.point, zoom: _currentZoom + 1),
          ),
        );
      },
    );
    return res;
  }

  late final PlacemarkIconStyle _placeIcon;
  late final PlacemarkIconStyle _defaultIcon;

  Future<void> _initIcons() async {
    _placeIcon = PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage(AppAssets.markerNew), scale: 0.7);
    _defaultIcon = PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage(AppAssets.marker), scale: 2);
  }

  @override
  void initState() {
    context.read<UserLocationCubit>().requestLocationPermission();
    final mapPointsCubit = context.read<MapPointsCubit>();
    Future.microtask(() async {
      await _initIcons();
      final state = mapPointsCubit.state;
      if (state is MapPointsLoaded) {
        points = state.points;
        await _buildMapObjects();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MapPointsCubit, MapPointsState>(
        listener: (context, state) async {
          if (state is MapPointsLoaded) {
            points = state.points;
            await _buildMapObjects();
          }
        },
        builder: (context, state) {
          final cluster = _clusterCollection;
          return YandexMap(
            onCameraPositionChanged: (cameraPosition, reason, finished) {
              _currentZoom = cameraPosition.zoom;
            },
            mapObjects: cluster != null ? [cluster] : _placemarks,
            onMapCreated: (controller) async {
              yandexMapController = controller;
              onMapCreated();
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: BlocConsumer<UserLocationCubit, UserLocationState>(
        listener: (context, userLocationState) async {
          if (userLocationState is UserLocationPermissionDenied) {
          } else if (userLocationState is UserLocationPermissionDeniedForever) {
            await CustomSneakBar.show(
              context: context,
              status: SneakBarStatus.success,
              title: 'Вы не дали разришения на геолокацию',
            );
          } else if (userLocationState is UserLocationLoaded) {
            final location = userLocationState.latLng;
            yandexMapController.moveCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: Point(latitude: location.lat, longitude: userLocationState.latLng.lng),
                  zoom: 14,
                ),
              ),
              animation: MapAnimation(duration: 0.4, type: MapAnimationType.linear),
            );

          }
        },
        builder: (context, userLocationState) {
          return BlocListener<MapPointDetailCubit, MapPointDetailState>(
            listener: (context, state) {
              if (state is MapPointDetailLoaded) {
                final latLng = (userLocationState is UserLocationLoaded) ? userLocationState.latLng : null;
                context.router.push(FitnessRoute(latLng: latLng));
              }
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 0.4.sh),
              child: FloatingActionButton(
                shape: CircleBorder(),
                backgroundColor: Colors.white,
                onPressed: () async {
                  if (userLocationState is UserLocationLoaded) {
                    final userPosition = userLocationState.latLng;
                    // final userPosition = await MapServiceUtils.getUserPosition();
                    yandexMapController.moveCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: Point(latitude: userPosition.lat, longitude: userPosition.lng),
                          zoom: 16,
                        ),
                      ),
                      animation: MapAnimation(duration: 0.4, type: MapAnimationType.linear),
                    );
                  } else {
                    final userPosition = await context.read<UserLocationCubit>().getUserLocation();
                    if (userPosition != null) {
                      yandexMapController.moveCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: Point(latitude: userPosition.lat, longitude: userPosition.lng),
                            zoom: 16,
                          ),
                        ),
                        animation: MapAnimation(duration: 0.4, type: MapAnimationType.linear),
                      );
                    }
                  }
                },
                child: (userLocationState is UserLocationLoading)
                    ? CircularProgressIndicator.adaptive()
                    : Icon(Icons.near_me),
              ),
            ),
          );
        },
      ),
    );
  }

  void onMapCreated() {
    final selectedCountryIsUz = context.read<ProfileCubit>().selectedCountryUz;
    final lat = selectedCountryIsUz ? 41.311296 : 51.128222;
    final long = selectedCountryIsUz ? 69.279753 : 71.430576;
    yandexMapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: Point(latitude: lat, longitude: long), zoom: 12),
      ),
      animation: MapAnimation(duration: 0.4, type: MapAnimationType.linear),
    );
  }
}
