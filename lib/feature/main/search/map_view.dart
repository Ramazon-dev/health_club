import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:health_club/domain/core/services/map_setvice_utils.dart';
import 'package:health_club/feature/main/search/widgets/cluster.dart';
import 'package:health_club/router/app_router.gr.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../data/network/model/map/map_point_response.dart';
import '../../../domain/core/core.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late final YandexMapController yandexMapController;
  final _mapZoom = 0.0;
  List<PlacemarkMapObject> _placemarks = [];
  ClusterizedPlacemarkCollection? _clusterCollection;

  void _buildMapObjects() {
    _placemarks = points
        .where((e) => e.lat != null && e.long != null)
        .map(
          (mapPoint) => PlacemarkMapObject(
            mapId: MapObjectId('${mapPoint.id}'),
            onTap: (mapObject, point) {
              final userLocationState = context.read<UserLocationCubit>().state;
              context.read<MapPointDetailCubit>().getMapPointDetail(
                mapPoint.type ?? '',
                mapPoint.id ?? 0,
                (userLocationState is UserLocationLoaded) ? userLocationState.latLng : null,
              );
            },
            point: Point(latitude: double.parse(mapPoint.lat ?? '0'), longitude: double.parse(mapPoint.long ?? '0')),
            opacity: 1,
            icon: PlacemarkIcon.single(mapPoint.type == 'place' ? _placeIcon : _defaultIcon),
          ),
        )
        .toList();

    _clusterCollection = _getClusterizedCollection(placemarks: _placemarks);
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
          CameraUpdate.newCameraPosition(CameraPosition(target: cluster.placemarks.first.point, zoom: _mapZoom + 1)),
        );
      },
    );
    return res;
  }

  List<PlacemarkMapObject> _getPlacemarkObjects() {
    final res = points.where((element) => (element.lat != null && element.long != null)).map((mapPoint) {
      return PlacemarkMapObject(
        mapId: MapObjectId('${mapPoint.id}'),
        onTap: (mapObject, point) {
          final userLocationState = context.read<UserLocationCubit>().state;
          context.read<MapPointDetailCubit>().getMapPointDetail(
            mapPoint.type ?? '',
            mapPoint.id ?? 0,
            (userLocationState is UserLocationLoaded) ? userLocationState.latLng : null,
          );
        },
        point: Point(latitude: double.parse(mapPoint.lat ?? '0'), longitude: double.parse(mapPoint.long ?? '0')),
        opacity: 1,
        icon: PlacemarkIcon.single(
          mapPoint.type == 'place'
              ? PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage(AppAssets.marker35), scale: 0.8)
              : PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage(AppAssets.marker), scale: 2),
        ),
      );
    }).toList();
    return res;
  }

  late final PlacemarkIconStyle _placeIcon;
  late final PlacemarkIconStyle _defaultIcon;

  Future<void> _initIcons() async {
    _placeIcon = PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage(AppAssets.markerNew), scale: 0.7);
    // _placeIcon = PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage(AppAssets.circlePin), scale: 0.25);
    _defaultIcon = PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage(AppAssets.marker), scale: 2);
  }

  @override
  void initState() {
    _initIcons();
    final state = context.read<MapPointsCubit>().state;
    context.read<UserLocationCubit>().requestLocationPermission();
    if (state is MapPointsLoaded) {
      points = state.points;
      setState(() {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MapPointsCubit, MapPointsState>(
        listener: (context, state) {
          if (state is MapPointsLoaded) {
            points = state.points;
            _buildMapObjects();
          }
        },
        builder: (context, state) {
          final cluster = _clusterCollection;
          return YandexMap(
            mapObjects: cluster != null ? [cluster] : _placemarks,
            // mapObjects: [_getClusterizedCollection(placemarks: _getPlacemarkObjects())],
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
              padding: EdgeInsets.only(bottom: 0.37.sh),
              child: FloatingActionButton(
                shape: CircleBorder(),
                backgroundColor: Colors.white,
                onPressed: () async {
                  final userPosition = await MapServiceUtils.getUserPosition();
                  print('object get user position result lat ${userPosition?.lat} long ${userPosition?.lng}');
                  if (userPosition != null) {
                    yandexMapController.moveCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: Point(latitude: userPosition.lat, longitude: userPosition.lng),
                          zoom: 17,
                        ),
                      ),
                      animation: MapAnimation(duration: 0.4, type: MapAnimationType.linear),
                    );
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
    yandexMapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: Point(latitude: 41.311296, longitude: 69.279753), zoom: 14),
      ),
      animation: MapAnimation(duration: 0.4, type: MapAnimationType.linear),
    );
  }
}
