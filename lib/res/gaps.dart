import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';

/// 间隔
/// 官方做法：https://github.com/flutter/flutter/pull/54394
class Gaps {
  /// 水平间隔
  static const Widget hGap0 = SizedBox(width: Dimens.gap_dp0);
  static const Widget hGap1 = SizedBox(width: Dimens.gap_dp1);
  static const Widget hGap2 = SizedBox(width: Dimens.gap_dp2);
  static const Widget hGap4 = SizedBox(width: Dimens.gap_dp4);
  static const Widget hGap5 = SizedBox(width: Dimens.gap_dp5);
  static const Widget hGap8 = SizedBox(width: Dimens.gap_dp8);
  static const Widget hGap10 = SizedBox(width: Dimens.gap_dp10);
  static const Widget hGap12 = SizedBox(width: Dimens.gap_dp12);
  static const Widget hGap15 = SizedBox(width: Dimens.gap_dp15);
  static const Widget hGap16 = SizedBox(width: Dimens.gap_dp16);
  static const Widget hGap20 = SizedBox(width: Dimens.gap_dp20);
  static const Widget hGap32 = SizedBox(width: Dimens.gap_dp32);
  static const Widget hGap100 = SizedBox(width: Dimens.gap_dp100);

  /// 垂直间隔
  static const Widget vGap0 = SizedBox(height: Dimens.gap_dp0);
  static const Widget vGap1 = SizedBox(height: Dimens.gap_dp1);
  static const Widget vGap4 = SizedBox(height: Dimens.gap_dp4);
  static const Widget vGap5 = SizedBox(height: Dimens.gap_dp5);
  static const Widget vGap8 = SizedBox(height: Dimens.gap_dp8);
  static const Widget vGap10 = SizedBox(height: Dimens.gap_dp10);
  static const Widget vGap12 = SizedBox(height: Dimens.gap_dp12);
  static const Widget vGap15 = SizedBox(height: Dimens.gap_dp15);
  static const Widget vGap16 = SizedBox(height: Dimens.gap_dp16);
  static const Widget vGap20 = SizedBox(height: Dimens.gap_dp20);
  static const Widget vGap24 = SizedBox(height: Dimens.gap_dp24);
  static const Widget vGap30 = SizedBox(height: Dimens.gap_dp30);
  static const Widget vGap32 = SizedBox(height: Dimens.gap_dp32);
  static const Widget vGap40 = SizedBox(height: Dimens.gap_dp40);
  static const Widget vGap50 = SizedBox(height: Dimens.gap_dp50);
  static const Widget vGap80 = SizedBox(height: Dimens.gap_dp80);
  static const Widget vGap100 = SizedBox(height: Dimens.gap_dp100);
  static const Widget vGap150 = SizedBox(height: Dimens.gap_dp150);
  static const Widget vGap300 = SizedBox(height: Dimens.gap_dp300);
  static const Widget vGap400 = SizedBox(height: Dimens.gap_dp400);

//  static Widget line = const SizedBox(
//    height: 0.6,
//    width: double.infinity,
//    child: const DecoratedBox(decoration: BoxDecoration(color: Colours.line)),
//  );

  static const Widget line = Divider();
  static const Widget lineF5F5F5 = Divider(
    color: Colours.colorF5F5F5,
  );
  static const Widget lineF6F6F6 = Divider(
    color: Colours.colorF6F6F6,
  );
  static const Widget vLine = SizedBox(
    width: 0.6,
    height: 24.0,
    child: VerticalDivider(),
  );

  static const Widget empty = SizedBox.shrink();

  /// 补充一种空Widget实现 https://github.com/letsar/nil
  /// https://github.com/flutter/flutter/issues/78159
}
