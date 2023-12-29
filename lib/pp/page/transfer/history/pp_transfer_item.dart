import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';

import '../../../utils/pp_global.dart';

/// 转账记录 pp_order_item_buy.png
class PpTransferListItemPage extends StatelessWidget {
  PpTransferListItemPage({
    super.key,
    required this.item,
  });

  dynamic item;

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _itemClick(context),
        child: Container(
          margin: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 10, bottom: 10),
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            shadows: const [
              BoxShadow(
                color: Color(0x0C4A560E),
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
                                    child: _getShowTypeIcon(),
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
                                        _getShowType(),
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
                                  Gaps.vGap5,
                                  Text(
                                    '付款人：${item['sender_nickname']}',
                                    style: const TextStyle(
                                      color: Color(0xFF161313),
                                      fontSize: 11,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
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
                          fontWeight: FontWeight.w600,
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

  /**
   *     "1": "卖家挂单冻结金额",
      "2": "人工上分", .
      "3": "人工下分", .
      "4": "卖家放行扣减卖家冻结金额",
      "5": "买家买分",
      "6": "转出", .
      "7": "转入 .

      /// 账单类型
      /// dynamic? billTypeGlobal;
   ***/

  ///
  Widget _getShowTypeIcon() {
    var icon = Images.pp_order_item_sell;
    if (item['sender_user_id'].toString() ==
        ppUserEntityGlobal?.id.toString()) {
      icon = Images.pp_order_item_sell;
    } else if (item['recipient_user_id'].toString() ==
        ppUserEntityGlobal?.id.toString()) {
      icon = Images.pp_order_item_buy;
    } else {
      icon = Images.pp_order_item_buy;
    }

    return icon;
  }

  ///
  String _getShowType() {
    String str = '';
    if (item['sender_user_id'].toString() ==
        ppUserEntityGlobal?.id.toString()) {
      str = '转出';
    } else if (item['recipient_user_id'].toString() ==
        ppUserEntityGlobal?.id.toString()) {
      str = '转入';
    } else {
      str = '其他';
    }

    return str;
  }

  ///
  Container _rightTopView() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 6),
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

  void _itemClick(BuildContext context) {}
}
