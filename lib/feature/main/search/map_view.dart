import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:health_club/feature/main/search/widgets/cluster.dart';
import 'package:health_club/router/app_router.gr.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../data/network/model/map/map_point_response.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late final YandexMapController yandexMapController;
  final _mapZoom = 0.0;

  List<MapPointResponse> points = [
    // Point(latitude: 41.315065, longitude: 69.321204),
    // Point(latitude: 41.314384, longitude: 69.305950),
    // Point(latitude: 41.311296, longitude: 69.279753),
  ];

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
          context.read<MapPointDetailCubit>().getMapPointDetail(mapPoint.type ?? '', mapPoint.id ?? 0);
        },
        point: Point(latitude: double.parse(mapPoint.lat ?? '0'), longitude: double.parse(mapPoint.long ?? '0')),
        opacity: 1,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(AppAssets.marker),
            scale: 2,
          ),
        ),
      );
    }).toList();
    return res;
  }

  @override
  void initState() {
    final state = context.read<MapPointsCubit>().state;
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
          }
        },
        builder: (context, state){
          return YandexMap(
            mapObjects: [_getClusterizedCollection(placemarks: _getPlacemarkObjects())],
            onMapCreated: (controller) async {
              yandexMapController = controller;
              onMapCreated();
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: BlocListener<MapPointDetailCubit, MapPointDetailState>(
        listener: (context, state) {
          if (state is MapPointDetailLoaded) {
            context.router.push(FitnessRoute());
          }
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: 0.37.sh),
          child: FloatingActionButton(
            shape: CircleBorder(),
            backgroundColor: Colors.white,
            onPressed: () {
              // context.read<MapPointDetailCubit>().getMapPointDetail('bonus_partner', 4);
              yandexMapController.moveCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(target: Point(latitude: 41.310526, longitude: 69.326838), zoom: 17),
                ),
                animation: MapAnimation(duration: 0.4, type: MapAnimationType.linear),
              );
            },
            child: Icon(Icons.near_me),
          ),
        ),
      ),
    );
  }

  void onMapCreated() {
    yandexMapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: Point(latitude: 41.311296, longitude: 69.279753), zoom: 15),
      ),
      animation: MapAnimation(duration: 0.4, type: MapAnimationType.linear),
    );
  }
}
