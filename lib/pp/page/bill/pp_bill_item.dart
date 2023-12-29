import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';

import '../../utils/pp_global.dart';

/// 账单记录
class PpBillListItemPage extends StatelessWidget {
  PpBillListItemPage({
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
                          '订单号#${item['order_id']}',
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
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: SizedBox(
                        height: 40,
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
                                        _getShowTypeString(),
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
                        '${_getShowTypeAdd()}${item['value']} PP',
                        style: TextStyle(
                          color: Color(_getShowTypeAdd() == '+'
                              ? 0xFF0083FB
                              : 0xFF272729),
                          fontSize: 16,
                          fontFamily: 'DIN',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gaps.lineF5F5F5,
              _bottomMoneyView()
            ],
          ),
        ),
      );

  Container _bottomMoneyView() => Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                height: 33,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 33,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    child: Text(
                                      '帐变数量',
                                      style: TextStyle(
                                        color: Color(0xFF999999),
                                        fontSize: 11,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  SizedBox(
                                    child: Text(
                                      '¥${item['value']}',
                                      style: const TextStyle(
                                        color: Color(0xFF999999),
                                        fontSize: 11,
                                        fontFamily: 'PingFang SC',
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
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: SizedBox(
                height: 33,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 33,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    child: Text(
                                      '可用余额',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF999999),
                                        fontSize: 11,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  SizedBox(
                                    child: Text(
                                      '¥${item['after']}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Color(0xFF999999),
                                        fontSize: 11,
                                        fontFamily: 'PingFang SC',
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
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: SizedBox(
                height: 33,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 33,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    child: Text(
                                      '总余额',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Color(0xFF999999),
                                        fontSize: 11,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  SizedBox(
                                    child: Text(
                                      '¥${item['before']}',
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                        color: Color(0xFF999999),
                                        fontSize: 11,
                                        fontFamily: 'PingFang SC',
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  ///
  Widget _getShowTypeIcon() {
    var icon = Images.pp_order_item_sell;
    if (_getShowTypeAdd() == '+') {
      icon = Images.pp_order_item_buy;
    } else if (_getShowTypeAdd() == '-') {
      icon = Images.pp_order_item_sell;
    } else {
      icon = Container();
    }
    return icon;
  }

  ///
  String _getShowTypeString() {
    String str = '';
    final String type = item['type'].toString();
    str = billTypeGlobal == null
        ? ''
        : billTypeGlobal[type]['type_name'].toString();
    return str;
  }

  /// + -
  String _getShowTypeAdd() {
    String str = '';
    final String type = item['type'].toString();
    str =
        billTypeGlobal == null ? '' : billTypeGlobal[type]['symbol'].toString();
    return str;
  }

  ///
  void _itemClick(BuildContext context) {}
}
