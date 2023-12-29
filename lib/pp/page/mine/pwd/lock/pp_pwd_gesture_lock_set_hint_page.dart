import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';

import '../../../../../widgets/my_app_bar.dart';

/// 手势锁 设置 提示
class PpPwdLockGestureSetHintPage extends StatefulWidget {
  const PpPwdLockGestureSetHintPage({super.key});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PpPwdLockGestureSetHintPage> {
  @override
  Widget build(BuildContext context) => _body();

  Scaffold _body() => Scaffold(
      backgroundColor: Colours.app_main_bg,
      appBar: const MyAppBar(
          centerTitle: '手势密码', backgroundColor: Colours.app_main_bg),
      body: Column(
        children: [
          Gaps.vGap50,
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '开启手势密码\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: '进一步保障你的账号安全',
                  style: TextStyle(
                    color: Color(0xFFB6B6B6),
                    fontSize: 14,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Gaps.vGap30,
          Images.pp_pwd_lock_hint,
          Gaps.vGap50,
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _summit(),
            child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 15.0),
                margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                decoration: const BoxDecoration(
                    //color: Colours.colorA0BE4B, //设置背景颜色
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
                    Text('下一步', style: TextStyles.txt17colorFFFFFF),
                    Expanded(child: Text('')),
                  ],
                )),
          ),
        ],
      ));

  Future<void> _summit() async {
    await goPpPwdLockGestureSetPage(context, '开启手势密码');
    goBackLastPage(context);
  }
}
