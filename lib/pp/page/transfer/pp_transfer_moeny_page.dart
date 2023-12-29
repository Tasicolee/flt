import 'package:f_verification_box/f_verification_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/pp/page/transfer/pp_transfer_success_page.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';

import '../../../util/toast_utils.dart';
import '../../dio/pp_httpclient.dart';
import '../../dio/pp_url_config.dart';
import '../../utils/pp_global.dart';

/// 转账给
class PpTransferMoneyPage extends StatefulWidget {
  String walletCode;
  bool showAdd;

  PpTransferMoneyPage(
      {super.key, required this.walletCode, required this.showAdd});

  @override
  _PageState createState() =>
      _PageState(walletCode: walletCode, showAdd: showAdd);
}

class _PageState extends State<PpTransferMoneyPage> {
  String walletCode;
  bool showAdd;

  _PageState({required this.walletCode, required this.showAdd});

  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colours.app_main_bg,
      appBar: const MyAppBar(
        centerTitle: '转账给',
        backgroundColor: Colours.app_main_bg,
      ),
      body: Column(
        children: [
          Text(walletCode,
              style: TextStyle(
                color: Color(0xFF0083FB),
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w600,
              )),
          Gaps.vGap50, //9194A6
          const Row(
            children: [
              Expanded(child: Text('')),
              Images.pp_home_card_logo,
              Gaps.hGap4,
              Text('ED币', style: TextStyles.txt20color9194A6),
              Expanded(child: Text(''))
            ],
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, //数字，只能是整数
                ],
                textAlign: TextAlign.center,
                style: TextStyles.txt48colorB2D33,
                controller: _inputController,
                maxLength: 18,
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding:
                      const EdgeInsets.only(left: 90, top: 20, bottom: 20),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: '0',
                  hintStyle: TextStyles.txt48colorB7B7B7,
                  suffixIcon: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                        alignment: Alignment.center,
                        width: 70,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 1, vertical: 1.0),
                        margin:
                            const EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
                        decoration: const BoxDecoration(
                            color: Colours.colorFFFFFF, //设置背景颜色
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: const Text('max',
                            style: TextStyles.txt17color272729)),
                    onTap: () => _inputController.text =
                        ppUserEntityGlobal!.account_balance.toString(),
                  ),
                ),
              ),
            ],
          ),
          Text('余额：${ppUserEntityGlobal?.account_balance}',
              style: TextStyles.txt12color9194A6),
          Gaps.vGap150,
          _freeView(),
          Gaps.vGap20,
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _summit(),
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
                    Text('转账', style: TextStyles.txt17colorFFFFFF),
                    Expanded(child: Text('')),
                  ],
                )),
          ),
        ],
      ));

  void _summit() {
    if (_inputController.text.isEmpty) {
      Toast.show('请输入转账金额');
      return;
    }
    _showPwdDialog();
  }

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
                    walletCode,
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

  void _savePwd(String strPwd) => _transfer(strPwd);

  void _goPpTransferSuccessPage(
      String amount, String recipientUserId, String recipientNickname) {
    //跳转并关闭当前页面
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => PpTransferSuccessPage(
                  amount: amount,
                  contact_id: recipientUserId,
                  recipient_nickname: recipientNickname,
                  showAdd: showAdd,
                )),
        (route) => route == null);
  }

//      参数名	必选	类型	说明
//      amount	是	string	转账金额
//      recipient_wallet_code	是	string	收款钱包地址
//      pay_password	是	string	支付密码
  Future<void> _transfer(String strPwd) async {
    PPHttpClient().post(PpUrlConfig.transfer, data: {
      'amount': _inputController.text,
      'recipient_wallet_code': walletCode,
      'pay_password': strPwd,
    }, onSuccess: (jsonMap) {
      String amount = jsonMap['data']['amount'].toString();
      String recipient_user_id =
          jsonMap['data']['recipient_user_id'].toString();
      String recipient_nickname =
          jsonMap['data']['recipient_nickname'].toString();
      _goPpTransferSuccessPage(amount, recipient_user_id, recipient_nickname);
    }, onError: (code, msg) {
      Toast.show(msg + code);
    });
  }

  Widget _freeView() {
    if (transfer_fee?.isNotEmpty == true && _inputController.text.isNotEmpty) {
      debugPrint('-----1111');
      final String s =
          ((int.parse(transfer_fee!) * (int.parse(_inputController.text))) /
                  100)
              .toString();
      return Text('手续费：$s ED币', style: TextStyles.txt12color9194A6);
    } else {
      debugPrint('-----2222');
      return Container();
    }
  }
}
