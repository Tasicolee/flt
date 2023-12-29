import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast_utils.dart';

import '../../../util/other_utils.dart';
import '../../dio/pp_httpclient.dart';
import '../../dio/pp_url_config.dart';

/// 转账成功
class PpTransferSuccessPage extends StatefulWidget {
  String amount;
  String recipient_nickname;
  String contact_id;
  bool showAdd;

  PpTransferSuccessPage({
    super.key,
    required this.amount,
    required this.recipient_nickname,
    required this.contact_id,
    required this.showAdd,
  });

  @override
  _PageState createState() => _PageState(
    amount: amount,
        recipient_nickname: recipient_nickname,
        contact_id: contact_id,
        showAdd: showAdd,
      );
}

class _PageState extends State<PpTransferSuccessPage> {
  String amount;
  String recipient_nickname;
  String contact_id;
  bool showAdd;

  _PageState({
    required this.amount,
    required this.recipient_nickname,
    required this.contact_id,
    required this.showAdd,
  });

  final TextEditingController _editingController1 = TextEditingController();

  @override
  void initState() {
    _editingController1.text = recipient_nickname;
    super.initState();
  }

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
                '转账成功',
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
              Gaps.vGap20,
              Row(
                children: [
                  Gaps.hGap20,
                  const Text(
                    '收款人',
                    style: TextStyle(
                      color: Color(0xFFB6B6B6),
                      fontSize: 14,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Expanded(child: Text('')),
                  Text(
                    recipient_nickname,
                    style: const TextStyle(
                      color: Color(0xFF0083FB),
                      fontSize: 14,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gaps.hGap8,
                  if (showAdd)
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Images.pp_icon_add_bank14,
                      onTap: () => _showHintDialog(),
                    )
                  else
                    Container(),
                  Gaps.hGap20
                ],
              ),
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

  void _showHintDialog() {
    /// 关闭输入法，避免弹出
    FocusManager.instance.primaryFocus?.unfocus();
    showElasticDialog<void>(
      context: context,
      builder: (BuildContext context) {
        const OutlinedBorder buttonShape = RoundedRectangleBorder();
        final Widget content = Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              '输入备注',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFB6B6B6),
                fontSize: 16,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w600,
              ),
            ),
            TextField(
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF0083FB),
                fontSize: 16,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w600,
              ),
              controller: _editingController1,
              maxLength: 18,
              decoration: const InputDecoration(
                counterText: '',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: '输入备注',
                hintStyle: TextStyle(
                  color: Color(0xFFeeeeee),
                  fontSize: 16,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Gaps.lineF6F6F6,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    '取消',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 16,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )),
                const SizedBox(
                    height: 50,
                    child: VerticalDivider(color: Colours.colorF5F5F5)),
                Expanded(
                    child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _save(),
                  child: const Text(
                    '保存',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF0083FB),
                      fontSize: 16,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )),
              ],
            )
          ],
        );

        final Widget decoration = Container(
          decoration: BoxDecoration(
            color: Colours.app_main_bg,
            borderRadius: BorderRadius.circular(8.0),
          ),
          width: 270.0,
          padding: const EdgeInsets.only(top: 24.0),
          child: TextButtonTheme(
            data: TextButtonThemeData(
              style: TextButton.styleFrom(
                // 文字颜色
                foregroundColor: const Color(0xFFB6B6B6),
                // 按钮大小
                minimumSize: Size.infinite,
                // 修改默认圆角
                shape: buttonShape,
              ),
            ),
            child: content,
          ),
        );

        return Material(
          color: Colours.app_main_bg,
          type: MaterialType.transparency,
          child: Center(
            child: decoration,
          ),
        );
      },
    );
  }

  void _save() => _contactAdd();

  Future<void> _contactAdd() async =>
      PPHttpClient().post(PpUrlConfig.contactAdd, data: {
        'contact_id': contact_id,
        'user_remark': _editingController1.text,
      }, onSuccess: (jsonMap) {
        Toast.show('保存成功');
        Navigator.pop(context);
      }, onError: (code, msg) {
        Toast.show(msg + code);
      });
}
