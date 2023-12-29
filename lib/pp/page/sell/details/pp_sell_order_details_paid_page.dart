import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/page/sell/details/pp_sell_order_details_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';

import '../../../../../util/toast_utils.dart';
import '../../../dio/pp_httpclient.dart';
import '../../../dio/pp_url_config.dart';
import '../../../utils/pp_navigator_utils.dart';

/// 订单详情-购买-2.买家已付款,(卖家待放行)
class PpSellOrderDetailsPaidPage extends StatefulWidget {
  String order_id;

  PpSellOrderDetailsPaidPage({super.key, required this.order_id});

  @override
  _PageState createState() => _PageState(order_id: order_id);
}

class _PageState extends State<PpSellOrderDetailsPaidPage> {
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
                    '已付款',
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
              getSellTitleMoney(_buyDetail),
              itemSellView(_buyDetail),
              Gaps.vGap20,
              Gaps.vGap50,
              Row(
                children: [
                  const Expanded(child: Text('')),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _next(order_id),
                    child: SizedBox(
                      width: 335,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '上传凭证',
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

  void _next(String order_id) {
    goBackLastPage(context);
    goPpBuyOrderDetailsUploadPage(context, order_id: order_id);
  }
}
