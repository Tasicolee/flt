import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/page/buy/office/list/pp_buy_office_order_item_page.dart';
import 'package:flutter_deer/pp/utils/pp_global.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';

/// 订单记录-购买 viewpager
class PpBuyOfficeListItemPage extends StatefulWidget {
  PpBuyOfficeListItemPage({
    super.key,
    required this.item,
  });

  dynamic item;

  @override
  _PageState createState() => _PageState(item: this.item);
}

class _PageState extends State<PpBuyOfficeListItemPage> {
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
                          '订单号#${item['platform_order_no']}',
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
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 4,
                                            top: 1,
                                            bottom: 2,
                                            right: 4),
                                        margin: const EdgeInsets.only(
                                            left: 5, top: 0),
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 1,
                                                color: Color(0xFFA0BE4B)),
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                        ),
                                        child: Text(
                                          '官方',
                                          style: TextStyle(
                                            color: Color(0xFFA0BE4B),
                                            fontSize: 10,
                                            fontFamily: 'PingFang SC',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    child: Opacity(
                                      opacity: 0.40,
                                      child: Text(
                                        '${item['created_at']}',
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
                                        '交易总额：${item['amount']}',
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
                        '${item['amount']} PP',
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

  ///订单状态：1.未出售，2.处理中，3.待审核，4.已完成,5.失败6.已回收，7.支付超时
  Container _rightTopView() {
    var c = Container();
    final String orderStatus = item['status'].toString();
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
    } else if (orderStatus == '7') {
      c = _rightTopView7();
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
              '处理中',
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
              '待审核',
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
              '失败',
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
              '已回收',
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

  Container _rightTopView7() => Container(
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
              '付款超时',
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
    ///订单状态：1.未出售，2.处理中，3.待审核，4.已完成,5.失败6.已回收，7.支付超时
    //买家
    String status = item['status'].toString();
    String order_id = item['id'].toString();
    if (status == '1') {
      await goPpOfficeBuyOrderDetailsWaitPage(context, order_id: order_id);
      eventBus.fire(PpBuyOfficeOrderItemPage);
    } else if (status == '2') {
      await goPpOfficeBuyOrderDetailsPaidPage(context, order_id: order_id);
      eventBus.fire(PpBuyOfficeOrderItemPage);
    } else if (status == '3') {
      await goPpOfficeBuyOrderDetailsWaitingReleasePage(context,
          order_id: order_id);
      eventBus.fire(PpBuyOfficeOrderItemPage);
    } else if (status == '4') {
      await goPpOfficeBuyOrderDetailsDonePage(context, order_id: order_id);
      eventBus.fire(PpBuyOfficeOrderItemPage);
    } else if (status == '5') {
      await goPpOfficeBuyOrderDetailsCancelPage(context, order_id: order_id);
      eventBus.fire(PpBuyOfficeOrderItemPage);
    } else if (status == '6') {
      await goPpOfficeBuyOrderDetailsCancelPage(context, order_id: order_id);
      eventBus.fire(PpBuyOfficeOrderItemPage);
    } else if (status == '7') {
      await goPpOfficeBuyOrderDetailsCancelPage(context, order_id: order_id);
      eventBus.fire(PpBuyOfficeOrderItemPage);
    }
  }
}
