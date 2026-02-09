import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:health_club/app_bloc/app_bloc.dart';

import '../../../../design_system/design_system.dart';

@RoutePage()
class BodyHistoryPage extends StatefulWidget {
  const BodyHistoryPage({super.key});

  @override
  State<BodyHistoryPage> createState() => _BodyHistoryPageState();
}

class _BodyHistoryPageState extends State<BodyHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(
        title: Text(
          'История состава тела',
          style: TextStyle(color: ThemeColors.baseBlack, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        showDivider: true,
      ),
      body: BlocBuilder<BodyCompositionHistoryCubit, BodyCompositionHistoryState>(
        builder: (context, state) {
          if (state is BodyCompositionHistoryLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (state is BodyCompositionHistoryError) {
            return Center(child: Text(state.message ?? ''));
          } else if (state is BodyCompositionHistoryLoaded) {
            final bodyCompositionHistory = state.bodyCompositionHistory;
            return ListView.separated(
              padding: EdgeInsetsGeometry.only(
                top: 15.r,
                left: 15.r,
                right: 15.r,
                bottom: kBottomNavigationBarHeight * 2,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final bodyComposition = bodyCompositionHistory[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bodyComposition.date ?? '',
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400, color: ThemeColors.baseBlack),
                    ),
                    16.height,
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final body = bodyComposition.bodyCompositions[index];
                        return Container(
                          padding: EdgeInsets.all(15.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(color: ThemeColors.base200),
                            color: ThemeColors.base50,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  if (body.weight != null)
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Вес:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp,
                                              color: ThemeColors.base400,
                                            ),
                                          ),
                                          4.height,
                                          Text(
                                            '${body.weight} kg',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.sp,
                                              color: ThemeColors.black950,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (body.fatPercent != null)
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Жир (%):',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp,
                                              color: ThemeColors.base400,
                                            ),
                                          ),
                                          4.height,
                                          Text(
                                            '${body.fatPercent ?? ''}%',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.sp,
                                              color: ThemeColors.black950,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              20.height,
                              Row(
                                children: [
                                  if (body.muscleMass != null)
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Мышцы:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp,
                                              color: ThemeColors.base400,
                                            ),
                                          ),
                                          4.height,
                                          Text(
                                            '${body.muscleMass ?? ''} kg',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.sp,
                                              color: ThemeColors.black950,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (body.visceralFat != null)
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Висцеральный жир:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp,
                                              color: ThemeColors.base400,
                                            ),
                                          ),
                                          4.height,
                                          Text(
                                            '${body.visceralFat}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.sp,
                                              color: ThemeColors.black950,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              if (body.metabolicAge != null) ...[
                                20.height,
                                Text(
                                  'Метаболический возраст:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: ThemeColors.base400,
                                  ),
                                ),
                                4.height,
                                Text(
                                  '${body.metabolicAge}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                    color: ThemeColors.black950,
                                  ),
                                ),
                              ],
                              // 20.height,
                              // ButtonWithScale(
                              //   // isLoading: isLoading,
                              //   // onPressed: () {},
                              //   onPressed: () {
                              //     context.router.maybePop();
                              //   },
                              //   text: 'Скачать ТАниту (.PDF)',
                              // ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => 16.height,
                      itemCount: bodyComposition.bodyCompositions.length,
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => 16.height,
              itemCount: bodyCompositionHistory.length,
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
