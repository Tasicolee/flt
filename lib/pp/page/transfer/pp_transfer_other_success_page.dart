import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';

/// 转账成功
class PpTransferOtherSuccessPage extends StatefulWidget {
  String amount;

  PpTransferOtherSuccessPage({
    super.key,
    required this.amount,
  });

  @override
  _PageState createState() => _PageState(
        amount: amount,
      );
}

class _PageState extends State<PpTransferOtherSuccessPage> {
  String amount;

  _PageState({
    required this.amount,
  });

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () async {
        _goMain();
        return false; //不退出
      },
      child: _body());

  Scaffold _body() => Scaffold(
        backgroundColor: Colours.app_main_bg,
        appBar: AppBar(
          systemOverlayStyle: ThemeUtils.appSystemUiOverlayStyle(),
          backgroundColor: Colours.app_main_bg,
          centerTitle: true,
          title: const Text('', style: TextStyles.txt18color000000),
          elevation: 0,
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Images.pp_back_top_left_page,
            onTap: () => _goMain(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Gaps.vGap100,
              Images.pp_pay_ok,
              Gaps.vGap12,
              const Text(
                '成功',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF0083FB),
                  fontSize: 16,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.20,
                ),
              ),
              Gaps.vGap50,
              SizedBox(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: amount,
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
              Gaps.vGap20,
              Gaps.lineF6F6F6,
              Gaps.vGap100,
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _goMain(),
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
                        Text('完成', style: TextStyles.txt17colorFFFFFF),
                        Expanded(child: Text('')),
                      ],
                    )),
              )
            ],
          ),
        ),
      );

  void _goMain() => goPPHomeTabPage(context, isRefresh: true, needPwd: false);
}
