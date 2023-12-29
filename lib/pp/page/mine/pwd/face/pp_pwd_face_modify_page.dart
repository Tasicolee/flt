import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sp_util/sp_util.dart';

import '../../../../../res/constant.dart';
import '../../../../../util/toast_utils.dart';

/// 面容ID解锁修改
class PpPwdFaceModifyPage extends StatefulWidget {
  const PpPwdFaceModifyPage({super.key});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PpPwdFaceModifyPage> {
  bool _isOpenFace = false;
  bool _isOpenPwd = false;

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    _isOpenFace =
        SpUtil.getString(Constant.app_pwd_lock_face_string)?.isNotEmpty == true;
    _isOpenPwd = SpUtil.getBool(Constant.app_pwd_lock_face_replace_bool)!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colours.app_main_bg,
        appBar: const MyAppBar(
            centerTitle: '面容ID解锁', backgroundColor: Colours.app_main_bg),
        body: Column(
          children: <Widget>[
            Gaps.vGap20,
            Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 20, top: 15, bottom: 15),
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                decoration: const BoxDecoration(
                    color: Colours.colorFFFFFF, //设置背景颜色
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Gaps.hGap8,
                        const Text(
                          '面容ID解锁',
                          style: TextStyles.txt16color272729,
                        ),
                        const Expanded(child: Text('')),
                        MergeSemantics(
                          child: CupertinoSwitch(
                            value: _isOpenFace,
                            onChanged: (bool value) => _onChangedFace(value),
                          ),
                        ),
                      ],
                    ),
                    Gaps.vGap8,
                    Gaps.lineF6F6F6,
                    Row(
                      children: <Widget>[
                        Gaps.hGap8,
                        const Text(
                          '代替手势密码',
                          style: TextStyles.txt16color272729,
                        ),
                        const Expanded(child: Text('')),
                        MergeSemantics(
                          child: CupertinoSwitch(
                            value: _isOpenPwd,
                            onChanged: (bool value) => _onChangedPwd(value),
                          ),
                        ),
                      ],
                    ),
                    Gaps.vGap8,
                  ],
                )),
          ],
        ),
      );

  Future<void> _onChangedFace(bool value) async => _faceId(value);

  Future<void> _faceId(bool value) async {
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
        setState(() {
          _isOpenFace = value;
        });
        SpUtil.putString(Constant.app_pwd_lock_face_string, value.toString());
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

  void _onChangedPwd(bool value) {
    if (_isOpenFace) {
      setState(() {
        _isOpenPwd = value;
      });
      SpUtil.putBool(Constant.app_pwd_lock_face_replace_bool, value);
    } else {
      Toast.show('请先开启面容ID');
    }
  }
}
