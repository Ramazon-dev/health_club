import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizeExt on int {
  Widget get height => SizedBox(height: toDouble().h);

  Widget get width => SizedBox(width: toDouble().r);

  SliverToBoxAdapter get sliveredHeight => SliverToBoxAdapter(child: SizedBox(height: toDouble().h));

  SliverToBoxAdapter get sliveredWidth => SliverToBoxAdapter(child: SizedBox(width: toDouble().r));
}
