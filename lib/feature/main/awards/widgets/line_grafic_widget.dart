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
            label: 'Процент жира',
            current: forecast.current?.fatPercent ?? 0,
            start: forecast.start?.fatPercent ?? 0,
            total: forecast.target?.targetBodyFatPercent ?? 0,
            color: ThemeColors.statusOrange,
          ),
          20.height,

          _ProgressRow(
            icon: SvgPicture.asset(AppAssets.calendarMonth),
            label: 'Мышечная масса',
            current: forecast.current?.muscleMassKg ?? 0,
            start: forecast.start?.muscleMassKg ?? 0,
            total: forecast.target?.targetMuscleMassKg ?? 0,
            color: ThemeColors.statusBlue,
          ),

          20.height,

          _ProgressRow(
            icon: SvgPicture.asset(AppAssets.calendarMonth),
            label: 'Общая масса',
            current: forecast.current?.weightKg ?? 0,
            start: forecast.start?.weightKg ?? 0,
            total: forecast.target?.targetTotalWeightKg ?? 0,
            color: ThemeColors.statusYellow,
          ),
          20.height,

          // _ProgressRow(
          //   icon: SvgPicture.asset(AppAssets.achievement),
          //   label: 'Порог возврата средств при окончательном обращении, кг',
          //   current: forecast.startContractRefundThresholdKg ?? 0,
          //   total: forecast.finalContractRefundThresholdKg ?? 0,
          //   color: ThemeColors.statusGreen,
          // ),
        ],
      ),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  final Widget icon;
  final String label;
  final num start;
  final num current;
  final num total;
  final Color color;

  const _ProgressRow({
    required this.icon,
    required this.label,
    required this.start,
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
              Text(
                '$label: $current',
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
              6.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Начало: $start',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
                  ),
                  Text(
                    'Цель: $total',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: ThemeColors.baseBlack),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
