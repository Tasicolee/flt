import 'package:f_verification_box/f_verification_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';

import '../../../util/toast_utils.dart';
import '../../dio/pp_httpclient.dart';
import '../../dio/pp_url_config.dart';
import '../../utils/pp_global.dart';

/**
 * {"platform_order_no":"MR20231105152048848423632",
 * "amount":"200.00","wallet_code":"PPDdbe5b15a37fba8ea",
 * "created_at":"2023-11-05 15:20:48",
 * "paytime_limit":1799842556,"type":"recharge"}
 */

/// 转账-商户
class PpTransferOtherPage extends StatefulWidget {
  String platform_order_no;

  PpTransferOtherPage({super.key, required this.platform_order_no});

  @override
  _PpTransferPageState createState() => _PpTransferPageState();
}

class _PpTransferPageState extends State<PpTransferOtherPage> {
  dynamic? _info;
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    _getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colours.app_main_bg,
      appBar: AppBar(
        systemOverlayStyle: ThemeUtils.appSystemUiOverlayStyle(),
        backgroundColor: Colours.app_main_bg,
        centerTitle: true,
        title: const Text('充值', style: TextStyles.txt18color000000),
        elevation: 0,
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Images.pp_back_top_left_page,
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Gaps.vGap40,
          SizedBox(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: _info?['amount'].toString(),
                    style: const TextStyle(
                      color: Color(0xFF2B2D33),
                      fontSize: 48,
                      fontFamily: 'DIN',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.30,
                    ),
                  ),
                  const TextSpan(
                    text: 'ED',
                    style: TextStyle(
                      color: Color(0xFF2B2D33),
                      fontSize: 32,
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
          Gaps.vGap20,
          Text(
            '余额 : ${ppUserEntityGlobal?.account_balance} ED',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF9194A6),
              fontSize: 12,
              fontFamily: 'PingFang HK',
              fontWeight: FontWeight.w400,
              letterSpacing: 0.37,
            ),
          ),
          Gaps.vGap20,
          Gaps.lineF5F5F5,
          Gaps.vGap20,
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.hGap20,
              const Expanded(
                child: SizedBox(
                  child: Text(
                    '收款地址',
                    style: TextStyle(
                      color: Color(0xFF86909C),
                      fontSize: 14,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Text.rich(
                TextSpan(
                  text: _info?['wallet_code'].toString(),
                  style: const TextStyle(
                    color: Color(0xFF1D2129),
                    fontSize: 14,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Gaps.hGap20,
            ],
          ),
          Gaps.vGap20,
          GestureDetector(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.hGap20,
                const Expanded(
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
                Text.rich(
                  TextSpan(
                    text: _info?['platform_order_no'].toString(),
                    style: const TextStyle(
                      color: Color(0xFF1D2129),
                      fontSize: 14,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Gaps.hGap5,
                Images.pp_home_copy_grey,
                Gaps.hGap20
              ],
            ),
            onTap: () => copyString(_info?['platform_order_no'].toString()),
          ),
          Gaps.vGap20,
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.hGap20,
              const Expanded(
                child: SizedBox(
                  child: Text(
                    '创建时间',
                    style: TextStyle(
                      color: Color(0xFF86909C),
                      fontSize: 14,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Text.rich(
                TextSpan(
                  text: _info?['created_at'].toString(),
                  style: const TextStyle(
                    color: Color(0xFF1D2129),
                    fontSize: 14,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Gaps.hGap20,
            ],
          ),
          Gaps.vGap100,
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _showPwdDialog(),
            child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 15.0),
                margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                decoration: const BoxDecoration(
                    color: Colours.colorA0BE4B, //设置背景颜色
                    gradient: LinearGradient(
                      begin: Alignment(1.00, -0.07),
                      end: Alignment(-1, 0.07),
                      colors: [
                        Color(0xFF00CEF6),
                        Color(0xFF0057FB),
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: const Row(
                  children: [
                    Expanded(child: Text('')),
                    Text('确认支付', style: TextStyles.txt17colorFFFFFF),
                    Expanded(child: Text('')),
                  ],
                )),
          ),
        ],
      ));

  Future<void> _getInfo() async {
    PPHttpClient().get(PpUrlConfig.payRechargeOther, data: {
      'platform_order_no': widget.platform_order_no,
    }, onSuccess: (jsonMap) {
      _info = jsonMap['data'];
      setState(() {});
    }, onError: (code, msg) {
      Toast.show(msg + code);
    });
  }

  void _showPwdDialog() {
    if (_info?['wallet_code'].toString() == null ||
        _info?['wallet_code'].toString() == 'null') {
      return Toast.show('请重新扫码支付');
    }
    showModalBottomSheet<void>(
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
                  onSubmitted: (str, v2) => _summit(str),
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
  }

  /**
   * platform_order_no	是	string	平台订单号
      wallet_code	是	string	钱包地址
      pay_password	是	string	支付密码
   */

  ///
  void _summit(String strPwd) async =>
      PPHttpClient().post(PpUrlConfig.payRechargeSaveOther, data: {
        'platform_order_no': widget.platform_order_no,
        'wallet_code': _info?['wallet_code'].toString(),
        'pay_password': strPwd
      }, onSuccess: (jsonMap) {
        goPpTransferOtherSuccessPage(
            context, _info?['amount'].toString() ?? '');
      }, onError: (code, msg) {
        Toast.show(msg + code);
      });
}
