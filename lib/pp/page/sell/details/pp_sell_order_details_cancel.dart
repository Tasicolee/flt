import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/page/sell/details/pp_sell_order_details_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';

import '../../../../../util/toast_utils.dart';
import '../../../dio/pp_httpclient.dart';
import '../../../dio/pp_url_config.dart';

/// 订单详情-购买-已取消
class PpSellOrderDetailsCancelPage extends StatefulWidget {
  String order_id;

  PpSellOrderDetailsCancelPage({super.key, required this.order_id});

  @override
  _PageState createState() => _PageState(order_id: order_id);
}

class _PageState extends State<PpSellOrderDetailsCancelPage> {
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
                  Images.pp_icon_order_cancle,
                  Gaps.hGap8,
                  Text(
                    '已取消',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF999999),
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
}
