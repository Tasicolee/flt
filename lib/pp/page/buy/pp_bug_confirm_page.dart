import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';

import '../../../../util/theme_utils.dart';
import '../../../../util/toast_utils.dart';
import '../../dio/pp_httpclient.dart';
import '../../dio/pp_url_config.dart';

/// 购买-确认页面
class PpBugConfirmPage extends StatefulWidget {
  String sellOrdersId;

  PpBugConfirmPage({super.key, required this.sellOrdersId});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PpBugConfirmPage> {
  final TextEditingController _controller = TextEditingController();
  var _data;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colours.app_main_bg,
        appBar: AppBar(
          systemOverlayStyle: ThemeUtils.appSystemUiOverlayStyle(),
          backgroundColor: Colours.app_main_bg,
          centerTitle: true,
          title: const Text('购买', style: TextStyles.txt18color000000),
          elevation: 0,
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Images.pp_back_top_left_page,
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildItem(),
              Gaps.vGap10,
              Row(
                children: [
                  Gaps.hGap20,
                  Text(
                    '购买数量',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  Expanded(child: Text('')),
                  Text(
                    '最低拆分限额：¥${_data == null ? '' : _data['available_amount']}',
                    style: TextStyle(
                      color: Color(0xFFF94E46),
                      fontSize: 11,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  Gaps.hGap20
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 5),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: Colours.colorDEDEDE),
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, //数字，只能是整数
                    //只允许输入字母
                  ],
                  controller: _controller,
                  style: TextStyles.txt14color1F2024,
                  maxLength: 18,
                  decoration: const InputDecoration(
                    counterText: '',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: '请输入数量',
                    hintStyle: TextStyles.txt14color8F9098,
                  ),
                  onChanged: (text) {
                    setState(() {});
                  },
                ),
              ),
              Gaps.vGap20,
              Row(
                children: [
                  Gaps.hGap20,
                  Text(
                    '支付金额',
                    style: TextStyle(
                      color: Color(0xFF86909C),
                      fontSize: 14,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Expanded(child: Text('')),
                  SizedBox(
                    child: Text(
                      '¥${_controller.text.isEmpty ? '0' : _controller.text}',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF1D2129),
                        fontSize: 14,
                        fontFamily: 'DIN',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Gaps.hGap20,
                ],
              ),
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
                          '交易须知:',
                          style: TextStyles.txt14color272729,
                        )
                      ],
                    ),
                    Gaps.vGap8,
                    Text(
                      '订单交易后，请在规定时间内完成转账。\n交易汇总，请使用已绑定个人收付款信息，若付款信息不符，此次交易损失自行承担。\n交易中，如遇无法支付，交易纠纷，请及时联系客服处理。 \n请勿随意取消订单，一经发现恶意取消，永久封停。',
                      style: TextStyles.txt12color1E1E1E,
                    ),
                  ],
                ),
              ),
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
                        Text('购买', style: TextStyles.txt17colorFFFFFF),
                        Expanded(child: Text('')),
                      ],
                    )),
                onTap: () => _buyClick(),
              )
            ],
          ),
        ),
      );

  Container _buildItem() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      decoration: const BoxDecoration(
          color: Colours.colorFFFFFF, //设置背景颜色
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Images.pp_logo_circle24,
              Gaps.hGap10,
              Text(_data == null ? '' : _data['seller_nickname'].toString(),
                  style: TextStyles.txt14color000000),
            ],
          ),
          Gaps.vGap10,
          const Text('数量', style: TextStyles.txt11colorB7B7B7),
          Gaps.vGap10,
          Text(_data == null ? '' : _data['available_amount'].toString(),
              style: TextStyles.txt24color000000),
          Stack(
            clipBehavior: Clip.none,
            children: [
              _getTypeView(
                  (_data == null ? '' : _data['account_info_types'].toString())
                      .split(',')),
            ],
          ),
        ],
      ));

  /// account_info_types 账户类型 (1微信, 2支付宝, 3银行卡)
  GridView _getTypeView(List list) => GridView.builder(
        padding: const EdgeInsets.only(top: 10, bottom: 5),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 15, //每行三列
          crossAxisSpacing: 10.0, // 横向间距
          mainAxisSpacing: 15.0, // 纵向间距
        ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          if (list[index].toString() == '1') {
            return Images.pp_card_icon_wx;
          } else if (list[index].toString() == '2') {
            return Images.pp_card_icon_zfb;
          } else if (list[index].toString() == '3') {
            return Images.pp_card_icon_card;
          }
        },
      );

  void _getData() => PPHttpClient().get(PpUrlConfig.sellDetail,
          data: {'sell_orders_id': widget.sellOrdersId}, onSuccess: (jsonMap) {
        _data = jsonMap['data'];
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
                Gaps.vGap20,
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                        Images.arrowRight,
                        Gaps.hGap10,
                      ],
                    ),
                  ),
                  onTap: () async => _save('3'),
                ),
                Gaps.vGap20,
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                        Images.arrowRight,
                        Gaps.hGap10,
                      ],
                    ),
                  ),
                  onTap: () async => _save('1'),
                ),
                Gaps.vGap20,
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                        Images.arrowRight,
                        Gaps.hGap10,
                      ],
                    ),
                  ),
                  onTap: () async {
                    _save('2');
                  },
                ),
              ],
            ),
          ),
        ]),
      );

  _buyClick() {
    if (_controller.text.isEmpty) {
      Toast.show('请输入购买数量');
      return;
    }
    String money = (_data == null ? '' : _data['available_amount'].toString());
    if (int.parse(_controller.text) < double.parse(money)) {
      Toast.show('购买金额不能小于最低可拆分金额');
      return;
    }
    _showBankCardDialog();
  }

  /// (1微信, 2支付宝, 3银行卡)
  void _save(String paymentAccountInfoId) {
    //toStringAsFixed()会进行四舍五入
    final a = double.parse(_controller.text);
    final b = a.toStringAsFixed(0);
    PPHttpClient().post(PpUrlConfig.transactionBuy, data: {
      'transaction_amount': b,
      'account_info_type': '1',
      'payment_account_info_id': paymentAccountInfoId,
      'sell_orders_id': widget.sellOrdersId,
    }, onSuccess: (jsonMap) {
      final String orderId = jsonMap['data']['order_id'].toString();
      goBackLastPage(context);
      goBackLastPage(context);
      goPpBuyOrderDetailsWaitPage(context, order_id: orderId);
    }, onError: (code, msg) {
      Toast.show(msg + code);
    });
  }
}
