import 'package:flutter/material.dart';
import 'package:health_club/data/network/model/forecast_response.dart';
import 'package:health_club/design_system/design_system.dart';

class DetailedProgressCard extends StatelessWidget {
  final ForecastResponse forecast;
  const DetailedProgressCard({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.primaryColor.withValues(alpha: 0.06),
            offset: const Offset(0, 8),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Подробный прогресс',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
          ),
          20.height,

          _ProgressRow(
            icon: SvgPicture.asset(AppAssets.calendarMonth),
            label: 'Процент жира в организме',
            current: forecast.startTargetBodyFatPercent ?? 0,
            total: forecast.finalTargetBodyFatPercent ?? 0,
            color: ThemeColors.statusOrange,
          ),

          20.height,

          _ProgressRow(
            icon: SvgPicture.asset(AppAssets.calendarMonth),
            label: 'Мышечная масса, кг',
            current: forecast.startTargetMuscleMassKg ?? 0,
            total: forecast.finalTargetMuscleMassKg ?? 0,
            color: ThemeColors.statusBlue,
          ),

          20.height,

          _ProgressRow(
            icon: SvgPicture.asset(AppAssets.calendarMonth),
            label: 'Общая масса, кг',
            current: forecast.startTargetTotalWeightKg ?? 0,
            total: forecast.finalTargetTotalWeightKg ?? 0,
            color: ThemeColors.statusYellow,
          ),

          20.height,

          _ProgressRow(
            icon: SvgPicture.asset(AppAssets.achievement),
            label: 'Порог возврата средств при окончательном обращении, кг',
            current: forecast.startContractRefundThresholdKg ?? 0,
            total: forecast.finalContractRefundThresholdKg ?? 0,
            color: ThemeColors.statusGreen,
          ),
        ],
      ),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  final Widget icon;
  final String label;
  final num current;
  final num total;
  final Color color;

  const _ProgressRow({
    required this.icon,
    required this.label,
    required this.current,
    required this.total,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = total == 0 ? 0 : current / total;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        10.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$label: $current/$total',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: ThemeColors.base400),
              ),
              6.height,

              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Stack(
                  children: [
                    Container(height: 6, color: const Color(0xFFF0F1F5)),
                    FractionallySizedBox(
                      widthFactor: progress.clamp(0, 1),
                      child: Container(height: 6, color: color),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
