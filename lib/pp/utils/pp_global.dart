import 'package:flutter/cupertino.dart';
import 'package:flutter_deer/pp/utils/pp_user_bean.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

BuildContext? appContext;

String? jPushGetRegistrationID;

///用户token
String authorizationGlobal = '';

/// 客服地址
String? customerServiceAddress = '';

/// 手持身份证审核开关,1:代表需要手持身份证 0:代表不需要
String? hold_idcard_verification_switch = '';

/// 首页弹窗模式配置:0：每次登录都弹 1:首次使用app登录时才弹
String? popup_notice_mode = '';

///登录失败弹出验证码次数
String? login_err_num = '100';

/// transfer_fee	转账手续费，整数百分比%，比如5，代表5%	value
String? transfer_fee = '';

/// 锁屏页面打开
bool isOpenPpPwdLockGesturePage = false;

///用户
PpUserEntity? ppUserEntityGlobal = PpUserEntity();

/**
 *     "1": "卖家挂单冻结金额",
    "2": "人工上分",
    "3": "人工下分",
    "4": "卖家放行扣减卖家冻结金额",
    "5": "买家买分",
    "6": "转出",
    "7": "转入
 */

/// 账单类型
dynamic? billTypeGlobal;

bool isPpWeb() {
  const bool kIsWeb = bool.fromEnvironment('dart.library.js_util');
  return kIsWeb;
}
