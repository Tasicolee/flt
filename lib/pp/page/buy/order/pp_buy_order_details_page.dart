import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';

import '../../../../util/toast_utils.dart';
import '../../../dio/pp_httpclient.dart';
import '../../../dio/pp_url_config.dart';
import '../../../utils/pp_countdown_widget.dart';

/// 订单详情-购买
class PpBuyOrderDetailsPage extends StatefulWidget {
  String order_id;

  PpBuyOrderDetailsPage({super.key, required this.order_id});

  @override
  _PageState createState() => _PageState(order_id: order_id);
}

class _PageState extends State<PpBuyOrderDetailsPage> {
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
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '买方需在',
                        style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 14,
                          fontFamily: 'PingFang HK',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                PpCountDownWidget(
                  _buyDetail == null
                      ? ''
                      : "${_buyDetail['buyer_paytime_limit']}",
                  textSize: 14,
                  textColor: const Color(0xFFFF7272),
                  isFinish: (e) {
                    if (e) {
                      //计时结束
                    }
                  },
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: ' 内完成付款，否则订单将自动取消',
                        style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 14,
                          fontFamily: 'PingFang HK',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            Gaps.vGap30,
            const Text(
              '1000,000 ED币',
              style: TextStyle(
                color: Color(0xFF1D1D21),
                fontSize: 28,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
            Gaps.vGap10,
            const Text(
              '¥1000,000',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF9194A6),
                fontSize: 14,
                fontFamily: 'PingFang HK',
                fontWeight: FontWeight.w400,
              ),
            ),
            Gaps.vGap30,
            Gaps.lineF6F6F6,
            Gaps.vGap30,
            const Row(
              children: [
                Gaps.hGap20,
                Expanded(
                  child: SizedBox(
                    child: Text(
                      '下单时间',
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
                  '2019.7.18 21:01:56',
                  textAlign: TextAlign.right,
                  style: TextStyle(
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
            const Row(
              children: [
                Gaps.hGap20,
                Expanded(
                  child: SizedBox(
                    child: Text(
                      '订单号',
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
                  '2019.7.18 21:01:56',
                  textAlign: TextAlign.right,
                  style: TextStyle(
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
            const Row(
              children: [
                Gaps.hGap20,
                Expanded(
                  child: SizedBox(
                    child: Text(
                      '付款参考号',
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
                  '2019.7.18 21:01:56',
                  textAlign: TextAlign.right,
                  style: TextStyle(
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
            const Row(
              children: [
                Gaps.hGap20,
                Expanded(
                  child: SizedBox(
                    child: Text(
                      '卖家昵称',
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
                  '2019.7.18 21:01:56',
                  textAlign: TextAlign.right,
                  style: TextStyle(
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
            const Row(
              children: [
                Gaps.hGap20,
                Expanded(
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
                  '2019.7.18 21:01:56',
                  textAlign: TextAlign.right,
                  style: TextStyle(
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
            Gaps.vGap10,
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
                    '身份证照片确保无水印无污溃，身份信息清晰，非文字反向照片，请勿进行PS处理',
                    style: TextStyles.txt12color1E1E1E,
                  ),
                ],
              ),
            ),
            Gaps.vGap50,
            Row(
              children: [
                Gaps.hGap20,
                SizedBox(
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
                                '申诉',
                                style: TextStyle(
                                  color: Color(0xFF272729),
                                  fontSize: 17,
                                  fontFamily: 'PingFang HK',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(child: Text('')),
                SizedBox(
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
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gaps.hGap20,
              ],
            )
          ],
        ),
      ),
    );

  dynamic? _buyDetail;

  void _getBuyDetail(String order_id) {
    //toStringAsFixed()会进行四舍五入
    PPHttpClient().get(PpUrlConfig.buyDetail, data: {
      'order_id': order_id,
    }, onSuccess: (jsonMap) {
      _buyDetail = jsonMap['data'];
      setState(() {});
    }, onError: (code, msg) {
      Toast.show(msg + code);
    });
  }
}
