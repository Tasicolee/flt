import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/page/buy/office/details/pp_office_buy_order_details_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';

import '../../../../../util/toast_utils.dart';
import '../../../../dio/pp_httpclient.dart';
import '../../../../dio/pp_url_config.dart';

/// 订单详情-购买-已取消
class PpOfficeBuyOrderDetailsCancelPage extends StatefulWidget {
  String order_id;

  PpOfficeBuyOrderDetailsCancelPage({super.key, required this.order_id});

  @override
  _PageState createState() => _PageState(order_id: order_id);
}

class _PageState extends State<PpOfficeBuyOrderDetailsCancelPage> {
  String order_id;

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
              getPpOfficeBuyTitleMoney(_buyDetail),
              itemPpOfficeBuyView(_buyDetail),
              Gaps.vGap80
            ],
          ),
        ),
      );

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
