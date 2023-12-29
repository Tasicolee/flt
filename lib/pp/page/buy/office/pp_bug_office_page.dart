import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';

import '../../../../../util/theme_utils.dart';
import '../../../../../util/toast_utils.dart';
import '../../../../util/other_utils.dart';
import '../../../dio/pp_httpclient.dart';
import '../../../dio/pp_url_config.dart';

/// 购买-官方商城
class PpBugOfficePage extends StatefulWidget {
  PpBugOfficePage({super.key});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PpBugOfficePage> {
  int _indexMoney = -1;
  String supply_orders_id = "";
  int _indexPay = 0;

  late List _listMoney = [];

  ///代付类型：1 转卡 2.微信 3.支付宝
  late List _listPayString = ['银行卡', '支付宝', '微信'];
  late List _listPayType = ['1', '3', '2'];
  String _typePay = "1";

  late List _listPayIcon = [
    Images.pp_card_icon_card_20,
    Images.pp_card_icon_zfb_20,
    Images.pp_card_icon_wx_20
  ];
  late List _listPayIconBlack = [
    Images.pp_card_icon_card_black_20,
    Images.pp_card_icon_zfb_black_20,
    Images.pp_card_icon_wx_black_20
  ];

  dynamic _beanWx;
  dynamic _beanZfb;
  dynamic _beanYhk;

  bool _isBindWx = false;
  bool _isBindZfb = false;
  bool _isBindBank = false;

  @override
  void initState() {
    super.initState();
    _getData("1");
    _getInfoCounts();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colours.app_main_bg,
        appBar: AppBar(
          systemOverlayStyle: ThemeUtils.appSystemUiOverlayStyle(),
          backgroundColor: Colours.app_main_bg,
          centerTitle: true,
          title: const Text('官方商城', style: TextStyles.txt18color000000),
          elevation: 0,
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Images.pp_back_top_left_page,
            onTap: () => Navigator.pop(context),
          ),
          actions: [
            GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Images.pp_icon_history,
                onTap: () => goPpBuyOfficeOrderListPage(context)),
            Gaps.hGap20
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.vGap10,
              _titleTopHint('选择付款方式'),
              _getPayListView(),
              Gaps.vGap10,
              _titleTopHint("快捷金额"),
              _getMoneyListView(),
              Gaps.vGap20,
              _titleTopHint("选择付款账户"),
              _paySelectView(),
              Gaps.vGap20,
              _bottomView1(),
              Gaps.vGap20,
              _bottomView2(),
              Gaps.vGap50,
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 15.0),
                    margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                    decoration: const BoxDecoration(
                        color: Colours.colorA0BE4B, //设置背景颜色
                        gradient: LinearGradient(
                          begin: Alignment(1.00, -0.07),
                          end: Alignment(-1, 0.07),
                          colors: [
                            Color(0xFF00CEF6),
                            Color(0xFF0057FB),
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: const Row(
                      children: [
                        Expanded(child: Text('')),
                        Text('购买ED', style: TextStyles.txt17colorFFFFFF),
                        Expanded(child: Text('')),
                      ],
                    )),
                onTap: () => _buyClick(),
              )
            ],
          ),
        ),
      );

  Padding _titleTopHint(String string) => Padding(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Text(
          string,
          style: TextStyle(
            color: Color(0xFF2B2D33),
            fontSize: 14,
            fontFamily: 'PingFang HK',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.34,
          ),
        ),
      );

  /// account_info_types 账户类型 (1微信, 2支付宝, 3银行卡)
  GridView _getMoneyListView() => GridView.builder(
        padding: const EdgeInsets.all(20),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //每行三列
            crossAxisSpacing: 10.0, // 横向间距
            mainAxisSpacing: 15.0,
            childAspectRatio: 2.5 // 纵向间距
            ),
        itemCount: _listMoney.length,
        itemBuilder: (context, index) =>
            _moneyItem(_indexMoney == index, index),
      );

  GestureDetector _moneyItem(bool isChoose, int index) => GestureDetector(
        onTap: () {
          _indexMoney = index;
          supply_orders_id = _listMoney[index]["id"].toString();
          setState(() {});
        },
        child: Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1,
                    color: isChoose ? Color(0xFF0083FB) : Colors.white),
                borderRadius: BorderRadius.circular(5),
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
            child: Stack(
              children: [
                Center(
                    child: Text(
                  '¥${_listMoney[index]["amount"]}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(isChoose ? 0xFF0083FB : 0xff000000),
                    fontSize: 14,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.20,
                  ),
                )),
                isChoose
                    ? Positioned(
                        child: Images.pp_icon_money_check,
                        right: 0,
                      )
                    : Container()
              ],
            )),
      );

  void _showJumpAddCardDialog() => showElasticDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Material(
            color: Colours.app_main_bg,
            type: MaterialType.transparency,
            child: Center(
              child: Container(
                height: 160,
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
                            '您尚未绑定支付宝账户。\n为了使用支付宝支付\n请先绑定您的账户。\n',
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
                                    onTap: () async {
                                      goBackLastPage(context);
                                      await goPpCollectionManagementPage(
                                          context);
                                      _getInfoCounts();
                                    },
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
                                                '去绑定',
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

  GestureDetector _paySelectView() => GestureDetector(
        onTap: () async {
          ///代付类型：1 转卡 2.微信 3.支付宝
          if (_typePay == "1") {
            if (_isBindBank)
              _showBankCardDialog(_typePay);
            else {
              _showJumpAddCardDialog();
            }
          } else if (_typePay == "2") {
            if (_isBindWx)
              _showBankCardDialog(_typePay);
            else {
              _showJumpAddCardDialog();
            }
          } else if (_typePay == "3") {
            if (_isBindZfb)
              _showBankCardDialog(_typePay);
            else {
              _showJumpAddCardDialog();
            }
          }
        },
        child: Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(20, 15, 20, 10),
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
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
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _getShowPayIcon(),
                        Gaps.hGap10,
                        Text(
                          _getShowPayText(),
                          style: TextStyle(
                            color: Color(_getShowPayText().startsWith('选择')
                                ? 0xFFD7D7D7
                                : 0xFF272729),
                            fontSize: 16,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Images.arrowRight,
              ],
            )),
      );

  ///代付类型：1 转卡 2.微信 3.支付宝
  _getShowPayIcon() {
    if (_typePay == "1") {
      return _stringCard.isNotEmpty ? Images.pp_card_icon_card_20 : Container();
    } else if (_typePay == "2") {
      return _stringWx.isNotEmpty ? Images.pp_card_icon_wx_20 : Container();
    } else if (_typePay == "3") {
      return _stringZfb.isNotEmpty ? Images.pp_card_icon_zfb_20 : Container();
    } else {
      return Container();
    }
  }

  String _getShowPayText() {
    if (_typePay == "1") {
      return _stringCard.isNotEmpty ? _stringCard : '选择付款账户';
    } else if (_typePay == "2") {
      return _stringWx.isNotEmpty ? _stringWx : '选择付款账户';
    } else if (_typePay == "3") {
      return _stringZfb.isNotEmpty ? _stringZfb : '选择付款账户';
    } else {
      return '选择付款账户';
    }
  }

  _bottomView1() => Row(
        children: [
          Gaps.hGap20,
          Text(
            '参考价格',
            style: TextStyle(
              color: Color(0xFF86909C),
              fontSize: 14,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
          Expanded(child: Text('')),
          Text(
            '¥${_rate}/ED',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Color(0xFF1D2129),
              fontSize: 14,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ),
          Gaps.hGap20
        ],
      );

  _bottomView2() => Row(
        children: [
          Gaps.hGap20,
          Text(
            '预计获得',
            style: TextStyle(
              color: Color(0xFF86909C),
              fontSize: 14,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ),
          Expanded(child: Text('')),
          Text(
            '${_indexMoney == -1 ? "" : double.parse(_listMoney[_indexMoney]['amount'].toString()) * _rate} ED',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Color(0xFF0083FB),
              fontSize: 14,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ),
          Gaps.hGap20
        ],
      );

//pp_icon_money_check.png

  /// account_info_types 账户类型 (1微信, 2支付宝, 3银行卡)
  GridView _getPayListView() => GridView.builder(
        padding: const EdgeInsets.all(20),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //每行三列
            crossAxisSpacing: 10.0, // 横向间距
            mainAxisSpacing: 15.0,
            childAspectRatio: 2.5 // 纵向间距
            ),
        itemCount: _listPayString.length,
        itemBuilder: (context, index) => _payItem(_indexPay == index, index),
      );

  GestureDetector _payItem(bool isChoose, int index) {
    return GestureDetector(
      onTap: () {
        _indexPay = index;
        setState(() {});
        _typePay = _listPayType[index];
        _getData(_typePay);
      },
      child: Container(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 1, color: isChoose ? Color(0xFF0083FB) : Colors.white),
              borderRadius: BorderRadius.circular(5),
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
          child: Stack(
            children: [
              Center(
                  child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _indexPay == index
                      ? _listPayIcon[index]
                      : _listPayIconBlack[index],
                  Gaps.hGap5,
                  Text(
                    _listPayString[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(isChoose ? 0xFF0083FB : 0xFFD7D7D7),
                      fontSize: 14,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.20,
                    ),
                  )
                ],
              )),
              isChoose
                  ? Positioned(
                      child: Images.pp_icon_money_check,
                      right: 0,
                    )
                  : Container()
            ],
          )),
    );
  }

  double _rate = 1.0;

  ///代付类型：1 转卡 2.微信 3.支付宝
  void _getData(String type) {
    PPHttpClient().get(PpUrlConfig.supply, data: {
      'payment_type': type,
    }, onSuccess: (jsonMap) {
      _indexMoney = -1;
      supply_orders_id = "";
      _listMoney = jsonMap['data']['supply_orders'] as List;
      _rate = double.parse(jsonMap['data']['rate'].toString());
      setState(() {});
    }, onError: (code, msg) {
      Toast.show(msg + code);
    });
  }

  Future<void> _getInfoCounts() async {
    PPHttpClient().get(PpUrlConfig.getInfoCounts, onSuccess: (jsonMap) {
      final List list = jsonMap['data'] as List;
      list.forEach((element) {
        if (element['account_type'] == '1') {
          _beanWx = element;
          _isBindWx = true;
        } else if (element['account_type'] == '2') {
          _beanZfb = element;
          _isBindZfb = true;
        } else if (element['account_type'] == '3') {
          _beanYhk = element;
          _isBindBank = true;
        }
      });
      setState(() {});
    }, onError: (code, msg) {
      Toast.show(msg + code);
    });
  }

  Future<Future<int?>> _showBankCardDialog(String type) async =>
      showModalBottomSheet<int>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
          builder: (context, setStateDialog) =>
              _showBankCardDialogView(setStateDialog, type),
        ),
      );

  Container _showBankCardDialogView(StateSetter setStateDialog, String type) =>
      Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Colours.app_main_bg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(children: [
          SizedBox(
            height: 50,
            child: Stack(
              textDirection: TextDirection.rtl,
              children: [
                Positioned(
                    left: 0,
                    top: 5,
                    child: IconButton(
                        icon: const Icon(Icons.keyboard_arrow_left),
                        onPressed: () => Navigator.of(context).pop())),
                const Center(
                  child: Text(
                    '选择付款账户',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1F2024),
                      fontSize: 16,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ///代付类型：1 转卡 2.微信 3.支付宝
                _cardView(setStateDialog, type)
              ],
            ),
          ),
        ]),
      );
  String _stringCard = "";
  String _stringWx = "";
  String _stringZfb = "";

  _cardView(StateSetter setStateDialog, type) {
    ///代付类型：1 转卡 2.微信 3.支付宝
    if (type == "1") {
      return GestureDetector(
        child: _yhkView(),
        onTap: () {
          var ss = _beanYhk['card_number'].toString();
          _stringCard = _beanYhk['name'] +
              " " +
              ss.substring(0, 4) +
              " **** " +
              ss.substring(ss.length - 4, ss.length - 1) +
              " " +
              _beanYhk['bank_name'];
          setState(() {});
          goBackLastPage(context);
        },
      );
    } else if (type == "2") {
      return GestureDetector(
        child: _wxView(),
        onTap: () {
          _stringWx = _beanWx['name'] + " " + _beanWx['card_number'].toString();
          setState(() {});
          goBackLastPage(context);
        },
      );
    } else if (type == "3") {
      return GestureDetector(
        child: _zfbView(),
        onTap: () {
          _stringZfb =
              _beanZfb['name'] + " " + _beanZfb['id_number'].toString();
          setState(() {});
          goBackLastPage(context);
        },
      );
    }
  }

  Container _zfbView() => Container(
        padding: const EdgeInsets.only(left: 30.0),
        width: double.infinity,
        height: 130,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(0.91, 0.41),
            end: Alignment(-0.91, -0.41),
            colors: [Color(0xFF009EFE), Color(0xFF009EFE)],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x141A1F44),
              blurRadius: 30,
              offset: Offset(0, 16),
            )
          ],
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.vGap20,
                Images.pp_ban_zfb_logo,
                Gaps.vGap20,
                Text(
                  _beanZfb['id_number'].toString(),
                  style: const TextStyle(
                    color: Color(0xFFF7F7F7),
                    fontSize: 16,
                    fontFamily: 'HK Grotesk',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Gaps.vGap20,
                Text(
                  _beanZfb['name'].toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'PingFang HK',
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.41,
                  ),
                )
              ],
            ),
            const Expanded(child: Text('')),
            Images.pp_bank_zfb_white
          ],
        ),
      );

  Container _yhkView() => Container(
        padding: const EdgeInsets.only(left: 30.0),
        width: double.infinity,
        height: 130,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(0.91, 0.41),
            end: Alignment(-0.91, -0.41),
            colors: [Color(0xFF302883), Color(0xFF857AF5)],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x141A1F44),
              blurRadius: 30,
              offset: Offset(0, 16),
            )
          ],
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.vGap20,
                Text(
                  _beanYhk['name'].toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'PingFang HK',
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.41,
                  ),
                ),
                Gaps.vGap20,
                Text(
                  _beanYhk['card_number'].toString(),
                  style: const TextStyle(
                    color: Color(0xFFF7F7F7),
                    fontSize: 16,
                    fontFamily: 'HK Grotesk',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Gaps.vGap20,
                Text(
                  _beanYhk['bank_name'].toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'PingFang HK',
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.41,
                  ),
                )
              ],
            ),
            const Expanded(child: Text('')),
            Images.pp_bank_card_white
          ],
        ),
      );

  Container _wxView() => Container(
        padding: const EdgeInsets.only(left: 30.0),
        width: double.infinity,
        height: 130,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        decoration: ShapeDecoration(
          color: const Color(0xFF00B837),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0C4A590E),
              blurRadius: 16,
              offset: Offset(0, 6),
            )
          ],
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.vGap20,
                Images.pp_bank_wx_logo,
                Gaps.vGap20,
                Text(
                  _beanWx['id_number'].toString(),
                  style: const TextStyle(
                    color: Color(0xFFF7F7F7),
                    fontSize: 16,
                    fontFamily: 'HK Grotesk',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Gaps.vGap20,
                Text(
                  _beanWx['name'].toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'PingFang HK',
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.41,
                  ),
                )
              ],
            ),
            const Expanded(child: Text('')),
            Images.pp_bank_wx_white
          ],
        ),
      );

  _buyClick() {
    if (supply_orders_id.isEmpty) {
      Toast.show("请选择金额");
      return;
    }

    ///代付类型：1 转卡 2.微信 3.支付宝
    String paymentAccountInfoId = '';
    if (_typePay == "1") {
      paymentAccountInfoId = _beanYhk["id"].toString();
    } else if (_typePay == "2") {
      paymentAccountInfoId = _beanWx["id"].toString();
    } else if (_typePay == "3") {
      paymentAccountInfoId = _beanZfb["id"].toString();
    }
    PPHttpClient().post(PpUrlConfig.supplyBuy, data: {
      'supply_orders_id': supply_orders_id,
      'payment_account_info_id': paymentAccountInfoId,
    }, onSuccess: (jsonMap) async {
      final String orderId = jsonMap['data']['id'].toString();
      Toast.show("购买成功");
      await goPpOfficeBuyOrderDetailsWaitPage(context, order_id: orderId);
      _getData(_typePay);
    }, onError: (code, msg) {
      Toast.show(msg + code);
    });
  }
}
