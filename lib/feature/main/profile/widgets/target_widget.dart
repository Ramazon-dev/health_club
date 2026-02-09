import 'package:flutter/material.dart';
import 'package:health_club/design_system/design_system.dart';
import 'package:health_club/domain/core/core.dart';

import '../../../../app_bloc/app_bloc.dart';
import '../../../../data/network/model/auth/wizard_options_response.dart';
import '../../../../data/network/model/profile_response.dart';
import '../../../auth/pages/register_page.dart';

class TargetWidget extends StatefulWidget {
  final ProfileResponse profile;

  const TargetWidget({super.key, required this.profile});

  @override
  State<TargetWidget> createState() => _TargetWidgetState();
}

class _TargetWidgetState extends State<TargetWidget> {
  final ValueNotifier<bool> targetVisibleNotifier = ValueNotifier(false);
  final otherTargetController = TextEditingController();
  ValueNotifier<WizardOptionResponse?> selectedTargetNotifier = ValueNotifier(null);
  bool showOtherTarget = false;
  late final String target;

  @override
  void initState() {
    final goal = widget.profile.goals;
    if (goal != null) {
      if (goal.selected.isNotEmpty) {
        target = goal.selected.toString().replaceAll('[', '').replaceAll(']', '');
      } else if (goal.customText != null) {
        target = goal.customText ?? 'Цель не выбрана';
      } else {
        target = 'Цель не выбрана';
      }
    } else {
      target = 'Цель не выбрана';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForecastCubit, ForecastState>(
      builder: (context, forecastState) {
        if (forecastState is! ForecastLoaded) return SizedBox();
        final forecast = forecastState.forecast;
        return Container(
          width: 1.sw,
          padding: EdgeInsets.all(15.r),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Color(0x33ffffff)),
          child: ValueListenableBuilder(
            valueListenable: targetVisibleNotifier,
            builder: (context, isVisible, child) => InkWell(
              onTap: () {
                targetVisibleNotifier.value = !isVisible;
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.target),
                      SizedBox(width: 10.r),
                      Expanded(
                        child: Text(
                          target,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                      ),
                      if (isVisible)
                        Icon(Icons.keyboard_arrow_up, color: Colors.white)
                      else
                        Icon(Icons.keyboard_arrow_down, color: Colors.white),
                    ],
                  ),
                  if (isVisible) ...[
                    if (widget.profile.goals == null) ...[
                      BlocConsumer<TargetCubit, TargetState>(
                        listener: (context, state) async {
                          if (state is TargetSuccess) {
                            context.read<ProfileCubit>().fetchProfile();
                            await CustomSneakBar.show(
                              context: context,
                              status: SneakBarStatus.success,
                              title: 'Цель успешно выбран',
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is TargetLoaded) {
                            return ValueListenableBuilder(
                              valueListenable: selectedTargetNotifier,
                              builder: (context, selectedTarget, child) => Column(
                                children: [
                                  20.height,
                                  MessageItem(
                                    text:
                                        'Давайте определимся с главными целями. Что для вас сейчас важнее всего? К чему лежит душа?',
                                    boxColor: Colors.white,
                                    textColor: ThemeColors.baseBlack,
                                  ),
                                  20.height,
                                  ListView.separated(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final target = state.targets[index];
                                      return GestureDetector(
                                        onTap: () {
                                          selectedTargetNotifier.value = target;
                                          showOtherTarget = target.text == 'Другое';
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(8.r),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.r),
                                            color: ThemeColors.white50,
                                            border: Border.all(
                                              width: 2,
                                              color: selectedTarget?.text == target.text
                                                  ? ThemeColors.baseBlack
                                                  : ThemeColors.white50,
                                            ),
                                          ),
                                          child: Text(
                                            target.text ?? '',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                              color: ThemeColors.baseBlack,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) => SizedBox(height: 10.h),
                                    itemCount: state.targets.length,
                                  ),
                                  if (selectedTarget != null && selectedTarget.text != 'Другое') ...[
                                    20.height,
                                    MessageItem(
                                      text: selectedTarget.answer ?? '',
                                      boxColor: Colors.white,
                                      textColor: ThemeColors.baseBlack,
                                    ),
                                  ],
                                  if (showOtherTarget) ...[
                                    20.height,
                                    TextFormField(
                                      controller: otherTargetController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Опишите, что вас беспокоит',
                                        hintStyle: TextStyle(color: ThemeColors.black400),
                                      ),
                                    ),
                                  ],
                                  20.height,
                                  SecondaryButton(
                                    text: 'Подтвердить',
                                    onPressed: () {
                                      final cubit = context.read<TargetCubit>();
                                      if (selectedTargetNotifier.value != null) {
                                        if (!showOtherTarget) {
                                          cubit.uploadTarget(
                                            selectedTargets: [selectedTargetNotifier.value?.text ?? ''],
                                          );
                                        } else if (showOtherTarget && otherTargetController.text.isNotEmpty) {
                                          cubit.uploadTarget(customText: otherTargetController.text);
                                        } else if (showOtherTarget && otherTargetController.text.isEmpty) {
                                          context.showSnackBar('Введите какие у вас цель');
                                        }
                                      } else {
                                        context.showSnackBar('Выберите цель');
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    ] else ...[
                      20.height,
                      if (forecast.start?.date != null) ...[
                        Row(
                          children: [
                            10.width,
                            Text(
                              'Начало: ${forecast.start?.date?.dateFormat()}',
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white),
                            ),
                          ],
                        ),
                        10.height,
                      ],
                      if (forecast.current?.date != null) ...[
                        Row(
                          children: [
                            10.width,
                            Text(
                              'Последняя обновления: ${forecast.current?.date?.dateFormat()}',
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white),
                            ),
                          ],
                        ),
                        20.height,
                      ],
                      _ProgressRow(
                        label: 'Процент жира',
                        current: forecast.current?.fatPercent ?? 0,
                        start: forecast.start?.fatPercent ?? 0,
                        total: forecast.target?.targetBodyFatPercent ?? 0,
                        color: ThemeColors.statusOrange,
                      ),
                      10.height,
                      _ProgressRow(
                        label: 'Мышечная масса',
                        current: forecast.current?.muscleMassKg ?? 0,
                        start: forecast.start?.muscleMassKg ?? 0,
                        total: forecast.target?.targetMuscleMassKg ?? 0,
                        color: ThemeColors.statusBlue,
                      ),

                      10.height,
                      _ProgressRow(
                        label: 'Общая масса',
                        current: forecast.current?.weightKg ?? 0,
                        start: forecast.start?.weightKg ?? 0,
                        total: forecast.target?.targetTotalWeightKg ?? 0,
                        color: ThemeColors.statusYellow,
                      ),
                      20.height,
                    ],
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ProgressRow extends StatelessWidget {
  final String label;
  final num start;
  final num current;
  final num total;
  final Color color;

  const _ProgressRow({
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
        10.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$label: $current',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.white),
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
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                  Text(
                    'Цель: $total',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white),
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
