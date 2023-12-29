import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/page/buy/order/list/pp_buy_order_item_page.dart';
import 'package:flutter_deer/pp/utils/pp_global.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';

/// 订单记录-购买 viewpager
class PpBuyListItemPage extends StatefulWidget {
  PpBuyListItemPage({
    super.key,
    required this.item,
  });

  dynamic item;

  @override
  _PageState createState() => _PageState(item: this.item);
}

class _PageState extends State<PpBuyListItemPage> {
  dynamic item;

  _PageState({required this.item});

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _itemClick(),
        child: Container(
          margin: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 10, bottom: 10),
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: ShapeDecoration(
            color: Colors.white,
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
                      child: SizedBox(
                        child: Text(
                          '订单号#${item['order_number']}',
                          style: const TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 12,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    _rightTopView(),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0x33D3D3D3),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 60,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 32,
                              height: 32,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: (item['seller_id'].toString() ==
                                            ppUserEntityGlobal?.id.toString())
                                        ? Images.pp_order_item_sell
                                        : Images.pp_order_item_buy,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              height: double.infinity,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (item['seller_id'].toString() ==
                                                ppUserEntityGlobal?.id
                                                    .toString())
                                            ? '出售'
                                            : '购买',
                                        style: const TextStyle(
                                          color: Color(0xFF272729),
                                          fontSize: 14,
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    child: Opacity(
                                      opacity: 0.40,
                                      child: Text(
                                        '${item['updated_at']}',
                                        style: const TextStyle(
                                          color: Color(0xFF161313),
                                          fontSize: 11,
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    child: Opacity(
                                      opacity: 0.40,
                                      child: Text(
                                        '交易总额：${item['transaction_amount']}',
                                        style: const TextStyle(
                                          color: Color(0xFF161313),
                                          fontSize: 11,
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w400,
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
                    ),
                    Positioned(
                      right: 0,
                      top: 8,
                      child: Text(
                        '${item['transaction_amount']} PP',
                        style: const TextStyle(
                          color: Color(0xFF0083FB),
                          fontSize: 16,
                          fontFamily: 'DIN',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  /// ：1.待付款，2.买家已付款,(卖家待放行)，
  ///     // 3.买家已上传凭证（等待卖家放行）,(卖家待放行)4.已完成，5.已取消，6.申述中
  Container _rightTopView() {
    var c = Container();
    final String orderStatus = item['order_status'].toString();
    if (orderStatus == '1') {
      c = _rightTopView1();
    } else if (orderStatus == '2') {
      c = _rightTopView2();
    } else if (orderStatus == '3') {
      c = _rightTopView3();
    } else if (orderStatus == '4') {
      c = _rightTopView4();
    } else if (orderStatus == '5') {
      c = _rightTopView5();
    } else if (orderStatus == '6') {
      c = _rightTopView6();
    }
    return c;
  }

  Container _rightTopView1() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: ShapeDecoration(
          color: const Color(0x33CFE888),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 14,
              height: 14,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: const Stack(children: [Images.pp_icon_selected]),
            ),
            const SizedBox(width: 3),
            const Text(
              '待付款',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF0083FB),
                fontSize: 12,
                fontFamily: 'PingFang HK',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.37,
              ),
            ),
          ],
        ),
      );

  Container _rightTopView2() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: ShapeDecoration(
          color: const Color(0x14FFAA44),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 14,
              height: 14,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: const Stack(children: [Images.pp_icon_order_wait2_14]),
            ),
            const SizedBox(width: 3),
            const Text(
              '待放行',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFFFAA44),
                fontSize: 12,
                fontFamily: 'PingFang HK',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.37,
              ),
            ),
          ],
        ),
      );

  Container _rightTopView3() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: ShapeDecoration(
          color: const Color(0x33CFE888),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 14,
              height: 14,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: const Stack(children: [Images.pp_icon_selected]),
            ),
            const SizedBox(width: 3),
            const Text(
              '已付款,上传凭证,等卖家放行',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF0083FB),
                fontSize: 12,
                fontFamily: 'PingFang HK',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.37,
              ),
            ),
          ],
        ),
      );

  Container _rightTopView4() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: ShapeDecoration(
          color: const Color(0x33CFE888),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 14,
              height: 14,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: const Stack(children: [Images.pp_icon_selected]),
            ),
            const SizedBox(width: 3),
            const Text(
              '已完成',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF0083FB),
                fontSize: 12,
                fontFamily: 'PingFang HK',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.37,
              ),
            ),
          ],
        ),
      );

  Container _rightTopView5() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: ShapeDecoration(
          color: const Color(0xFFF6F6F6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 14,
              height: 14,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: const Stack(children: [
                Images.pp_icon_order_cancle14,
              ]),
            ),
            const SizedBox(width: 3),
            const Text(
              '已取消',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFB6B6B6),
                fontSize: 12,
                fontFamily: 'PingFang HK',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.37,
              ),
            ),
          ],
        ),
      );

  Container _rightTopView6() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: ShapeDecoration(
          color: const Color(0x19FF7272),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 14,
              height: 14,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: const Stack(children: [
                Images.pp_pay_appeal14,
              ]),
            ),
            const SizedBox(width: 3),
            const Text(
              '已申诉',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFFF7272),
                fontSize: 12,
                fontFamily: 'PingFang HK',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.37,
              ),
            ),
          ],
        ),
      );

//特别说明：这里前端需要根据目前的用户id与buyer_id（买家id）和seller_id（买家id）
// 做比较来确定此订单是出售类型还是购买类型。假如当前用户id==buyer_id 说明是购买，
// 假如用户ID==seller_id 说明是出售
  Future<void> _itemClick() async {
    //order_status	int	订单状态：1.待付款，2.买家已付款,(卖家待放行)，
    // 3.买家已上传凭证（等待卖家放行）,(卖家待放行)4.已完成，5.已取消，6.申述中
    if (item['buyer_id'].toString() == ppUserEntityGlobal?.id.toString()) {
      //买家
      String order_status = item['order_status'].toString();
      String order_id = item['id'].toString();
      if (order_status == '1') {
        await goPpBuyOrderDetailsWaitPage(context, order_id: order_id);
        eventBus.fire(PpBuyOrderItemPage);
      } else if (order_status == '2') {
        await goPpBuyOrderDetailsPaidPage(context, order_id: order_id);
        eventBus.fire(PpBuyOrderItemPage);
      } else if (order_status == '3') {
        await goPpBuyOrderDetailsWaitingReleasePage(context,
            order_id: order_id);
        eventBus.fire(PpBuyOrderItemPage);
      } else if (order_status == '4') {
        await goPpBuyOrderDetailsDonePage(context, order_id: order_id);
        eventBus.fire(PpBuyOrderItemPage);
      } else if (order_status == '5') {
        await goPpBuyOrderDetailsCancelPage(context, order_id: order_id);
        eventBus.fire(PpBuyOrderItemPage);
      } else if (order_status == '6') {
        await goPpBuyOrderDetailsAppealPage(context, order_id: order_id);
        eventBus.fire(PpBuyOrderItemPage);
      }
    } else if (item['seller_id'].toString() ==
        ppUserEntityGlobal?.id.toString()) {
      //卖家
      String order_status = item['order_status'].toString();
      String order_id = item['id'].toString();
      if (order_status == '1') {
        await goPpSellOrderDetailsWaitPage(context, order_id: order_id);
        eventBus.fire(PpBuyOrderItemPage);
      } else if (order_status == '2') {
        await goPpSellOrderDetailsWaitingReleasePage(context,
            order_id: order_id);
        eventBus.fire(PpBuyOrderItemPage);
      } else if (order_status == '3') {
        await goPpSellOrderDetailsWaitingReleasePage(context,
            order_id: order_id);
        eventBus.fire(PpBuyOrderItemPage);
      } else if (order_status == '4') {
        await goPpSellOrderDetailsDonePage(context, order_id: order_id);
        eventBus.fire(PpBuyOrderItemPage);
      } else if (order_status == '5') {
        await goPpSellOrderDetailsCancelPage(context, order_id: order_id);
        eventBus.fire(PpBuyOrderItemPage);
      } else if (order_status == '6') {
        await goPpSellOrderDetailsAppealPage(context, order_id: order_id);
        eventBus.fire(PpBuyOrderItemPage);
      }
    }
  }
}
