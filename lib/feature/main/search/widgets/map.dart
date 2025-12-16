import 'package:flutter/material.dart';
import 'package:health_club/design_system/components/app_assets.dart';
import 'package:health_club/feature/main/search/widgets/cluster.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final YandexMapController _mapController;
  var _mapZoom = 0.0;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Yandex Mapkit Demo')),
      body: YandexMap(
        onMapCreated: (controller) async {
          _mapController = controller;
          await _mapController.moveCamera(
            CameraUpdate.newCameraPosition(const CameraPosition(target: Point(latitude: 50, longitude: 20), zoom: 3)),
          );
        },
        onCameraPositionChanged: (cameraPosition, _, __) {
          setState(() {
            _mapZoom = cameraPosition.zoom;
          });
        },
        mapObjects: [_getClusterizedCollection(placemarks: _getPlacemarkObjects(context))],
      ),
    );
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
        await _mapController.moveCamera(
          animation: const MapAnimation(type: MapAnimationType.linear, duration: 0.3),
          CameraUpdate.newCameraPosition(CameraPosition(target: cluster.placemarks.first.point, zoom: _mapZoom + 1)),
        );
      },
    );
  }
}

List<Point> _getMapPoints() {
  return const [
    Point(latitude: 55.755864, longitude: 37.617698),
    Point(latitude: 51.507351, longitude: -0.127696),
    Point(latitude: 41.887064, longitude: 12.504809),
    Point(latitude: 48.856663, longitude: 2.351556),
    Point(latitude: 59.347360, longitude: 18.341573),
  ];
}

List<PlacemarkMapObject> _getPlacemarkObjects(BuildContext context) {
  return _getMapPoints()
      .map(
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
