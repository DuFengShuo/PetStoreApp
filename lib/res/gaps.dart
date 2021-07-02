import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:local_life_app/res/colors.dart';
import 'package:local_life_app/res/dimens.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 间隔
/// 官方做法：https://github.com/flutter/flutter/pull/54394
class Gaps {
  /// 水平间隔
  static Widget hGap4 = SizedBox(width: Dimens.gap_dp4.w);
  static Widget hGap5 = SizedBox(width: Dimens.gap_dp5.w);
  static Widget hGap8 = SizedBox(width: Dimens.gap_dp8.w);
  static Widget hGap10 = SizedBox(width: Dimens.gap_dp10.w);
  static Widget hGap12 = SizedBox(width: Dimens.gap_dp12.w);
  static Widget hGap15 = SizedBox(width: Dimens.gap_dp15.w);
  static Widget hGap16 = SizedBox(width: Dimens.gap_dp16.w);
  static Widget hGap32 = SizedBox(width: Dimens.gap_dp32.w);
  static Widget hGap40 = SizedBox(width: Dimens.gap_dp40.w);

  /// 垂直间隔
  static Widget vGap2 = SizedBox(height: Dimens.gap_dp2.h);
  static Widget vGap4 = SizedBox(height: Dimens.gap_dp4.h);
  static Widget vGap5 = SizedBox(height: Dimens.gap_dp5.h);
  static Widget vGap8 = SizedBox(height: Dimens.gap_dp8.h);
  static Widget vGap10 = SizedBox(height: Dimens.gap_dp10.h);
  static Widget vGap12 = SizedBox(height: Dimens.gap_dp12.h);
  static Widget vGap14 = SizedBox(height: Dimens.gap_dp14.h);
  static Widget vGap15 = SizedBox(height: Dimens.gap_dp15.h);
  static Widget vGap16 = SizedBox(height: Dimens.gap_dp16.h);
  static Widget vGap18 = SizedBox(height: Dimens.gap_dp18.h);
  static Widget vGap24 = SizedBox(height: Dimens.gap_dp24.h);
  static Widget vGap20 = SizedBox(height: Dimens.gap_dp20.h);
  static Widget vGap32 = SizedBox(height: Dimens.gap_dp32.h);
  static Widget vGap40 = SizedBox(height: Dimens.gap_dp40.h);
  static Widget vGap50 = SizedBox(height: Dimens.gap_dp50.h);

  static Widget lineV = SizedBox(
    height: 5.0.h,
    width: double.infinity,
    child: LineMargin(),
  );

  static Widget line = Divider(
    height: 1.h,
    color: Colours.line,
  );

  static Widget vLine = SizedBox(
    width: 1.w,
    height: 24.0.h,
    child: VerticalDivider(),
  );

  static Widget empty = SizedBox.shrink();
}

class LineMargin extends StatelessWidget {
  LineMargin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            color:  Color(0xFFF5F5F7)));
  }
}
