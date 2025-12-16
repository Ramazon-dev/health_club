import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/feature/main/search/map_view.dart';
import 'widgets/search_bottom_sheet.dart';

@RoutePage()
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Stack(
        children: [
          MapView(),
          SearchBottomSheet(),
        ],
      ),
    );
  }
}
