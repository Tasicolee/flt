import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/page/buy/order/details/pp_buy_order_details_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';

import '../../../../../util/toast_utils.dart';
import '../../../../dio/pp_httpclient.dart';
import '../../../../dio/pp_url_config.dart';
import '../../../../utils/pp_navigator_utils.dart';

/// 订单详情-购买-已完成
class PpBuyOrderDetailsDonePage extends StatefulWidget {
  String order_id;

  PpBuyOrderDetailsDonePage({super.key, required this.order_id});

  @override
  _PageState createState() => _PageState(order_id: order_id);
}

class _PageState extends State<PpBuyOrderDetailsDonePage> {
  String order_id;

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
                  Images.pp_pay_ok20,
                  Gaps.hGap8,
                  Text(
                    '已完成',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF0083FB),
                      fontSize: 20,
                      fontFamily: 'PingFang HK',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.37,
                    ),
                  )
                ],
              ),
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
                onTap: () => _showBankCardDialog(),
                child: getBuyPayView(_payTypeChoose),
              ),
              Gaps.vGap20,
              _getBuyPayView(),
              Gaps.vGap80
            ],
          ),
        ),
      );

  dynamic? _buyDetail;

  String _payTypeChoose = '';

  bool _isNeedBank = false;
  bool _isNeedWx = false;
  bool _isNeedZfb = false;

  bool _isHaveBank = false;
  bool _isHaveWx = false;
  bool _isHaveZfb = false;
  var elementItem; //当前的付款方式payment_info

  Widget _getBuyPayView() {
    if (_buyDetail == null) {
      return Container();
    }
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
