import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';

/// 身份认证-失败
class PpAuthFailPage extends StatefulWidget {
  String reject_reason;

  PpAuthFailPage({super.key, required this.reject_reason});

  @override
  _PageState createState() => _PageState(reject_reason: reject_reason);
}

class _PageState extends State<PpAuthFailPage> {
  String reject_reason;

  _PageState({required this.reject_reason});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colours.app_main_bg,
        appBar: AppBar(
          systemOverlayStyle: ThemeUtils.appSystemUiOverlayStyle(),
          backgroundColor: Colours.app_main_bg,
          centerTitle: true,
          title: const Text('身份认证', style: TextStyles.txt18color000000),
          elevation: 0,
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Images.pp_back_top_left_page,
            onTap: () => Navigator.pop(context),
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
                  '身份认证失败',
                  style: TextStyles.txt26color1E232C,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  '身份认证未通过审核，请再次提交',
                  style: TextStyles.txt14color8391A1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20),
                child: Text(
                  reject_reason,
                  style: TextStyles.txt14color8391A1,
                ),
              ),
              Gaps.vGap32,
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _goPpAuthenticationPage(),
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
                        Text('再次认证', style: TextStyles.txt17colorFFFFFF),
                        Expanded(child: Text('')),
                      ],
                    )),
              )
            ],
          ),
        ),
      );

  void _goPpAuthenticationPage() {
    Navigator.pop(context);
    goPpAuthenticationPage(context, true);
  }
}
