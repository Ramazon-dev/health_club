import 'package:flutter/material.dart';
import 'package:health_club/design_system/design_system.dart';

class ProfileProcessingWidget extends StatelessWidget {
  final int process;

  const ProfileProcessingWidget({super.key, required this.process});

  final percent = 16.666666666666668;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 160.h,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child:
                SvgPicture.asset(
                  AppAssets.progress,
                  colorFilter: ColorFilter.mode(Color(0xffF5F5F5), BlendMode.srcIn),
                ).gradient(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomLeft,
                    colors: [
                      if (process > 0 && process < percent) ...[
                        Color(0xfff5f5f5),
                        Color(0xff2d9994),
                      ] else if (process >= percent) ...[
                        Color(0xff2d9994),
                        Color(0xff2d9994),
                      ] else ...[
                        Color(0xffF5F5F5),
                        Color(0xffF5F5F5),
                      ],
                    ],
                  ),
                ),
          ),
          Positioned(
            left: 35.r,
            top: 40.h,
            child: Transform.rotate(
              angle: 0.5,
              child:
                  SvgPicture.asset(
                    AppAssets.progress,
                    colorFilter: ColorFilter.mode(Color(0xffF5F5F5), BlendMode.srcIn),
                  ).gradient(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomLeft,
                      colors: [
                        if (process > percent && process < percent * 2) ...[
                          Color(0xfff5f5f5),
                          Color(0xff2d9994),
                        ] else if (process >= percent * 2) ...[
                          Color(0xff2d9994),
                          Color(0xff2d9994),
                        ] else ...[
                          Color(0xffF5F5F5),
                          Color(0xffF5F5F5),
                        ]
                      ],
                    ),
                  ),
            ),
          ),
          Positioned(
            top: 5.h,
            left: 90.r,
            child: Transform.rotate(
              angle: 1,
              child:
                  SvgPicture.asset(
                    AppAssets.progress,
                    colorFilter: ColorFilter.mode(Color(0xffF5F5F5), BlendMode.srcIn),
                  ).gradient(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomLeft,
                      colors: [
                        if (process > percent * 2 && process < percent * 3) ...[
                          Color(0xfff5f5f5),
                          Color(0xff2d9994),
                        ] else if (process >= percent * 3) ...[
                          Color(0xff2d9994),
                          Color(0xff2d9994),
                        ] else ...[
                          Color(0xffF5F5F5),
                          Color(0xffF5F5F5),
                        ]
                      ],
                    ),
                  ),
            ),
          ),
          Positioned(
            top: 5.h,
            right: 90.r,
            child: Transform.rotate(
              angle: 1.6,
              child:
                  SvgPicture.asset(
                    AppAssets.progress,
                    colorFilter: ColorFilter.mode(Color(0xffF5F5F5), BlendMode.srcIn),
                  ).gradient(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomLeft,
                      colors: [
                        if (process > percent * 3 && process < percent * 4) ...[
                          Color(0xfff5f5f5),
                          Color(0xff2d9994),
                        ] else if (process >= percent * 4) ...[
                          Color(0xff2d9994),
                          Color(0xff2d9994),
                        ] else ...[
                          Color(0xffF5F5F5),
                          Color(0xffF5F5F5),
                        ],
                      ],
                    ),
                  ),
            ),
          ),
          Positioned(
            right: 33.r,
            top: 41.h,
            child: Transform.rotate(
              angle: 2.1,
              child:
                  SvgPicture.asset(
                    AppAssets.progress,
                    colorFilter: ColorFilter.mode(Color(0xffF5F5F5), BlendMode.srcIn),
                  ).gradient(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomLeft,
                      colors: [
                        if (process > percent * 4 && process < percent * 5) ...[
                          Color(0xfff5f5f5),
                          Color(0xff2d9994),
                        ] else
                          if (process >= percent * 5) ...[
                            Color(0xff2d9994),
                            Color(0xff2d9994),
                          ] else
                            ...[
                              Color(0xffF5F5F5),
                              Color(0xffF5F5F5),
                            ],
                      ],
                    ),
                  ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Transform.rotate(
              angle: 2.6,
              origin: Offset(0, 2),
              filterQuality: FilterQuality.low,
              child: SvgPicture.asset(
                AppAssets.progress,
                colorFilter: ColorFilter.mode(Color(0xffF5F5F5), BlendMode.srcIn),
              ).gradient(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  colors: [
                    if (process > percent * 5 && process < percent * 6) ...[
                      Color(0xfff5f5f5),
                      Color(0xff2d9994),
                    ] else
                      if (process >= percent * 6) ...[
                        Color(0xff2d9994),
                        Color(0xff2d9994),
                      ] else
                        ...[
                          Color(0xffF5F5F5),
                          Color(0xffF5F5F5),
                        ],
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              '$process%',
              style: TextStyle(fontSize: 48.sp, fontWeight: FontWeight.w500, color: ThemeColors.black950),
            ),
          ),
        ],
      ),
    );
  }
}

extension Extension on Widget {
  gradient({required Gradient gradient}) => ShaderMask(
    blendMode: BlendMode.srcIn,
    shaderCallback: (bounds) => gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
    child: this,
  );
}
