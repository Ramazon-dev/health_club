import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';
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
          BlocBuilder<MapPointsCubit, MapPointsState>(
            builder: (context, state) {
              if (state is MapPointsLoaded) {
                return SearchBottomSheet(
                  mapPointsCubit: context.read<MapPointsCubit>(),
                  mapPointDetailCubit: context.read<MapPointDetailCubit>(),
                  mapPoints: state.points,
                  listOfCategories: state.listOfCategories,
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
