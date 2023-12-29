import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/page/mine/pp_mine_tab_page.dart';
import 'package:flutter_deer/pp/page/pp_scan_page.dart';
import 'package:flutter_deer/pp/page/sell/list/pp_pending_item.dart';
import 'package:flutter_deer/pp/utils/pp_dialog_utils.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/device_utils.dart';
import 'package:sp_util/sp_util.dart';

import '../../res/constant.dart';
import '../../util/toast_utils.dart';
import '../dio/pp_httpclient.dart';
import '../dio/pp_url_config.dart';
import '../utils/pp_global.dart';
import '../utils/pp_string_utils.dart';
import '../utils/pp_user_utils.dart';
import 'mine/pp_update_dialog.dart';

///首页tab页面
class PPHomeTabPage extends StatefulWidget {
  const PPHomeTabPage({
    super.key,
    this.isRefresh = false,
    this.needPwdLock = false,
  });

  final bool isRefresh;
  final bool needPwdLock;

  @override
  _PPHomeTabPageState createState() => _PPHomeTabPageState();
}

class _PPHomeTabPageState extends State<PPHomeTabPage> {
  List? _listSell = [];
  List? _bannerList;
  List? _showHintList;
  List? _noticeList;
  dynamic? _popup_notice;
  bool _showNotice = false;

  @override
  void initState() {
    super.initState();
    _onRefresh();
    _goPwd();
  }

  Future<void> _onRefresh() async {
    _banner();
    _getUser();
    _sellMyList();
    _version();
    sys_configKefu();
    qiniuToken();
    getUserInfo();
    Toast.show('刷新完成');
  }

  void _goPwd() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (widget.needPwdLock) {
        goPpPwdLockGesturePage(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colours.app_main_bg,
      body: RefreshIndicator(
          color: Colours.colorFFFFFF,
          backgroundColor: Colours.colorA0BE4B,
          onRefresh: _onRefresh,
          child: ListView.builder(
            itemCount: 5,
            // ((_listSell?.length ?? 0) == 0 ? 1 : _listSell?.length)! + 5,
            itemBuilder: (context, index) => _body(index),
          )));

  Widget _body(int index) {
    if (index == 0) {
      return _bodyTopView();
    } else if (index == 1) {
      return _bodyNoticeList();
    } else if (index == 2) {
      return _bodyMenu();
    } else if (index == 3) {
      return _hintView();
    } else if (index == 4) {
      return _bodyBanner();
    } else {
      return Container();
    }
  }

  Container _hintView() => Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        padding: const EdgeInsets.all(20),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x0C4A590E),
              blurRadius: 16,
              offset: Offset(0, 6),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '官方直充',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.20,
                                ),
                              ),
                              Container(
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Images.pp_home_icon_red,
                                    Center(
                                        child: Text(
                                      '推荐',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ))
                                  ],
                                ),
                                padding: EdgeInsets.only(bottom: 10),
                              )
                            ],
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: 196,
                            child: Text(
                              '资金安全有保障，平台担保赔付，\nED币锚定人民币1:1兑换',
                              style: TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 12,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (isNeedAuthentication()) {
                        showPpAuthenticationPageDialog(context);
                      } else {
                        goPpBugOfficePage(context);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12.80),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        // color: Color(0xFFCFE888),
                        gradient: LinearGradient(
                          begin: Alignment(1.00, -0.07),
                          end: Alignment(-1, 0.07),
                          colors: [Color(0xFF00CEF6), Color(0xFF0057FB)],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x66CFE888),
                            blurRadius: 16,
                            offset: Offset(0, 8),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '买币GO',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.20,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            width: 14,
                            height: 14,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(),
                            child:
                                Stack(children: [Images.pp_right_arrow_home]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: Color(0xFFF9FAF5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              '24H成交量 (EB)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 11,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.20,
                              ),
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            _showHintList == null
                                ? ''
                                : _showHintList?[0]['value'],
                            style: TextStyle(
                              color: Color(0xFF272729),
                              fontSize: 13,
                              fontFamily: 'DIN',
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              '24H成单量',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 11,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.20,
                              ),
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            _showHintList == null
                                ? ''
                                : _showHintList?[1]['value'],
                            style: TextStyle(
                              color: Color(0xFF272729),
                              fontSize: 13,
                              fontFamily: 'DIN',
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              '交易成功率',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 11,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.20,
                              ),
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            _showHintList == null
                                ? ''
                                : _showHintList![2]['value'].toString(),
                            style: TextStyle(
                              color: Color(0xFF272729),
                              fontSize: 13,
                              fontFamily: 'DIN',
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Padding _bodyBanner() {
    final String? domain = SpUtil.getString(Constant.qiniu_domain);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 20, right: 30, top: 20),
      child: ConstrainedBox(
          constraints: BoxConstraints.loose(const Size(double.infinity, 110)),
          child: Swiper(
            autoplay: true,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: '$domain/${_bannerList![index]['image']}',
                  ),
                ),
                onTap: () {
                  goWeb(context, _bannerList![index]['url'].toString());
                },
              );
            },
            itemCount: _bannerList?.length ?? 0,
            viewportFraction: 0.99,
            scale: 0.8,
          )),
    );
  }

  Column _bodySellListTitle() => Column(
        children: [
          Gaps.vGap10,
          Gaps.lineF5F5F5,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    Container(width: 20.0),
                    const Text(
                      '我的挂单',
                      style: TextStyles.txt18color2B2D33,
                    ),
                    const Expanded(child: Text('')),
                    const Text(
                      '更多',
                      style: TextStyles.txt14colorA0BE4B,
                    ),
                    Container(width: 20.0)
                  ],
                ),
                onTap: () => goPpPendingListPage(context),
              ),
            ],
          ),
          Gaps.vGap15,
        ],
      );

  PpPendingListItemPage _bodySellListBody(int index) =>
      PpPendingListItemPage(item: _listSell?[index], isHome: false);

  Column _bodyTopView() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Gaps.vGap5,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gaps.hGap20,
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Images.pp_logo_circle40,
                onTap: () => _goMine(),
              ),
              const Expanded(child: Text('')),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Images.pp_home_right_button,
                onTap: () => _scan(),
              ),
              GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Images.pp_home_right_button2,
                  onTap: () => goKf(context)),
            ],
          ),
          Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: const BoxDecoration(
                  //color: Colours.app_hone_bg_ks, //设置背景颜色
                  gradient: LinearGradient(
                    begin: Alignment(1.00, -0.06),
                    end: Alignment(-1, 0.06),
                    colors: [Color(0xFF4EE7F1), Color(0xFF235AFC)],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Stack(
                children: [
                  const Positioned(
                      right: 0, bottom: 0, child: Images.pp_home_icon_hint),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '可售出余额',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'PingFang HK',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.44,
                        ),
                      ),
                      Gaps.vGap5,
                      Text(
                        ppUserEntityGlobal?.account_balance ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontFamily: 'DIN',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.39,
                        ),
                      ),
                      Gaps.vGap24,
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () =>
                            copyString(ppUserEntityGlobal?.wallet_code ?? ''),
                        child: Row(
                          children: [
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 10.0,
                                    right: 10.0,
                                    top: 5.0,
                                    bottom: 5.0),
                                decoration: const BoxDecoration(
                                    color: Color(0x88ffffff),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Row(
                                  children: [
                                    Text(
                                      ppUserEntityGlobal?.wallet_code ?? '',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontFamily: 'PingFang HK',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.51,
                                      ),
                                    ),
                                    Gaps.hGap5,
                                    Images.pp_home_copy
                                  ],
                                )),
                            const Expanded(child: Text(''))
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )),
          Gaps.vGap24,
        ],
      );

  Stack _bodyNoticeList() => !_showNotice
      ? const Stack()
      : Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: double.infinity,
              height: 40,
              padding: const EdgeInsets.only(top: 10, left: 15, bottom: 10),
              decoration: ShapeDecoration(
                color: const Color(0x0C0082F9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: const Stack(children: [Images.pp_home_icon_notice]),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 0),
              child: ConstrainedBox(
                  constraints:
                      BoxConstraints.loose(const Size(double.infinity, 20)),
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                        _noticeList![index]['title'].toString(),
                        style: const TextStyle(
                          color: Color(0xFF272729),
                          fontSize: 13,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.44,
                        ),
                      );
                    },
                    //pp_null_list.png.png.png.png.png.png.png
                    itemCount: _noticeList?.length ?? 0,
                    viewportFraction: 1,
                    autoplay: true,
                    scale: 0.9,
                  )),
            )
          ],
        );

  Column _bodyMenu() => Column(
        children: [
          Gaps.vGap20,
          Row(
            children: <Widget>[
              Container(width: 20.0),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  await goPpPaymentCodePage(context);
                  _getUser();
                },
                child: const Column(
                  children: [
                    Images.pp_home_button_receive,
                    Gaps.vGap5,
                    Text(
                      ' 收款 ',
                      style: TextStyles.app_hone_txt_btn13,
                    ),
                  ],
                ),
              ),
              const Expanded(child: Text('')),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (isNeedAuthentication()) {
                    showPpAuthenticationPageDialog(context);
                  } else {
                    goPpTransferPage(context);
                  }
                },
                child: const Column(
                  children: [
                    Images.pp_home_button_swap,
                    Gaps.vGap5,
                    Text(
                      ' 转账 ',
                      style: TextStyles.app_hone_txt_btn13,
                    ),
                  ],
                ),
              ),
              const Expanded(child: Text('')),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: const Column(
                  children: [
                    Images.pp_home_button_topup,
                    Gaps.vGap5,
                    Text(
                      ' 购买 ',
                      style: TextStyles.app_hone_txt_btn13,
                    ),
                  ],
                ),
                onTap: () {
                  if (isNeedAuthentication()) {
                    showPpAuthenticationPageDialog(context);
                  } else {
                    goPpBuyMyListPage(context);
                  }
                },
              ),
              const Expanded(child: Text('')),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: const Column(
                  children: [
                    Images.pp_home_button_send,
                    Gaps.vGap5,
                    Text(
                      ' 出售 ',
                      style: TextStyles.app_hone_txt_btn13,
                    ),
                  ],
                ),
                onTap: () async {
                  if (isNeedAuthentication()) {
                    showPpAuthenticationPageDialog(context);
                  } else {
                    await goPpSellPage(context);
                    _getUser();
                  }
                },
              ),
              Container(width: 20.0),
            ],
          ),
          Gaps.vGap20,
          Row(
            children: <Widget>[
              Container(
                width: 20.0,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  goPpPendingListPage(context);
                },
                child: const Column(
                  children: [
                    Images.pp_home_button_1,
                    Gaps.vGap5,
                    Text(
                      '我的挂单',
                      style: TextStyles.app_hone_txt_btn13,
                    ),
                  ],
                ),
              ),
              const Expanded(child: Text('')),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (isNeedAuthentication()) {
                    showPpAuthenticationPageDialog(context);
                  } else {
                    goPpBillListPage(context);
                  }
                },
                child: const Column(
                  children: [
                    Images.pp_home_button_2,
                    Gaps.vGap5,
                    Text(
                      '账单记录',
                      style: TextStyles.app_hone_txt_btn13,
                    ),
                  ],
                ),
              ),
              const Expanded(child: Text('')),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: const Column(
                  children: [
                    Images.pp_home_button_3,
                    Gaps.vGap5,
                    Text(
                      '收付款管理',
                      style: TextStyles.app_hone_txt_btn13,
                    ),
                  ],
                ),
                onTap: () {
                  if (isNeedAuthentication()) {
                    showPpAuthenticationPageDialog(context);
                  } else {
                    goPpCollectionManagementPage(context);
                  }
                },
              ),
              const Expanded(child: Text('')),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: const Column(
                  children: [
                    Images.pp_home_button_4,
                    Gaps.vGap5,
                    Text(
                      ' 教程 ',
                      style: TextStyles.app_hone_txt_btn13,
                    ),
                  ],
                ),
                onTap: () async => goKf(context),
              ),
              Container(width: 20.0),
            ],
          ),
        ],
      );

  /**
   *   page	否	string	页码
      limit	否	string	每页条数
      status	否	string	挂单状态：0.待审核,1.挂单中, 2已下架
      available_amount	否	string	可出售金额 为0为已售罄状态 其他情况不传
   */

  /// 我的挂单
  Future<void> _sellMyList() async => PPHttpClient()
          .get(PpUrlConfig.sell_myList, data: {'page': 1, 'limit': 10},
              onSuccess: (jsonMap) {
        setState(() {
          _listSell = jsonMap['data']['data'] as List;
        });
      }, onError: (code, msg) {
        Toast.show(msg + code);
      });

  Future<void> _goMine() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => const PpMineTabPage()));
    await getUserInfo();
    setState(() {});
  }

  Future<void> _version() async =>
      PPHttpClient().get(PpUrlConfig.version, onSuccess: (jsonMap) async {
        final String contentStr = jsonMap['data']['content'].toString();
        final String apkVersion = jsonMap['data']['apk_version'].toString();
        final String iosVersion = jsonMap['data']['ios_version'].toString();
        final String apkUrl = jsonMap['data']['apk_url'].toString();
        final String iosUrl = jsonMap['data']['ios_url'].toString();
        final String v = await versionCodeString();
        if (Device.isAndroid) {
          if (double.parse(apkVersion) > int.parse(v)) {
            _showUpdateDialog(contentStr, apkUrl);
          }
        } else if (Device.isIOS) {
          if (double.parse(iosVersion) > int.parse(v)) {
            _showUpdateDialog(contentStr, iosUrl);
          }
        }
      }, onError: (code, msg) {
        Toast.show(msg + code);
      });

  Future<void> _banner() async =>
      PPHttpClient().get(PpUrlConfig.banner, onSuccess: (jsonMap) async {
        _bannerList = jsonMap['data']['banner'] as List;
        _noticeList = jsonMap['data']['notice'] as List;
        _showHintList = jsonMap['data']['transaction_volume'] as List;
        _popup_notice = jsonMap['data']['popup_notice'];
        Future.delayed(const Duration(milliseconds: 1000), () {
          _showNotice = true;
          setState(() {});
        });
        setState(() {});
        showHomeDialog(
            context, _popup_notice["title"], _popup_notice["content"]);
      }, onError: (code, msg) {});

  Future<void> _showUpdateDialog(String contentStr, String apkUrl) async {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => PpUpdateDialog(contentStr, apkUrl));
  }

  Future<void> _getUser() async => PPHttpClient().get(PpUrlConfig.user,
      onSuccess: (jsonMap) {
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
      },
      onError: (code, msg) => goPpLoginPage(context));

  Future<void> _scan() async {
    if (isPpWeb()) {
      Toast.show('暂不支持该平台');
    } else {
      final result = await Navigator.push(
          context, MaterialPageRoute(builder: (_) => ScanPage()));
      final resultStr = result.toString();
      if (resultStr.isNotEmpty && resultStr != 'null') {
        final jsonMap = jsonDecode(resultStr);
        final type = jsonMap['type'].toString();
        if (type == 'transfer') {
          final walletCode = jsonMap['wallet_code'].toString();
          goPpTransferMoneyPage(context, walletCode, false);
        } else if (type == 'recharge') {
          final platformOrderNo = jsonMap['platform_order_no'].toString();
          goPpTransferOtherPage(context, platformOrderNo);
        } else {
          Toast.show('未检测到有效二维码');
        }
      } else {
        Toast.show('未检测到二维码');
      }
    }
  }
}
