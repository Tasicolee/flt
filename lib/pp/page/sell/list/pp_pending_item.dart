import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';

import '../../../../util/other_utils.dart';
import '../../../../util/toast_utils.dart';
import '../../../dio/pp_httpclient.dart';
import '../../../dio/pp_url_config.dart';
import '../../../utils/pp_navigator_utils.dart';

/// 我的挂单 viewpager
class PpPendingListItemPage extends StatefulWidget {
  dynamic item;
  bool isHome = false;

  PpPendingListItemPage({
    super.key,
    required this.item,
    required this.isHome,
  });

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PpPendingListItemPage> {
  bool isNeedClose = false;

  @override
  Widget build(BuildContext context) => _buildItem();

  Widget _buildItem() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      width: double.infinity,
      margin: widget.isHome
          ? const EdgeInsets.all(0)
          : const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
      decoration: const BoxDecoration(
          color: Colours.colorFFFFFF, //设置背景颜色
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('挂单金额', style: TextStyles.txt13color99999),
              const Expanded(child: Text('')),
              Container(child: _btnView())
            ],
          ),
          Gaps.vGap16,
          Text(widget.item['order_amount'].toString(),
              style: TextStyles.txt20color272729),
          Gaps.vGap16, //进度条显示50%
          LinearProgressIndicator(
              backgroundColor: Colours.colorF5F5F5,
              valueColor: const AlwaysStoppedAnimation(Color(0xFF0057FB)),
              value: double.parse(widget.item['sold_amount'].toString()) /
                  double.parse(widget.item['order_amount'].toString()),
              minHeight: 10,
              borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          Gaps.vGap16,

          Row(
            children: [
              const Text('已售金额', style: TextStyles.txt13color99999),
              Gaps.hGap5,
              Text(widget.item['sold_amount'].toString(),
                  style: TextStyles.txt13color000000),
              const Expanded(child: Text('')),
              Text(
                  '${(double.parse(widget.item['sold_amount'].toString()) / double.parse(widget.item['order_amount'].toString())) * 100}%',
                  style: TextStyles.txt13color99999),
            ],
          ),
          Gaps.vGap16,
          _getTypeView(widget.item['account_info_types'].toString().split(',')),
          Gaps.vGap1,
        ],
      ));

  /// account_info_types 账户类型 (1微信, 2支付宝, 3银行卡)
  GridView _getTypeView(List list) => GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 15, //每行三列
          crossAxisSpacing: 10.0, // 横向间距
          mainAxisSpacing: 15.0, // 纵向间距
        ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          if (list[index].toString() == '1') {
            return Images.pp_card_icon_wx;
          } else if (list[index].toString() == '2') {
            return Images.pp_card_icon_zfb;
          } else if (list[index].toString() == '3') {
            return Images.pp_card_icon_card;
          }
        },
      );

  /// status	string	挂单状态：0.待审核,1.挂单中, 2已下架
  Container? _btnView() {
    Container container = Container();
    if (isNeedClose) {
      container = _yixaijia();
    } else {
      if (widget.item['status'].toString() == '0') {
        container = _shenhezhong();
      } else if (widget.item['status'].toString() == '1') {
        container = _xaijia();
      } else if (widget.item['status'].toString() == '2') {
        container = _yixaijia();
      } else {
        if (widget.item['available_amount'].toString() == '2') {
          container = _shouqin();
        }
      }
      return container;
    }
  }

  Container _xaijia() => Container(
        height: 24,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0x33D3D3D3)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: const Text(
                '下架',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 12,
                  fontFamily: 'PingFang HK',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.37,
                ),
              ),
              onTap: () => _showHintDialog(),
            )
          ],
        ),
      );

  Container _shouqin() => Container(
        height: 24,
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
              child: const Stack(children: [Images.pp_order_statue_ok14]),
            ),
            const SizedBox(width: 3),
            const Text(
              '已售罄',
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

  Container _shenhezhong() => Container(
        height: 24,
        padding: const EdgeInsets.symmetric(horizontal: 6),
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
              child:
                  const Stack(children: [Images.pp_icon_order_statue_wait14]),
            ),
            const SizedBox(width: 2),
            const Text(
              '审核中',
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

  Container _yixaijia() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        decoration: ShapeDecoration(
          color: const Color(0xFFF9FAF5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '已下架',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF999999),
                fontSize: 12,
                fontFamily: 'PingFang HK',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.37,
              ),
            ),
          ],
        ),
      );

  void _showHintDialog() => showElasticDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Material(
            color: Colours.app_main_bg,
            type: MaterialType.transparency,
            child: Center(
              child: Container(
                height: 130,
                constraints:
                    const BoxConstraints(minHeight: 100, minWidth: 100),
                margin: const EdgeInsets.only(
                    left: 50, right: 50, top: 150, bottom: 50),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Column(
                  children: [
                    Gaps.vGap20,
                    const Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            '确认下架该挂单，下架后将冻结30分钟才可再次出售。',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF272729),
                              fontSize: 16,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 44,
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
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () => goBackLastPage(context),
                                    child: Container(
                                      height: 44,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFFE5E6EB),
                                          ),
                                          top: BorderSide(
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFFE5E6EB),
                                          ),
                                          right: BorderSide(
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFFE5E6EB),
                                          ),
                                          bottom: BorderSide(
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFFE5E6EB),
                                          ),
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 11),
                                      clipBehavior: Clip.antiAlias,
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              height: 22,
                                              child: Text(
                                                '取消',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xFF999999),
                                                  fontSize: 16,
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () => _close(),
                                    child: Container(
                                      height: 44,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 11),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFFE5E6EB),
                                          ),
                                          top: BorderSide(
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFFE5E6EB),
                                          ),
                                          right: BorderSide(
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFFE5E6EB),
                                          ),
                                          bottom: BorderSide(
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFFE5E6EB),
                                          ),
                                        ),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              height: 22,
                                              child: Text(
                                                '确定',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xFF0083FB),
                                                  fontSize: 16,
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
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
                  ],
                ),
              ),
            ),
          );
        },
      );

  void _close() => PPHttpClient().post(PpUrlConfig.sellClose,
          data: {'id': widget.item['id'].toString()}, onSuccess: (jsonMap) {
        widget.item['status'] = '2';
        isNeedClose = true;
        setState(() {});
      }, onError: (code, msg) {
        Toast.show(msg + code);
      });
}
