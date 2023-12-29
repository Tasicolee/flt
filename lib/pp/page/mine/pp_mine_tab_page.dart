import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:sp_util/sp_util.dart';

import '../../../res/constant.dart';
import '../../../util/other_utils.dart';
import '../../../util/toast_utils.dart';
import '../../dio/pp_httpclient.dart';
import '../../dio/pp_url_config.dart';
import '../../utils/pp_dialog_utils.dart';
import '../../utils/pp_global.dart';

///我的tab页面
class PpMineTabPage extends StatefulWidget {
  const PpMineTabPage({
    super.key,
    this.isAccessibilityTest = false,
  });

  final bool isAccessibilityTest;

  @override
  _PpMineTabPageState createState() => _PpMineTabPageState();
}

/**
 * 参数名	类型	说明
    account_balance	string	账户余额/可售余额
    account_balance_frozen	string	不可售余额/冻结金额
    sell_order_amount	string	卖单余额
    transaction_amount	string	交易中
 */
class _PpMineTabPageState extends State<PpMineTabPage> {
  String account_balance = '';
  String account_balance_frozen = '';
  String sell_order_amount = '';
  String transaction_amount = '';

  @override
  void initState() {
    _getUser();
    _accountInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colours.app_main_bg,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Gaps.vGap20,
              Row(
                children: [
                  Gaps.hGap20,
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Images.pp_back_top_left_page,
                    onTap: () => Navigator.pop(context),
                  ),
                  const Expanded(child: Text('')),
                  Column(
                    children: [
                      Gaps.vGap20,
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Images.pp_mine_my_code,
                        onTap: () => goPpPaymentCodePage(context),
                      )
                    ],
                  )
                ],
              ),
              Gaps.vGap10,
              Row(
                children: <Widget>[
                  Gaps.hGap20,
                  Images.pp_logo_circle60,
                  Gaps.hGap16,
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              ppUserEntityGlobal?.name ?? '',
                              style: TextStyles.txt17color000000,
                            ),
                            _unRealView()
                          ],
                        ),
                        Gaps.vGap8,
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () =>
                              copyString(ppUserEntityGlobal?.wallet_code ?? ''),
                          child: Row(
                            children: [
                              Text(
                                '钱包地址 :${ppUserEntityGlobal?.wallet_code ?? ''}',
                                style: TextStyles.txt11color99999,
                              ),
                              Gaps.hGap8,
                              Images.pp_home_copy_grey
                            ],
                          ),
                        ),
                      ]),
                ],
              ),
              Gaps.vGap32,
              Row(
                children: [
                  Gaps.hGap20,
                  Column(
                    children: [
                      const Text(
                        '可售余额',
                        style: TextStyles.txt12color99999,
                      ),
                      Gaps.vGap10,
                      Text(
                        account_balance,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.txt18color000000,
                      )
                    ],
                  ),
                  const Expanded(child: Text('')),
                  Column(
                    children: [
                      const Text(
                        '不可售',
                        style: TextStyles.txt12color99999,
                      ),
                      Gaps.vGap10,
                      Text(
                        overflow: TextOverflow.ellipsis,
                        account_balance_frozen,
                        style: TextStyles.txt18color000000,
                      )
                    ],
                  ),
                  const Expanded(child: Text('')),
                  Column(
                    children: [
                      const Text(
                        '卖单余额',
                        style: TextStyles.txt12color99999,
                      ),
                      Gaps.vGap10,
                      Text(
                        sell_order_amount,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.txt18color000000,
                      )
                    ],
                  ),
                  const Expanded(child: Text('')),
                  Column(
                    children: [
                      const Text(
                        '交易中',
                        style: TextStyles.txt12color99999,
                      ),
                      Gaps.vGap10,
                      Text(
                        overflow: TextOverflow.ellipsis,
                        transaction_amount,
                        style: TextStyles.txt18color000000,
                      )
                    ],
                  ),
                  Gaps.hGap20,
                ],
              ),
              Gaps.vGap20,
              _userReal(),
              Gaps.lineF6F6F6,
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textDirection: TextDirection.ltr,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Gaps.vGap8,
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _clickAuth(),
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 10, top: 15, bottom: 15),
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                      decoration: const BoxDecoration(
                          color: Colours.colorFFFFFF, //设置背景颜色
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: const Row(
                        children: <Widget>[
                          Images.pp_mine_list_1,
                          Gaps.hGap8,
                          Text(
                            '身份认证',
                            style: TextStyles.txt16color272729,
                          ),
                          Expanded(child: Text('')),
                          Images.pp_mine_right_arrow,
                          Gaps.hGap12,
                        ],
                      ),
                    ),
                  ),
                  Gaps.vGap15,
                  Container(
                      padding:
                          const EdgeInsets.only(left: 10, top: 15, bottom: 15),
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                      decoration: const BoxDecoration(
                          color: Colours.colorFFFFFF, //设置背景颜色
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Column(
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => goPpBillListPage(context),
                            child: const Row(
                              children: <Widget>[
                                Images.pp_mine_list_2,
                                Gaps.hGap8,
                                Text(
                                  '账单记录',
                                  style: TextStyles.txt16color272729,
                                ),
                                Expanded(child: Text('')),
                                Images.pp_mine_right_arrow,
                                Gaps.hGap12,
                              ],
                            ),
                          ),
                          Gaps.vGap8,
                          Gaps.lineF6F6F6,
                          Gaps.vGap8,
                          GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                if (isNeedAuthentication()) {
                                  showPpAuthenticationPageDialog(context);
                                } else {
                                  goPpCollectionManagementPage(context);
                                }
                              },
                              child: const Row(
                                children: <Widget>[
                                  Images.pp_mine_list_3,
                                  Gaps.hGap8,
                                  Text(
                                    '收付款管理',
                                    style: TextStyles.txt16color272729,
                                  ),
                                  Expanded(child: Text('')),
                                  Images.pp_mine_right_arrow,
                                  Gaps.hGap12,
                                ],
                              )),
                        ],
                      )),
                  Gaps.vGap20,
                  Container(
                    padding:
                        const EdgeInsets.only(left: 10, top: 15, bottom: 15),
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                    decoration: const BoxDecoration(
                        color: Colours.colorFFFFFF, //设置背景颜色
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: const Row(
                        children: <Widget>[
                          Images.pp_mine_icon_safety,
                          Gaps.hGap8,
                          Text(
                            '账号安全',
                            style: TextStyles.txt16color272729,
                          ),
                          Expanded(child: Text('')),
                          Images.pp_mine_right_arrow,
                          Gaps.hGap12,
                        ],
                      ),
                      onTap: () => goPpSafetyPage(context),
                    ),
                  ),
                  Gaps.vGap20,
                  Container(
                      padding:
                          const EdgeInsets.only(left: 10, top: 15, bottom: 15),
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                      decoration: const BoxDecoration(
                          color: Colours.colorFFFFFF, //设置背景颜色
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Column(
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: const Row(
                              children: <Widget>[
                                Images.pp_mine_list_6,
                                Gaps.hGap8,
                                Text(
                                  '关于我们',
                                  style: TextStyles.txt16color272729,
                                ),
                                Expanded(child: Text('')),
                                Images.pp_mine_right_arrow,
                                Gaps.hGap12,
                              ],
                            ),
                            onTap: () => goPpAboutPage(context),
                          ),
                          Gaps.vGap8,
                          Gaps.lineF6F6F6,
                          Gaps.vGap8,
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: const Row(
                              children: <Widget>[
                                Images.pp_mine_list_7,
                                Gaps.hGap8,
                                Text(
                                  '在线客服',
                                  style: TextStyles.txt16color272729,
                                ),
                                Expanded(child: Text('')),
                                Images.pp_mine_right_arrow,
                                Gaps.hGap12,
                              ],
                            ),
                            onTap: () => goKf(context),
                          ),
                          Gaps.vGap8,
                          Gaps.lineF6F6F6,
                          Gaps.vGap8,
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => _showLogoutDialog(),
                            child: const Row(
                              children: <Widget>[
                                Images.pp_mine_list_8,
                                Gaps.hGap8,
                                Text(
                                  '退出登陆',
                                  style: TextStyles.txt16color272729,
                                ),
                                Expanded(child: Text('')),
                                Images.pp_mine_right_arrow,
                                Gaps.hGap12,
                              ],
                            ),
                          )
                        ],
                      )),
                  Gaps.vGap100,
                ],
              )
            ],
          ),
        ),
      );

  void _out() {
    Toast.show('退出登录成功');
    SpUtil.putBool(Constant.isLogin, false);

    SpUtil.putBool(Constant.app_pwd_lock_number_open_bool, false);
    SpUtil.putBool(Constant.app_pwd_lock_face_replace_bool, false);
    SpUtil.putString(Constant.app_pwd_lock_number_string, '');
    SpUtil.putString(Constant.app_pwd_lock_face_string, '');
    goBackLastPage(context);
    goPpLoginPage(context);
  }

  void _showLogoutDialog() => showElasticDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Material(
            color: Colours.app_main_bg,
            type: MaterialType.transparency,
            child: Center(
              child: Container(
                height: 110,
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
                            '确定退出登录吗？',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF272729),
                              fontSize: 16,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                    ),
                    SizedBox(
                      width: 250,
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
                                    onTap: () {
                                      goBackLastPage(context);
                                    },
                                    child: Container(
                                      height: 44,
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 11),
                                      clipBehavior: Clip.antiAlias,
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              height: 22,
                                              child: Text(
                                                '取消',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xFF999999),
                                                  fontSize: 16,
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () => _out(),
                                    child: Container(
                                      height: 44,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 11),
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
                                                '确定',
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

  bool _isCloseReal = false;

  Container _userReal() {
    if (ppUserEntityGlobal?.is_real_name == '1' || _isCloseReal) {
      return Container();
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
        decoration: const BoxDecoration(
            color: Colours.colorFFFFFF, //设置背景颜色
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Images.pp_hint_ask18,
                Gaps.hGap5,
                const Text(
                  '身份认证',
                  style: TextStyles.txt14color272729,
                ),
                const Expanded(child: Text('')),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Images.pp_mine_close,
                  onTap: () => setState(() => _isCloseReal = true),
                )
              ],
            ),
            const Row(
              children: [
                Gaps.hGap20,
                Text(
                  '完成身份认证解锁更多功能，并保护您的账户免受风险',
                  style: TextStyles.txt12color99999,
                )
              ],
            ),
            Gaps.vGap10,
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _clickAuth(),
              child: const Row(
                children: [
                  Gaps.hGap20,
                  Text(
                    '立即认证',
                    style: TextStyles.txt14colorC1D18C,
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  Container _unRealView() => ppUserEntityGlobal?.is_real_name == '1'
      ? Container()
      : Container(
          width: 50,
          height: 22,
          alignment: Alignment.center,
          margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          decoration: ShapeDecoration(
            color: const Color(0x2BF94E46),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '未认证',
                style: TextStyle(
                  color: Color(0xFFF94E46),
                  fontSize: 11,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
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

  Future<void> _accountInfo() async =>
      PPHttpClient().get(PpUrlConfig.account_info, onSuccess: (jsonMap) {
        setState(() {
          account_balance = jsonMap['data']['account_balance'].toString();
          account_balance_frozen =
              jsonMap['data']['account_balance_frozen'].toString();
          sell_order_amount = jsonMap['data']['sell_order_amount'].toString();
          transaction_amount = jsonMap['data']['transaction_amount'].toString();
        });
      }, onError: (code, msg) {
        Toast.show(msg + code);
      });

  Future<void> _authenticationInfo() async =>
      PPHttpClient().get(PpUrlConfig.authenticationInfo,
          onSuccess: (jsonMap) async {
            if (jsonMap['data'] == null) {
              await goPpAuthenticationPage(context, false);
              _getUser();
            } else {
              // 0 待审核 1 审核通过 2 审核不通过
              final String isApproved =
                  jsonMap['data']['is_approved'].toString();
              final String rejectReason =
                  jsonMap['data']['reject_reason'].toString();
              if (isApproved == '0') {
                goPpAuthWaitPage(context);
              } else if (isApproved == '1') {
                ppUserEntityGlobal?.is_real_name = '1';
                goPpAuthSuccessPage(context);
              } else if (isApproved == '2') {
                goPpAuthFailPage(context, rejectReason);
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
}
