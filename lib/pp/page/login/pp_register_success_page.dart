import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';

import '../../../util/theme_utils.dart';
import '../../utils/pp_navigator_utils.dart';

/// 注册成功
class PpRegisterSuccessPage extends StatefulWidget {
  const PpRegisterSuccessPage({super.key});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PpRegisterSuccessPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
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
            onTap: () => goPpLoginPage(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Gaps.vGap100,
              Images.pp_success_mark,
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20),
                child: Text(
                  '注册成功',
                  style: TextStyles.txt26color1E232C,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  '你已经成功注册ED Pay',
                  style: TextStyles.txt14color8391A1,
                ),
              ),
              Gaps.vGap32,
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => goPpLoginPage(context),
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
                        Text('返回登录', style: TextStyles.txt17colorFFFFFF),
                        Expanded(child: Text('')),
                      ],
                    )),
              )
            ],
          ),
        ),
      );
}
