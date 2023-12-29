import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/page/buy/order/details/pp_buy_order_details_utils.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';

import '../../../../../util/toast_utils.dart';
import '../../../../dio/pp_httpclient.dart';
import '../../../../dio/pp_url_config.dart';
import '../../../../utils/pp_countdown_widget.dart';

/// 订单详情-购买-1.待付款
class PpBuyOrderDetailsWaitPage extends StatefulWidget {
  String order_id;

  PpBuyOrderDetailsWaitPage({super.key, required this.order_id});

  @override
  _PageState createState() => _PageState(order_id: order_id);
}

class _PageState extends State<PpBuyOrderDetailsWaitPage> {
  String order_id;
  bool _isFinishTime = false;

  dynamic? _buyDetail;

  _PageState({required this.order_id});

  @override
  void initState() {
    _getBuyDetail(order_id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colours.app_main_bg,
        appBar: const MyAppBar(
          centerTitle: '订单详情',
          backgroundColor: Colours.app_main_bg,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Gaps.vGap20,
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Images.pp_icon_order_wait1,
                  Gaps.hGap8,
                  Text(
                    '待付款',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFF7272),
                      fontSize: 20,
                      fontFamily: 'PingFang HK',
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              Gaps.vGap10,
              Row(
                children: [
                  const Expanded(child: Text('')),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '买方需在',
                          style: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gaps.hGap8,
                  PpCountDownWidget(
                    _buyDetail == null
                        ? ''
                        : "${_buyDetail['buyer_paytime_limit']}000",
                    textSize: 14,
                    textColor: const Color(0xFFFF7272),
                    isFinish: (e) {
                      if (e) {
                        //计时结束
                        _isFinishTime = true;
                      }
                    },
                  ),
                  Gaps.hGap5,
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: ' 内完成付款，否则订单将自动取消',
                          style: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Expanded(child: Text('')),
                ],
              ),
              Gaps.vGap20,
              getBuyTitleMoney(_buyDetail),
              itemBuyView(_buyDetail),
              Row(
                children: [
                  Gaps.hGap20,
                  const Expanded(
                    child: SizedBox(
                      child: Text(
                        '收款人',
                        style: TextStyle(
                          color: Color(0xFF86909C),
                          fontSize: 14,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    elementItem == null ? '' : elementItem['name'].toString(),
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Color(0xFF1D2129),
                      fontSize: 14,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gaps.hGap20,
                ],
              ),
              Gaps.vGap20,
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _showBankCardDialog();
                },
                child: getBuyPayView(_payTypeChoose),
              ),
              Gaps.vGap20,
              _getBuyPayView(),
              Gaps.vGap20,
              Container(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 10, right: 10, bottom: 10),
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                decoration: const BoxDecoration(
                  color: Colours.colorFFF7E8,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Images.pp_hint_ask_orange,
                        Gaps.hGap5,
                        Text(
                          '温馨提示:',
                          style: TextStyles.txt14color272729,
                        )
                      ],
                    ),
                    Gaps.vGap8,
                    Text(
                      '请在15分钟内将对应金额付款到对方指定账户 \n付款完成后，点击“已完成付款”，卖家确认付款到账后，系统会将对应的PP币自动划转到您的账户中 \n请妥善保管付款凭证\n仅支持本人实名认证相同姓名账户付款，如果付款信息及付款金额不一致，卖家有权拒绝放行',
                      style: TextStyles.txt12color1E1E1E,
                    ),
                  ],
                ),
              ),
              Gaps.vGap50,
              Row(
                children: [
                  Gaps.hGap20,
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _buyCancel(order_id),
                    child: Container(
                      width: 162.50,
                      height: 50,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1000),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x0C4A590E),
                            blurRadius: 16,
                            offset: Offset(0, 6),
                          )
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '取消订单',
                            style: TextStyle(
                              color: Color(0xFF272729),
                              fontSize: 17,
                              fontFamily: 'PingFang HK',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.37,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(child: Text('')),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _buyPay(order_id),
                    child: SizedBox(
                      width: 162.50,
                      height: 50,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF0083FB),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1000),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x70A0BE4B),
                                    blurRadius: 12,
                                    offset: Offset(0, 5),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '已完成付款',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: 'PingFang HK',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.37,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gaps.hGap20,
                ],
              ),
              Gaps.vGap80,
            ],
          ),
        ),
      );

  void _buyCancel(String orderId) {
    if (_isFinishTime) {
      Toast.show('该订单已经过期无法操作');
      return;
    }
    PPHttpClient().post(PpUrlConfig.buyCancel, data: {
      'order_id': orderId,
    }, onSuccess: (jsonMap) {
      Toast.show('取消订单成功');
      goBackLastPage(context);
    }, onError: (code, msg) {
      Toast.show(msg + code);
    });
  }

  /**
   * 	是	string	订单id
      account_info_id	是	int	买家选择的卖家收款方式id
      account_info_type	是	int	买家选择的收款方式类型账户类型 (1微信, 2支付宝, 3银行卡)
   */

  ///
  void _buyPay(String orderId) {
    if (_isFinishTime) {
      Toast.show('该订单已经过期无法操作');
      return;
    }
    var elementItem;
    final list = (_buyDetail['payment_info'] as List);
    if (list?.isNotEmpty == true) {
      list.forEach((element) {
        if (element['account_type'] == _payTypeChoose) {
          elementItem = element;
        }
      });
    }
    PPHttpClient().post(PpUrlConfig.buyPay, data: {
      'order_id': orderId,
      'account_info_id': elementItem['id'],
      'account_info_type': _payTypeChoose,
    }, onSuccess: (jsonMap) {
      goBackLastPage(context);
      goPpBuyOrderDetailsPaidPage(context, order_id: orderId);
    }, onError: (code, msg) {
      Toast.show(msg + code);
    });
  }

  String _payTypeChoose = '';

  bool _isNeedBank = false;
  bool _isNeedWx = false;
  bool _isNeedZfb = false;

  bool _isHaveBank = false;
  bool _isHaveWx = false;
  bool _isHaveZfb = false;
  var elementItem; //当前的付款方式payment_info

  Widget _getBuyPayView() {
    if (_buyDetail == null) return Container();
    final List list = _buyDetail['payment_info'] as List;
    if (list?.isNotEmpty == true) {
      list.forEach((element) {
        if (element['account_type'] == _payTypeChoose) {
          elementItem = element;
        }
      });
      if (_payTypeChoose == '1') {
        return getBuyPayViewWx(context, elementItem['pay_qrcode_url']);
      } else if (_payTypeChoose == '2') {
        return getBuyPayViewZfb(context, elementItem['pay_qrcode_url']);
      } else if (_payTypeChoose == '3') {
        return getBuyPayViewBank(elementItem);
      } else {
        return getBuyPayViewBank(elementItem);
      }
    } else {
      return Container();
    }
  }

  void _getBuyDetail(String orderId) =>
      PPHttpClient().get(PpUrlConfig.buyDetail, data: {
        'order_id': orderId,
      }, onSuccess: (jsonMap) {
        _buyDetail = jsonMap['data'];

        final List list = _buyDetail['payment_info'] as List;
        if (list?.isNotEmpty == true) {
          list.forEach((element) {
            if (element['account_type'] == '1') {
              _isHaveWx = true;
            } else if (element['account_type'] == '2') {
              _isHaveZfb = true;
            } else if (element['account_type'] == '3') {
              _isHaveBank = true;
            }
          });

          final String startIndex = list[0]['account_type'].toString();
          elementItem = list[0];
          _payTypeChoose = startIndex;
          if (startIndex == '1') {
            _isNeedWx = true;
          } else if (startIndex == '2') {
            _isNeedZfb = true;
          } else if (startIndex == '3') {
            _isNeedBank = true;
          }
        }
        setState(() {});
      }, onError: (code, msg) {
        Toast.show(msg + code);
      });

  Future<Future<int?>> _showBankCardDialog() async => showModalBottomSheet<int>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
          builder: (context, setStateDialog) =>
              _showBankCardDialogView(setStateDialog),
        ),
      );

  Container _showBankCardDialogView(StateSetter setStateDialog) => Container(
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
                    '收款方式',
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
                if (_isHaveBank) Gaps.vGap20 else Gaps.vGap0,
                if (_isHaveBank)
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      padding: const EdgeInsets.only(
                          left: 10, top: 20, bottom: 20, right: 10),
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        color: Colours.colorFFFFFF,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Row(
                        children: [
                          Gaps.hGap10,
                          Images.pp_card_icon_card_20,
                          Gaps.hGap10,
                          const Text(
                            '银行卡',
                            style: TextStyle(
                              color: Color(0xFF1D2129),
                              fontSize: 16,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Expanded(child: Text('')),
                          if (_isNeedBank)
                            Images.pp_icon_selected
                          else
                            Images.pp_icon_selected_un,
                          Gaps.hGap10,
                        ],
                      ),
                    ),
                    onTap: () {
                      setStateDialog(() {
                        _isNeedBank = true;
                        _isNeedWx = false;
                        _isNeedZfb = false;
                        _payTypeChoose = '3';
                      });
                      setState(() {});
                      goBackLastPage(context);
                    },
                  )
                else
                  Container(),
                if (_isHaveWx) Gaps.vGap20 else Gaps.vGap0,
                if (_isHaveWx)
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      padding: const EdgeInsets.only(
                          left: 10, top: 20, bottom: 20, right: 10),
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        color: Colours.colorFFFFFF,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Row(
                        children: [
                          Gaps.hGap10,
                          Images.pp_card_icon_wx_20,
                          Gaps.hGap10,
                          const Text(
                            '微信支付',
                            style: TextStyle(
                              color: Color(0xFF1D2129),
                              fontSize: 16,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Expanded(child: Text('')),
                          if (_isNeedWx)
                            Images.pp_icon_selected
                          else
                            Images.pp_icon_selected_un,
                          Gaps.hGap10,
                        ],
                      ),
                    ),
                    onTap: () {
                      setStateDialog(() {
                        _isNeedBank = false;
                        _isNeedWx = true;
                        _isNeedZfb = false;
                        _payTypeChoose = '1';
                      });
                      setState(() {});
                      goBackLastPage(context);
                    },
                  )
                else
                  Container(),
                if (_isHaveZfb) Gaps.vGap20 else Gaps.vGap0,
                if (_isHaveZfb)
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      padding: const EdgeInsets.only(
                          left: 10, top: 20, bottom: 20, right: 10),
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        color: Colours.colorFFFFFF,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Row(
                        children: [
                          Gaps.hGap10,
                          Images.pp_card_icon_zfb_20,
                          Gaps.hGap10,
                          const Text(
                            '支付宝',
                            style: TextStyle(
                              color: Color(0xFF1D2129),
                              fontSize: 16,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Expanded(child: Text('')),
                          if (_isNeedZfb)
                            Images.pp_icon_selected
                          else
                            Images.pp_icon_selected_un,
                          Gaps.hGap10,
                        ],
                      ),
                    ),
                    onTap: () {
                      setStateDialog(() {
                        _isNeedBank = false;
                        _isNeedWx = false;
                        _isNeedZfb = true;
                        _payTypeChoose = '2';
                      });
                      setState(() {});
                      goBackLastPage(context);
                    },
                  )
                else
                  Container(),
              ],
            ),
          ),
        ]),
      );
}
