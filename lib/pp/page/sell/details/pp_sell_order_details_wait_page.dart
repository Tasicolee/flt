import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/page/sell/details/pp_sell_order_details_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';

import '../../../../../util/toast_utils.dart';
import '../../../dio/pp_httpclient.dart';
import '../../../dio/pp_url_config.dart';
import '../../../utils/pp_countdown_widget.dart';
import '../../../utils/pp_navigator_utils.dart';

/// 订单详情-购买-1.待付款
class PpSellOrderDetailsWaitPage extends StatefulWidget {
  String order_id;

  PpSellOrderDetailsWaitPage({super.key, required this.order_id});

  @override
  _PageState createState() => _PageState(order_id: order_id);
}

class _PageState extends State<PpSellOrderDetailsWaitPage> {
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
              getSellTitleMoney(_buyDetail),
              itemSellView(_buyDetail),
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
                      '卖家付款完成后，请务必确认收到付款后再放行，否则可能造成数字资产损失',
                      style: TextStyles.txt12color1E1E1E,
                    ),
                  ],
                ),
              ),
              Gaps.vGap50,
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: const SizedBox(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '对该笔订单有疑问？',
                          style: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 14,
                            fontFamily: 'PingFang HK',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.37,
                          ),
                        ),
                        TextSpan(
                          text: '立即申诉',
                          style: TextStyle(
                            color: Color(0xFF0083FB),
                            fontSize: 14,
                            fontFamily: 'PingFang HK',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.37,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () =>
                    goPpSellOrderDetailsAppealPage(context, order_id: order_id),
              ),
              Gaps.vGap10,
              Row(
                children: [
                  const Expanded(child: Text('')),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _next(order_id),
                    child: SizedBox(
                      height: 50,
                      width: 335,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              width: 335,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFB6B6B6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1000),
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '放行',
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
                  const Expanded(child: Text('')),
                ],
              ),
              Gaps.vGap80
            ],
          ),
        ),
      );

  dynamic? _buyDetail;

  void _getBuyDetail(String order_id) =>
      PPHttpClient().get(PpUrlConfig.buyDetail, data: {
        'order_id': order_id,
      }, onSuccess: (jsonMap) {
        _buyDetail = jsonMap['data'];
        setState(() {});
      }, onError: (code, msg) {
        Toast.show(msg + code);
      });

  void _next(String order_id) {}
}
