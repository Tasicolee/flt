import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/toast_utils.dart';
import 'package:gesture_password/gesture_password/gesture_view.dart';
import 'package:sp_util/sp_util.dart';

import '../../../../../res/constant.dart';
import '../../../../../widgets/my_app_bar.dart';

/// 手势锁 关闭
class PpPwdLockGestureClosePage extends StatefulWidget {
  const PpPwdLockGestureClosePage({super.key});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PpPwdLockGestureClosePage> {
  bool _isNextError = false;

  @override
  Widget build(BuildContext context) => _body();

  Scaffold _body() => Scaffold(
      backgroundColor: Colours.app_main_bg,
      appBar: const MyAppBar(
          centerTitle: '关闭手势密码', backgroundColor: Colours.app_main_bg),
      body: Column(
        children: [
          Gaps.vGap50,
          Images.pp_pwd_lock_icon_small_hint,
          Gaps.vGap20,
          if (_isNextError)
            const Text(
              '密码错误，请重新绘制',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFF94E46),
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
                letterSpacing: 0.20,
              ),
            )
          else
            const Text(
              '请绘制当前手势密码',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
                letterSpacing: 0.20,
              ),
            ),
          Container(
            // width: double.infinity,
            // height: double.infinity,
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            // color: Colors.black12,
            child: GesturePasswordWidget(
              // 修改默认圆圈颜色
              color: const Color(0xFFD7D7D7),
              // 修改选择圆圈颜色
              highlightColor: Colours.colorA0BE4B,
              // 修改连线画笔颜色
              pathColor: Colours.colorA0BE4B,
              // 圆圈半径
              frameRadius: 25,
              // 圆圈中心点半径
              pointRadius: 4,
              // 连线画笔宽度
              pathWidth: 4,
              // 结果
              onFinishGesture: (result) {
                _onFinishGesture(result);
                debugPrint(result.toString());
              },
            ),
          )
        ],
      ));

  Future<void> _onFinishGesture(List<int> result) async {
    if (result.length < 5) {
      Toast.show('最少选择5个点');
    }
    final pwd = SpUtil.getString(Constant.app_pwd_lock_number_string);
    if (result.toString() != pwd) {
      _isNextError = true;
      setState(() {});
      return Toast.show('手势密码不正确');
    }
    SpUtil.putString(Constant.app_pwd_lock_number_string, '');
    Toast.show('关闭成功');
    goBackLastPage(context);
  }
}
