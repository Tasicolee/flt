import 'package:flutter_deer/pp/utils/pp_global.dart';
import 'package:sp_util/sp_util.dart';

import '../../res/constant.dart';
import '../dio/pp_httpclient.dart';
import '../dio/pp_url_config.dart';

Future<void> qiniuToken() async =>
    PPHttpClient().get(PpUrlConfig.qiniuToken, data: {}, onSuccess: (jsonMap) {
      final token = jsonMap['data']['token'].toString();
      final qiniuDomain = jsonMap['data']['qiniu_domain'].toString();
      SpUtil.putString(Constant.qiniuToken, token);
      SpUtil.putString(Constant.qiniu_domain, qiniuDomain);
    }, onError: (code, msg) {});

Future<void> getUserInfo() async {
  PPHttpClient().get(PpUrlConfig.user, data: {}, onSuccess: (jsonMap) {
    ppUserEntityGlobal?.id = jsonMap['data']['id'].toString();
    ppUserEntityGlobal?.name = jsonMap['data']['name'].toString();
    ppUserEntityGlobal?.account = jsonMap['data']['account'].toString();
    ppUserEntityGlobal?.avatar = jsonMap['data']['avatar'].toString();
    ppUserEntityGlobal?.account_balance =
        jsonMap['data']['account_balance'].toString();
    ppUserEntityGlobal?.account_balance_frozen =
        jsonMap['data']['account_balance_frozen'].toString();
    ppUserEntityGlobal?.wallet_code = jsonMap['data']['wallet_code'].toString();
    ppUserEntityGlobal?.id_number = jsonMap['data']['id_number'].toString();
    ppUserEntityGlobal?.email = jsonMap['data']['email'].toString();
    ppUserEntityGlobal?.birthday = jsonMap['data']['birthday'].toString();
    ppUserEntityGlobal?.register_ip = jsonMap['data']['register_ip'].toString();
    ppUserEntityGlobal?.real_name = jsonMap['data']['real_name'].toString();
    ppUserEntityGlobal?.can_recharge =
        jsonMap['data']['can_recharge'].toString();
    ppUserEntityGlobal?.can_withdraw =
        jsonMap['data']['can_withdraw'].toString();
    ppUserEntityGlobal?.is_avatar_change =
        jsonMap['data']['is_avatar_change'].toString();
    ppUserEntityGlobal?.created_at = jsonMap['data']['created_at'].toString();
    ppUserEntityGlobal?.updated_at = jsonMap['data']['updated_at'].toString();
    ppUserEntityGlobal?.is_real_name =
        jsonMap['data']['is_real_name'].toString();

    SpUtil.putBool(Constant.isLogin, true);
  }, onError: (code, msg) {});
}

void getBillType() =>
    PPHttpClient().get(PpUrlConfig.billType, onSuccess: (jsonMap) {
      billTypeGlobal = jsonMap['data'];
    }, onError: (code, msg) {});

/// refresh_token
Future<void> refresh_token() async {
  if (authorizationGlobal.isNotEmpty) {
    PPHttpClient().get(PpUrlConfig.refresh_token, onSuccess: (jsonMap) {
      final String authorization = jsonMap['data']['authorization'].toString();
      SpUtil.putString(Constant.authorization, authorization);
      authorizationGlobal = authorization;
    }, onError: (code, msg) {});
  }
}

Future<void> sys_configKefu() async => PPHttpClient()
        .get(PpUrlConfig.sys_config, data: {'code': 'customer_service_address'},
            onSuccess: (jsonMap) async {
      customerServiceAddress = jsonMap['data']['value'].toString();
    }, onError: (code, msg) {});

Future<void> sys_config_transfer_fee() async =>
    PPHttpClient().get(PpUrlConfig.sys_config, data: {'code': 'transfer_fee'},
        onSuccess: (jsonMap) async {
      transfer_fee = jsonMap['data']['value'].toString();
    }, onError: (code, msg) {});

Future<void> sys_config_login() async =>
    PPHttpClient().get(PpUrlConfig.sys_config, data: {'code': 'login_err_num'},
        onSuccess: (jsonMap) async {
      String st = jsonMap['data']['value'].toString();
      if (st.isNotEmpty && st != 'null') login_err_num = st;
    }, onError: (code, msg) {});

/// 手持身份证 手持身份证审核开关,1:代表需要手持身份证 0:代表不需要
Future<void> sys_config_hold_idcard_verification_switch() async =>
    PPHttpClient().get(PpUrlConfig.sys_config,
        data: {'code': 'hold_idcard_verification_switch'},
        onSuccess: (jsonMap) async {
      hold_idcard_verification_switch = jsonMap['data']['value'].toString();
    }, onError: (code, msg) {});

/// 首页弹窗模式配置:0：每次登录都弹 1:首次使用app登录时才弹
Future<void> sys_config_popup_notice_mode() async => PPHttpClient()
        .get(PpUrlConfig.sys_config, data: {'code': 'popup_notice_mode'},
            onSuccess: (jsonMap) async {
      popup_notice_mode = jsonMap['data']['value'].toString();
    }, onError: (code, msg) {});
