import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast_utils.dart';

import '../../../../dio/pp_httpclient.dart';
import '../../../../dio/pp_url_config.dart';

/// 修改登录密码
class PpChangeLoginPasswordPage extends StatefulWidget {
  const PpChangeLoginPasswordPage({super.key});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PpChangeLoginPasswordPage> {
  final TextEditingController _editingController1 = TextEditingController();
  final TextEditingController _editingController2 = TextEditingController();
  final TextEditingController _editingController3 = TextEditingController();

  bool _isObscure1 = true;
  bool _isObscure2 = true;
  bool _isObscure3 = true;

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
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 5),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: Colours.colorDEDEDE),
                ),
                child: TextField(
                  obscureText: _isObscure1,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _editingController1,
                  style: TextStyles.txt14color1F2024,
                  maxLength: 18,
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: '请输入旧密码',
                    hintStyle: TextStyles.txt14color999999,
                    suffixIcon: IconButton(
                        icon: Icon(
                          !_isObscure1
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 20,
                          color: Colours.colorA0BE4B,
                        ),
                        onPressed: () =>
                            setState(() => _isObscure1 = !_isObscure1)),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 5),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: Colours.colorDEDEDE),
                ),
                child: TextField(
                  obscureText: _isObscure2,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _editingController2,
                  style: TextStyles.txt14color1F2024,
                  maxLength: 18,
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: '请输入新密码',
                    hintStyle: TextStyles.txt14color999999,
                    suffixIcon: IconButton(
                        icon: Icon(
                          !_isObscure2
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 20,
                          color: Colours.colorA0BE4B,
                        ),
                        onPressed: () =>
                            setState(() => _isObscure2 = !_isObscure2)),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 5),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: Colours.colorDEDEDE),
                ),
                child: TextField(
                  obscureText: _isObscure3,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _editingController3,
                  style: TextStyles.txt14color1F2024,
                  maxLength: 18,
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: '确认密码',
                    hintStyle: TextStyles.txt14color999999,
                    suffixIcon: IconButton(
                        icon: Icon(
                          !_isObscure3
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 20,
                          color: Colours.colorA0BE4B,
                        ),
                        onPressed: () =>
                            setState(() => _isObscure3 = !_isObscure3)),
                  ),
                ),
              ),
              Gaps.vGap32,
              GestureDetector(
                behavior: HitTestBehavior.opaque,
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
                        Text('确定', style: TextStyles.txt17colorFFFFFF),
                        Expanded(child: Text('')),
                      ],
                    )),
                onTap: () => _summit(),
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    // 释放
    _editingController1.dispose();
    _editingController2.dispose();
    _editingController3.dispose();
    super.dispose();
  }

  void _summit() {
    if (_editingController1.text.isEmpty) {
      Toast.show('请输入旧密码');
      return;
    }
    if (_editingController2.text.isEmpty) {
      Toast.show('请输入新密码');
      return;
    }
    if (_editingController3.text.isEmpty) {
      Toast.show('请输入确认密码');
      return;
    }
    if (_editingController2.text != _editingController3.text) {
      Toast.show('密码不一致');
      return;
    }
    _save();
  }

  /**
   * old_password	是	string	旧密码
      new_password	是	string	新密码
   */

  ///
  Future<void> _save() async {
    PPHttpClient().post(PpUrlConfig.change_password, data: {
      'old_password': _editingController1.text,
      'new_password': _editingController2.text,
    }, onSuccess: (jsonMap) {
      Toast.show('修改成功');
      Navigator.pop(context);
    }, onError: (code, msg) {
      Toast.show(msg + code);
    });
  }
}
