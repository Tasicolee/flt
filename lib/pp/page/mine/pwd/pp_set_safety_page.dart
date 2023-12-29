import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:sp_util/sp_util.dart';

import '../../../../res/constant.dart';
import '../../../../util/toast_utils.dart';
import '../../../dio/pp_httpclient.dart';
import '../../../dio/pp_url_config.dart';
import '../../../utils/pp_global.dart';

/// 账号安全
class PpSafetyPage extends StatefulWidget {
  const PpSafetyPage({super.key});

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<PpSafetyPage> {
  bool _isHasPwdNumber = false;
  bool _isHasPwdFace = false;
  bool _isOpen = false;

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    final pwdNumber = SpUtil.getString(Constant.app_pwd_lock_number_string);
    final pwdFace = SpUtil.getString(Constant.app_pwd_lock_face_string);
    _isOpen = SpUtil.getBool(Constant.app_pwd_lock_number_open_bool)!;
    _isHasPwdNumber = pwdNumber?.isNotEmpty == true;
    _isHasPwdFace = pwdFace?.isNotEmpty == true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colours.app_main_bg,
        appBar: const MyAppBar(
            centerTitle: '账号安全', backgroundColor: Colours.app_main_bg),
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
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        goPpChangeLoginPasswordPage(context);
                      },
                      child: const Row(
                        children: <Widget>[
                          Images.pp_mine_list_4,
                          Gaps.hGap8,
                          Text(
                            '修改登陆密码',
                            style: TextStyles.txt16color272729,
                          ),
                          Expanded(child: Text('')),
                          Text(
                            '修改',
                            style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 14,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Gaps.hGap5,
                          Images.pp_mine_right_arrow,
                        ],
                      ),
                    ),
                    Gaps.vGap8,
                    Gaps.lineF6F6F6,
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        goPpChangePayPasswordPage(context);
                      },
                      child: const Row(
                        children: <Widget>[
                          Images.pp_mine_list_5,
                          Gaps.hGap8,
                          Text(
                            '修改支付密码',
                            style: TextStyles.txt16color272729,
                          ),
                          Expanded(child: Text('')),
                          Text(
                            '修改',
                            style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 14,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Gaps.hGap5,
                          Images.pp_mine_right_arrow,
                        ],
                      ),
                    ),
                    Gaps.vGap8,
                    Gaps.lineF6F6F6,
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        _goLock();
                      },
                      child: Row(
                        children: <Widget>[
                          Images.pp_mine_icon_number,
                          Gaps.hGap8,
                          const Text(
                            '手势锁',
                            style: TextStyles.txt16color272729,
                          ),
                          const Expanded(child: Text('')),
                          Text(_isHasPwdNumber && _isOpen ? '已开启' : '未开启',
                              style: TextStyle(
                                color: Color(_isHasPwdNumber && _isOpen
                                    ? 0xFF0083FB
                                    : 0xFF999999),
                                fontSize: 14,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                              )),
                          Gaps.hGap5,
                          Images.pp_mine_right_arrow,
                        ],
                      ),
                    ),
                    Gaps.vGap8,
                    Gaps.lineF6F6F6,
                    GestureDetector(
                      onTap: () => goPpPwdFaceModifyPage(context),
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        children: <Widget>[
                          Images.pp_mine_icon_face,
                          Gaps.hGap8,
                          const Text(
                            '面容ID解锁',
                            style: TextStyles.txt16color272729,
                          ),
                          const Expanded(child: Text('')),
                          Text(_isHasPwdFace ? '已开启' : '未开启',
                              style: TextStyle(
                                color: Color(
                                    _isHasPwdFace ? 0xFF0083FB : 0xFF999999),
                                fontSize: 14,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                              )),
                          Gaps.hGap5,
                          Images.pp_mine_right_arrow,
                        ],
                      ),
                    ),
                    Gaps.vGap8,
                  ],
                )),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _clickAuth(),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 20, top: 15, bottom: 15),
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                decoration: const BoxDecoration(
                    color: Colours.colorFFFFFF, //设置背景颜色
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Row(
                  children: <Widget>[
                    Images.pp_mine_list_1,
                    Gaps.hGap8,
                    const Text(
                      '身份认证',
                      style: TextStyles.txt16color272729,
                    ),
                    const Expanded(child: Text('')),
                    Text(
                        ppUserEntityGlobal?.is_real_name == '1' ? '已认证' : '未认证',
                        style: TextStyle(
                          color: Color(ppUserEntityGlobal?.is_real_name == '1'
                              ? 0xFF0083FB
                              : 0xFF999999),
                          fontSize: 14,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        )),
                    Gaps.hGap5,
                    Images.pp_mine_right_arrow,
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Future<void> _clickAuth() async {
    if (ppUserEntityGlobal?.is_real_name == '1') {
      goPpAuthSuccessPage(context);
    } else {
      _authenticationInfo();
    }
  }

  Future<void> _authenticationInfo() async =>
      PPHttpClient().get(PpUrlConfig.authenticationInfo,
          onSuccess: (jsonMap) async {
            if (jsonMap['data'] == null) {
              await goPpAuthenticationPage(context, false);
              _getUser();
            } else {
              // 0 待审核 1 审核通过 2 审核不通过
              final String is_approved =
                  jsonMap['data']['is_approved'].toString();
              final String reject_reason =
                  jsonMap['data']['reject_reason'].toString();
              if (is_approved == '0') {
                goPpAuthWaitPage(context);
              } else if (is_approved == '1') {
                ppUserEntityGlobal?.is_real_name = '1';
                goPpAuthSuccessPage(context);
              } else if (is_approved == '2') {
                goPpAuthFailPage(context, reject_reason);
              }
            }
          },
          onError: (code, msg) => Toast.show(msg + code));

  Future<void> _getUser() async =>
      PPHttpClient().get(PpUrlConfig.user, onSuccess: (jsonMap) {
        ppUserEntityGlobal?.id = jsonMap['data']['id'].toString();
        ppUserEntityGlobal?.name = jsonMap['data']['name'].toString();
        ppUserEntityGlobal?.account = jsonMap['data']['account'].toString();
        ppUserEntityGlobal?.avatar = jsonMap['data']['avatar'].toString();
        ppUserEntityGlobal?.account_balance =
            jsonMap['data']['account_balance'].toString();
        ppUserEntityGlobal?.account_balance_frozen =
            jsonMap['data']['account_balance_frozen'].toString();
        ppUserEntityGlobal?.wallet_code =
            jsonMap['data']['wallet_code'].toString();
        ppUserEntityGlobal?.id_number = jsonMap['data']['id_number'].toString();
        ppUserEntityGlobal?.email = jsonMap['data']['email'].toString();
        ppUserEntityGlobal?.birthday = jsonMap['data']['birthday'].toString();
        ppUserEntityGlobal?.register_ip =
            jsonMap['data']['register_ip'].toString();
        ppUserEntityGlobal?.real_name = jsonMap['data']['real_name'].toString();
        ppUserEntityGlobal?.can_recharge =
            jsonMap['data']['can_recharge'].toString();
        ppUserEntityGlobal?.can_withdraw =
            jsonMap['data']['can_withdraw'].toString();
        ppUserEntityGlobal?.is_avatar_change =
            jsonMap['data']['is_avatar_change'].toString();
        ppUserEntityGlobal?.created_at =
            jsonMap['data']['created_at'].toString();
        ppUserEntityGlobal?.updated_at =
            jsonMap['data']['updated_at'].toString();
        ppUserEntityGlobal?.is_real_name =
            jsonMap['data']['is_real_name'].toString();

        setState(() {});
      }, onError: (code, msg) {});

  Future<void> _goLock() async {
    if (_isHasPwdNumber) {
      await goPpPwdLockModifyPage(context);
    } else if (_isOpen) {
      await goPpPwdLockModifyPage(context);
    } else {
      await goPpPwdLockGestureSetHintPage(context);
    }
    _init();
  }
}
