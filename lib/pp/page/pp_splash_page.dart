import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/pp/utils/pp_user_utils.dart';
import 'package:flutter_deer/res/colors.dart';
import 'package:flutter_deer/res/constant.dart';
import 'package:flutter_deer/util/device_utils.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/widgets/fractionally_aligned_sized_box.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sp_util/sp_util.dart';

import '../../util/toast_utils.dart';
import '../utils/pp_global.dart';

class PpSplashPage extends StatefulWidget {
  const PpSplashPage({super.key});

  @override
  _PpSplashPageState createState() => _PpSplashPageState();
}

class _PpSplashPageState extends State<PpSplashPage> {
  int _status = 0;
  final List<String> _guideList = [
    'pp_app_start_1',
    'pp_app_start_2',
    'pp_app_start_3'
  ];
  StreamSubscription<dynamic>? _subscription;

  @override
  void initState() {
    authorizationGlobal = SpUtil.getString(Constant.authorization).toString();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /// 两种初始化方案，另一种见 main.dart
      /// 两种方法各有优劣
      await SpUtil.getInstance();
      await Device.initDeviceInfo();
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)!) {
        /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
        void precacheImages(String image) {
          precacheImage(
              ImageUtils.getAssetImage(image, format: ImageFormat.webp),
              context);
        }

        _guideList.forEach(precacheImages);
      }
      _initSplash();
    });
    refresh_token();
    _initJg();
    getBillType();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  void _initSplash() {
    _subscription =
        Stream.value(1).delay(const Duration(milliseconds: 1500)).listen((_) {
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)! ||
          Constant.isDriverTest) {
        SpUtil.putBool(Constant.keyGuide, false);
        _initGuide();
      } else if (SpUtil.getBool(Constant.isLogin) == false) {
        goPpLoginPage(context);
      } else {
        SpUtil.putBool(Constant.isLogin, true);
        _goMain();
      }
    });
  }

  @override
  Widget build(BuildContext context) => Material(
      color: Colours.app_main_bg,
      child: _status == 0
          ? const FractionallyAlignedSizedBox(
              heightFactor: 1,
              widthFactor: 1,
              leftFactor: 1,
              bottomFactor: 0,
              child: LoadAssetImage('pp_bg_start', fit: BoxFit.fill))
          : Swiper(
              key: const Key('swiper'),
              itemCount: _guideList.length,
              loop: false,
              itemBuilder: (_, index) {
                return LoadAssetImage(
                  _guideList[index],
                  key: Key(_guideList[index]),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  format: ImageFormat.webp,
                );
              },
              onTap: (index) {
                if (index == _guideList.length - 1) {
                  goPpLoginPage(context);
                }
              },
            ));

  void _goMain() {
    final pwd = SpUtil.getString(Constant.app_pwd_lock_number_string);
    final isOpen = SpUtil.getBool(Constant.app_pwd_lock_number_open_bool);
    final needPwd = isOpen == true && pwd != null && pwd.isNotEmpty;
    goPPHomeTabPageFast(context, isRefresh: true, needPwd: needPwd);
  }

  /**
   * 1	身份认证审核通过
      2	未确认超时系统放行
      3	买家已完成付款
      4	卖家已放行
   */

  ///
  Future<void> _initJg() async {
    final JPush jpush = JPush();
    jpush.setup(
      appKey: 'bf5f9248cb2f57f7b57e99c6',
      channel: 'theChannel',
      production: false,
      debug: true, // 设置是否打印 debug 日志
    );
    jpush.addEventHandler(
      onReceiveNotification: (Map<String, dynamic> message) async {
        // 收到消息时调用此方法
      },
      onOpenNotification: (Map<String, dynamic> message) async {
        //设置角标
        jpush.setBadge(0);
        // //点击通知栏消息，在此时通常可以做一些页面跳转等
        // debugPrint('------$message');
        final extra = message['extras']['cn.jpush.android.EXTRA'].toString();
        debugPrint('------$extra');
        //点击通知栏消息，在此时通常可以做一些页面跳转等
        final jsonMap = jsonDecode(extra);
        final code = jsonMap['code']; //key是推送附件字段配置的key
        debugPrint('code:$code');
        if (code == '1') {
          goPpAuthSuccessPage(appContext!);
        } else if (code == '2') {
          goPpBuyOrderListPage(appContext!);
        } else if (code == '3') {
          goPpBuyOrderListPage(appContext!);
        } else if (code == '4') {
          goPpBuyOrderListPage(appContext!);
        } else {
          goPpBuyOrderListPage(appContext!);
        }
        if (Platform.isAndroid) {
          Toast.show(message.toString());
        } else if (Platform.isIOS) {
          Toast.show(message.toString());
        }
      },
    );
    jPushGetRegistrationID = await jpush.getRegistrationID();
  }
}
