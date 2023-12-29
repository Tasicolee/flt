import 'package:f_verification_box/f_verification_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/page/sell/details/pp_sell_order_details_utils.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';

import '../../../../../util/toast_utils.dart';
import '../../../dio/pp_httpclient.dart';
import '../../../dio/pp_url_config.dart';

/// 订单详情-购买-待放行
class PpSellOrderDetailsWaitingReleasePage extends StatefulWidget {
  String order_id;

  PpSellOrderDetailsWaitingReleasePage({super.key, required this.order_id});

  @override
  _PageState createState() => _PageState(order_id: order_id);
}

class _PageState extends State<PpSellOrderDetailsWaitingReleasePage> {
  String order_id;
  final TextEditingController _inputController = TextEditingController();

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
                  Images.pp_icon_order_wait2,
                  Gaps.hGap8,
                  Text(
                    '待放行',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFFAA44),
                      fontSize: 20,
                      fontFamily: 'PingFang HK',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.37,
                    ),
                  )
                ],
              ),
              Gaps.vGap10,
              const Text(
                '买家已完成付款，请尽快放行',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 14,
                  fontFamily: 'PingFang HK',
                  fontWeight: FontWeight.w400,
                ),
              ),
              getSellTitleMoney(_buyDetail),
              itemSellView(_buyDetail),
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
                      '卖家付款完成后，请务必确认收到付款后再放行，否则可能造成数字资产损失',
                      style: TextStyles.txt12color1E1E1E,
                    ),
                  ],
                ),
              ),
              Gaps.vGap50,
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: const SizedBox(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '对该笔订单有疑问？',
                          style: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 14,
                            fontFamily: 'PingFang HK',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.37,
                          ),
                        ),
                        TextSpan(
                          text: '立即申诉',
                          style: TextStyle(
                            color: Color(0xFF0083FB),
                            fontSize: 14,
                            fontFamily: 'PingFang HK',
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.37,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () =>
                    goPpSellOrderDetailsAppealPage(context, order_id: order_id),
              ),
              Gaps.vGap10,
              Row(
                children: [
                  const Expanded(child: Text('')),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _showPwdDialog(),
                    child: SizedBox(
                      height: 50,
                      width: 335,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              width: 335,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF0083FB),
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

  void _getBuyDetail(String orderId) =>
      PPHttpClient().get(PpUrlConfig.buyDetail, data: {
        'order_id': orderId,
      }, onSuccess: (jsonMap) {
        _buyDetail = jsonMap['data'];
        setState(() {});
      }, onError: (code, msg) {
        Toast.show(msg + code);
      });

  void _showPwdDialog() => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) => SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              color: Colours.app_main_bg,
              child: Column(
                children: [
                  Gaps.vGap20,
                  Row(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => Navigator.pop(context),
                        child: Images.pp_back_top_left_page,
                      ),
                      const Expanded(child: Text('')),
                      const Text(
                        '请输入资金密码',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF1F2024),
                          fontSize: 16,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Expanded(child: Text('')),
                      Gaps.hGap32,
                    ],
                  ),
                  Gaps.vGap32,
                  const Text(
                    '转账给',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.20,
                    ),
                  ),
                  Text(
                    _buyDetail == null
                        ? ''
                        : _buyDetail['buyer_nickname'].toString(),
                    style: const TextStyle(
                      color: Color(0xFF0083FB),
                      fontSize: 14,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gaps.vGap20,
                  SizedBox(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: _inputController.text,
                            style: const TextStyle(
                              color: Color(0xFF2B2D33),
                              fontSize: 48,
                              fontFamily: 'DIN',
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.30,
                            ),
                          ),
                          const TextSpan(
                            text: 'ED币',
                            style: TextStyle(
                              color: Color(0xFF2B2D33),
                              fontSize: 24,
                              fontFamily: 'DIN',
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.30,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  VerificationBox(
                    textStyle: const TextStyle(
                      color: Color(0xFF1F2024),
                      fontSize: 16,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                    ),
                    showCursor: true,
                    cursorColor: Colours.colorA0BE4B,
                    onChanged: (v) {},
                    onSubmitted: (str, v2) => _savePwd(str),
                    // onSubmitted: OnSubmitted{},
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Gaps.vGap16,
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => goKf(context),
                    child: const Text(
                      '忘记密码？',
                      style: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 14,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Gaps.vGap40,
                  Container(
                    height: MediaQuery.of(context).viewInsets.bottom,
                  )
                ],
              )),
        ),
      );
  String _stringPwd = '';

  void _savePwd(String strPwd) {
    _stringPwd = strPwd;
    goBackLastPage(context);
    _showPwdNextDialog();
  }

  Future<Future<int?>> _showPwdNextDialog() async => showModalBottomSheet<int>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
          builder: (context, setState) => _showPwdNextDialogView(setState),
        ),
      );

  bool _isUnChoose = true;

  Container _showPwdNextDialogView(StateSetter setState) => Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Colours.app_main_bg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.45,
        child: Column(children: [
          SizedBox(
            height: 50,
            child: Stack(
              textDirection: TextDirection.rtl,
              children: [
                Positioned(
                    left: 0,
                    top: 5,
                    child: IconButton(
                        icon: const Icon(Icons.keyboard_arrow_left),
                        onPressed: () => Navigator.of(context).pop())),
                const Center(
                  child: Text(
                    '收款方式',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1F2024),
                      fontSize: 16,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Gaps.vGap20,
                const SizedBox(
                  width: 307,
                  child: Text(
                    '请务必登录网上银行或第三方支付平台确认收到该笔付款',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFF7272),
                      fontSize: 18,
                      fontFamily: 'PingFang HK',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.29,
                    ),
                  ),
                ),
                Gaps.vGap50,
                _showHintView(setState),
                Gaps.vGap30,
                Row(
                  children: [
                    const Expanded(child: Text('')),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 162.50,
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
                              '取消',
                              style: TextStyle(
                                color: Color(0xFF272729),
                                fontSize: 17,
                                fontFamily: 'PingFang HK',
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.37,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        goBackLastPage(context);
                      },
                    ),
                    const Expanded(child: Text('')),
                    _showBtnView(),
                    const Expanded(child: Text('')),
                  ],
                ),
                Gaps.vGap20,
              ],
            ),
          ),
        ]),
      );

  SizedBox _showBtnView() {
    var c = const SizedBox();
    if (_isUnChoose) {
      c = SizedBox(
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
                      '确定放行',
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
      );
    } else {
      c = SizedBox(
        width: 162.50,
        height: 50,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
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
                        '确定放行',
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
          onTap: () => _saveNext(_stringPwd),
        ),
      );
    }

    return c;
  }

  GestureDetector _showHintView(StateSetter setState) {
    var c = Container();
    if (_isUnChoose) {
      c = Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFFD9D9D9)),
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0C4A590E),
              blurRadius: 16,
              offset: Offset(0, 6),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(0.80),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.60),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 14.40,
                          height: 14.40,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.80, color: Color(0xFFD1D1D1)),
                              borderRadius: BorderRadius.circular(80),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            const SizedBox(
              width: 243,
              child: Text(
                '我确认已经登录收款账户，并核对收款无误',
                style: TextStyle(
                  color: Color(0xFF272729),
                  fontSize: 14,
                  fontFamily: 'PingFang HK',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      c = Container(
        height: 64,
        padding: const EdgeInsets.only(
          top: 12,
          left: 20,
          right: 20,
          bottom: 12,
        ),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFFD9D9D9)),
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0C4A590E),
              blurRadius: 16,
              offset: Offset(0, 6),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: const Stack(children: [
                      Images.pp_icon_selected,
                    ]),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14.60),
            const SizedBox(
              width: 243,
              child: Text(
                '我确认已经登录收款账户，并核对收款无误',
                style: TextStyle(
                  color: Color(0xFF0083FB),
                  fontSize: 14,
                  fontFamily: 'PingFang HK',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: c,
      onTap: () {
        setState(() {
          _isUnChoose = !_isUnChoose;
        });
      },
    );
  }

  /**
      order_id	是	string	订单id
      pay_password	是	string	支付密码
   */

  ///
  void _saveNext(String strPwd) =>
      PPHttpClient().post(PpUrlConfig.sellRelease, data: {
        'order_id': order_id,
        'pay_password': strPwd,
      }, onSuccess: (jsonMap) {
        Toast.show('放行成功');
        goBackLastPage(context);
        goBackLastPage(context);
      }, onError: (code, msg) {
        Toast.show(msg + code);
      });
}
