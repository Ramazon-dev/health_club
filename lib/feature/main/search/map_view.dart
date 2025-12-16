import 'package:flutter/material.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:health_club/feature/main/search/widgets/cluster.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late final YandexMapController yandexMapController;
  final _mapZoom = 0.0;

  final List<Point> points = [
    Point(latitude: 41.315065, longitude: 69.321204),
    Point(latitude: 41.314384, longitude: 69.305950),
    Point(latitude: 41.311296, longitude: 69.279753),
  ];

  @override
  void dispose() {
    yandexMapController.dispose();
    super.dispose();
  }

  ClusterizedPlacemarkCollection _getClusterizedCollection({required List<PlacemarkMapObject> placemarks}) {
    return ClusterizedPlacemarkCollection(
      mapId: const MapObjectId('clusterized-1'),
      placemarks: placemarks,
      radius: 50,
      minZoom: 15,
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
  }

  List<PlacemarkMapObject> _getPlacemarkObjects(BuildContext context) {
    return points.map(
          (point) => PlacemarkMapObject(
        mapId: MapObjectId('MapObject $point'),
        point: Point(latitude: point.latitude, longitude: point.longitude),
        opacity: 1,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage(AppAssets.marker), scale: 2),
        ),
      ),
    )
        .toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YandexMap(
        mapObjects: [_getClusterizedCollection(placemarks: _getPlacemarkObjects(context))],
        onMapCreated: (controller) async {
          yandexMapController = controller;
          onMapCreated();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 0.35.sh),
        child: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: Colors.white,
          onPressed: () {
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
