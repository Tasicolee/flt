import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/toast_utils.dart';
import 'package:gesture_password/gesture_password/gesture_view.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sp_util/sp_util.dart';

import '../../../../../res/constant.dart';
import '../../../../../util/other_utils.dart';
import '../../../../utils/pp_global.dart';

/// 手势锁
class PpPwdLockGesturePage extends StatefulWidget {
  const PpPwdLockGesturePage({super.key});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PpPwdLockGesturePage> {
  @override
  void initState() {
    super.initState();
    isOpenPpPwdLockGesturePage = true;
  }

  @override
  void dispose() {
    isOpenPpPwdLockGesturePage = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () async {
        return false; //不退出
      },
      child: _body());

  Scaffold _body() => Scaffold(
      backgroundColor: Colours.app_main_bg,
      body: Column(
            children: [
              Gaps.vGap80,
              Images.pp_logo_circle60,
              Gaps.vGap20,
              const Text(
                '输入手势密码',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
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
              ),
              Gaps.vGap50,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: const Text(
                      '面容ID解锁',
                      style: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 14,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () {
                      _faceId();
                    },
                  ),
                  Gaps.hGap10,
                  Container(
                    width: 2,
                    height: 15,
                    color: const Color(0xFF999999),
                  ),
                  Gaps.hGap10,
                  GestureDetector(
                    child: const Text(
                      '账号登录',
                      style: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 14,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () => goPpLoginPageSavePage(context),
                  ),
                ],
              ),
            ],
          ));

  Future<void> _onFinishGesture(List<int> result) async {
    if (result.length < 5) {
      Toast.show('最少选择5个点');
    }
    final str = SpUtil.getString(Constant.app_pwd_lock_number_string);
    if (str == result.toString()) {
      goBackLastPage(context);
    } else {
      Toast.show('手势密码错误');
    }
  }

  void _showDialog() => showElasticDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Material(
        color: Colours.app_main_bg,
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            height: 140,
            constraints:
            const BoxConstraints(minHeight: 100, minWidth: 100),
            margin: const EdgeInsets.only(
                left: 50, right: 50, top: 150, bottom: 50),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Column(
              children: [
                Gaps.vGap20,
                const Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        '请先在首页-头像-账号安全-\n面容ID解锁中开启',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF272729),
                          fontSize: 16,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ),
                Gaps.vGap20,
                SizedBox(
                  height: 44,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => goBackLastPage(context),
                                child: Container(
                                  height: 44,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 11),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        strokeAlign:
                                        BorderSide.strokeAlignCenter,
                                        color: Color(0xFFE5E6EB),
                                      ),
                                      top: BorderSide(
                                        strokeAlign:
                                        BorderSide.strokeAlignCenter,
                                        color: Color(0xFFE5E6EB),
                                      ),
                                      right: BorderSide(
                                        strokeAlign:
                                        BorderSide.strokeAlignCenter,
                                        color: Color(0xFFE5E6EB),
                                      ),
                                      bottom: BorderSide(
                                        strokeAlign:
                                        BorderSide.strokeAlignCenter,
                                        color: Color(0xFFE5E6EB),
                                      ),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 22,
                                              child: Text(
                                                '我知道了',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xFF0083FB),
                                                  fontSize: 16,
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  void _faceId() {
    final pwdFace = SpUtil.getString(Constant.app_pwd_lock_face_string);
    if (pwdFace?.isNotEmpty == true) {
      _faceIdSave();
    } else {
      _showDialog();
    }
  }

  Future<void> _faceIdSave() async {
    final LocalAuthentication auth = LocalAuthentication();
    // 要检查此设备上是否有可用的本地身份验证，请调用canCheckBiometrics
    // （如果您需要生物识别支持）和/或 isDeviceSupported()（如果您只需要一些设备级身份验证
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    if (!canAuthenticate) {
      Toast.show('设备暂不支持');
      return;
    }

    try {
      final bool didAuthenticate =
      await auth.authenticate(localizedReason: '我们需要验证您的指纹');
      if (didAuthenticate) {
        goBackLastPage(context);
      }
    } on PlatformException {
      Toast.show('暂未成功,请稍后再试');
    }

    // final List<BiometricType> availableBiometrics =
    //     await auth.getAvailableBiometrics();
    //
    // if (availableBiometrics.isNotEmpty) {
    //   // Some biometrics are enrolled.
    // }

    // if (availableBiometrics.contains(BiometricType.strong) ||
    //     availableBiometrics.contains(BiometricType.face)) {
    //   // Specific types of biometrics are available.
    //   // Use checks like this with caution!
    // }
  }
}
