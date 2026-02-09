import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/data/network/model/dashboard_metrics_response.dart';
import 'package:health_club/domain/core/core.dart';
import '../../../app_bloc/app_bloc.dart';
import '../../../data/network/model/history/metric_history_response.dart';
import '../../../design_system/design_system.dart';

@RoutePage()
class AwardsHistoryPage extends StatefulWidget {
  final MetricsEnum metricsEnum;

  const AwardsHistoryPage({super.key, required this.metricsEnum});

  @override
  State<AwardsHistoryPage> createState() => _AwardsHistoryPageState();
}

class _AwardsHistoryPageState extends State<AwardsHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(
        title: Text(
          widget.metricsEnum.title,
          style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        showDivider: true,
      ),
      body: BlocBuilder<DashboardMetricsCubit, DashboardMetricsState>(
        builder: (context, dashboardMetricsState) {
          if (dashboardMetricsState is! DashboardMetricsLoaded) return SizedBox();
          final dashboardMetrics = dashboardMetricsState.dashboardMetrics;
          return BlocBuilder<MetricsHistoryCubit, MetricsHistoryState>(
            builder: (context, state) {
              if (state is! MetricsHistoryLoaded) return SizedBox();
              List<MetricHistoryResponse> list;
              switch (widget.metricsEnum) {
                case MetricsEnum.water:
                  list = state.water;
                case MetricsEnum.sleep:
                  list = state.sleep;
                case MetricsEnum.step:
                  list = state.steps;
              }
              return ListView.separated(
                padding: EdgeInsets.all(15.r),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = list[index];
                  return Container(
                    padding: EdgeInsets.all(15.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: ThemeColors.base200),
                      color: ThemeColors.base50,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.date?.dateFormat() ?? '',
                              style: TextStyle(
                                color: ThemeColors.baseBlack,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            10.height,
                            Text(
                              '${item.value ?? 0}',
                              style: TextStyle(
                                color: ThemeColors.baseBlack,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        getStatus((item.value ?? 0).toInt(), dashboardMetrics),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => 20.height,
                itemCount: list.length,
              );
            },
          );
        },
      ),
    );
  }

  getStatus(int value, DashboardMetricsResponse dashboardMetrics) {
    switch (widget.metricsEnum) {
      case MetricsEnum.water:
        return StatusWidget(norm: value > (dashboardMetrics.water?.norm ?? 0));
      case MetricsEnum.sleep:
        return StatusWidget(norm: value > (dashboardMetrics.sleep?.norm ?? 0));
      case MetricsEnum.step:
        return StatusWidget(norm: value > (dashboardMetrics.steps?.norm ?? 0));
    }
  }
}

class StatusWidget extends StatelessWidget {
  final bool norm;

  const StatusWidget({super.key, required this.norm});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: norm ? ThemeColors.statusGreen : Color(0x3311d564),
      ),
      child: Row(
        children: [
          if (norm) ...[
            Icon(Icons.done, color: Colors.white, size: 18.r),
            SizedBox(width: 5.r),
          ],
          Text(
            norm ? 'В норме' : 'Ниже номы',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: norm ? ThemeColors.white50 : Color(0xff11d564),
            ),
          ),
        ],
      ),
    );
  }
}
