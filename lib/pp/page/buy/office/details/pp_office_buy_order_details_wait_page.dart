import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/page/buy/office/details/pp_office_buy_order_details_utils.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';

import '../../../../../util/toast_utils.dart';
import '../../../../dio/pp_httpclient.dart';
import '../../../../dio/pp_url_config.dart';
import '../../../../utils/pp_countdown_widget.dart';

/// 订单详情-购买-1.待付款
class PpOfficeBuyOrderDetailsWaitPage extends StatefulWidget {
  String order_id;

  PpOfficeBuyOrderDetailsWaitPage({super.key, required this.order_id});

  @override
  _PageState createState() => _PageState(order_id: order_id);
}

class _PageState extends State<PpOfficeBuyOrderDetailsWaitPage> {
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
                        : "${_buyDetail['order_lock_duration']}000",
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
              getPpOfficeBuyTitleMoney(_buyDetail),
              itemPpOfficeBuyView(_buyDetail),
              Gaps.vGap20,
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
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _buyPay(order_id),
                child: Container(
                  width: 335,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: Color(0xFF0083FB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x70A0BE4B),
                        blurRadius: 12,
                        offset: Offset(0, 5),
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
                        '上传凭证，完成付款',
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
              Gaps.vGap80,
            ],
          ),
        ),
      );

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
    goBackLastPage(context);
    goPpOfficeBuyOrderDetailsUploadPage(context, order_id: orderId);
  }

  var elementItem; //当前的付款方式payment_info

  void _getBuyDetail(String orderId) =>
      PPHttpClient().get(PpUrlConfig.buyOfficeDetail, data: {
        'supply_orders_id': orderId,
      }, onSuccess: (jsonMap) {
        _buyDetail = jsonMap['data'];
        setState(() {});
      }, onError: (code, msg) {
        Toast.show(msg + code);
      });
}
