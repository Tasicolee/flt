import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';

import '../../../../../util/toast_utils.dart';
import '../../../dio/pp_httpclient.dart';
import '../../../dio/pp_url_config.dart';

/// 卖家-申诉
class PpSellOrderDetailsAppealPage extends StatefulWidget {
  String order_id;

  PpSellOrderDetailsAppealPage({super.key, required this.order_id});

  @override
  _PageState createState() => _PageState(order_id: order_id);
}

class _PageState extends State<PpSellOrderDetailsAppealPage> {
  String order_id;

  _PageState({required this.order_id});

  bool _isNeed1 = true;
  bool _isNeed2 = false;
  bool _isNeed3 = false;
  bool _isNeed4 = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colours.app_main_bg,
        appBar: const MyAppBar(
          centerTitle: '申诉',
          backgroundColor: Colours.app_main_bg,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 16, top: 20, bottom: 10),
                child: const Text(
                  '请选择申诉理由',
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 14,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                padding: const EdgeInsets.only(
                    left: 20, top: 20, bottom: 20, right: 20),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colours.colorFFFFFF,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          children: [
                            const Text(
                              '我未收到买家付款',
                              style: TextStyle(
                                color: Color(0xFF1D2129),
                                fontSize: 14,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Expanded(child: Text('')),
                            if (_isNeed1)
                              Images.pp_icon_selected
                            else
                              Images.pp_icon_selected_un
                          ],
                        ),
                        onTap: () => setState(() {
                              _isNeed1 = true;
                              _isNeed2 = false;
                              _isNeed3 = false;
                              _isNeed4 = false;
                            })),
                    Gaps.vGap10,
                    Gaps.lineF5F5F5,
                    Gaps.vGap10,
                    GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          children: [
                            const Text(
                              '收到买家付款，但是金额不符',
                              style: TextStyle(
                                color: Color(0xFF1D2129),
                                fontSize: 14,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Expanded(
                              child: Text(''),
                            ),
                            if (_isNeed2)
                              Images.pp_icon_selected
                            else
                              Images.pp_icon_selected_un
                          ],
                        ),
                        onTap: () => setState(() {
                              _isNeed1 = false;
                              _isNeed2 = true;
                              _isNeed3 = false;
                              _isNeed4 = false;
                            })),
                    Gaps.vGap10,
                    Gaps.lineF5F5F5,
                    Gaps.vGap10,
                    GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          children: [
                            const Text(
                              '收到买家付款，但是买家付款账户\n与实名信息不一致',
                              style: TextStyle(
                                color: Color(0xFF1D2129),
                                fontSize: 14,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Expanded(
                              child: Text(''),
                            ),
                            if (_isNeed3)
                              Images.pp_icon_selected
                            else
                              Images.pp_icon_selected_un
                          ],
                        ),
                        onTap: () => setState(() {
                              _isNeed1 = false;
                              _isNeed2 = false;
                              _isNeed3 = true;
                              _isNeed4 = false;
                            })),
                    Gaps.vGap10,
                    Gaps.lineF5F5F5,
                    Gaps.vGap10,
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        children: [
                          const Text(
                            '其他',
                            style: TextStyle(
                              color: Color(0xFF1D2129),
                              fontSize: 14,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Expanded(
                            child: Text(''),
                          ),
                          if (_isNeed4)
                            Images.pp_icon_selected
                          else
                            Images.pp_icon_selected_un
                        ],
                      ),
                      onTap: () => setState(() {
                        _isNeed1 = false;
                        _isNeed2 = false;
                        _isNeed3 = false;
                        _isNeed4 = true;
                      }),
                    )
                  ],
                ),
              ),
              if (_isNeed4)
                Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                  clipBehavior: Clip.antiAlias,
                  padding: const EdgeInsets.all(20.0),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF7F8F9),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Color(0xFFD9D9D9)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        maxLength: 200,
                        controller: _controller,
                        style: TextStyles.txt14color1F2024,
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: '请输入申诉原因',
                          hintStyle: TextStyle(
                            color: Color(0xFFD7D7D7),
                            fontSize: 14,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onChanged: (text) {},
                      ),
                    ],
                  ),
                )
              else
                Container(),
              Gaps.vGap20,
              Container(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 10, right: 10, bottom: 20),
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
                      '提交申诉后，该部分资产将会被冻结，平台申诉专员将人工介入，请保持电话通畅，恶意申诉将会被冻结账号',
                      style: TextStyles.txt12color1E1E1E,
                    ),
                  ],
                ),
              ),
              Gaps.vGap50,
              Row(
                children: [
                  const Expanded(child: Text('')),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
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
                                  )
                                ],
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '确定申诉',
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
                    onTap: () => _buyAppeal(order_id),
                  ),
                  const Expanded(child: Text(''))
                ],
              ),
              Gaps.vGap80
            ],
          ),
        ),
      );

  void _buyAppeal(String order_id) =>
      PPHttpClient().post(PpUrlConfig.buyAppeal, data: {
        'order_id': order_id,
        'appeal_reason': _getSaveString(),
      }, onSuccess: (jsonMap) {
        Toast.show('申述成功');
        goBackLastPage(context);
      }, onError: (code, msg) {
        Toast.show(msg + code);
      });

  String _getSaveString() {
    String str = '';
    if (_isNeed1) {
      str = '我未收到买家付款';
    } else if (_isNeed2) {
      str = '收到买家付款，但是金额不符';
    } else if (_isNeed3) {
      str = '收到买家付款，但是买家付款账户与实名信息不一致';
    } else if (_isNeed4) {
      str = _controller.text;
    }
    return str;
  }
}
