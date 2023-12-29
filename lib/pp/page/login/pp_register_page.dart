import 'dart:convert';

import 'package:flustars_flutter3/flustars_flutter3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/pp/page/login/pp_register_success_page.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';

import '../../../res/constant.dart';
import '../../../util/theme_utils.dart';
import '../../../util/toast_utils.dart';
import '../../dio/pp_httpclient.dart';
import '../../dio/pp_url_config.dart';
import '../../utils/pp_global.dart';

/// 注册
class PpRegisterPage extends StatefulWidget {
  const PpRegisterPage({super.key});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PpRegisterPage> {
  final TextEditingController _editingController1 = TextEditingController();
  final TextEditingController _editingController2 = TextEditingController();
  final TextEditingController _editingController3 = TextEditingController();
  final TextEditingController _editingController4 = TextEditingController();

  Uint8List? _bytesBase64;
  String? _bytesBase64Key;

  bool _isObscure = true;
  bool _isObscure2 = true;

  @override
  void initState() {
    _getImgCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colours.app_main_bg,
        appBar: AppBar(
            backgroundColor: Colours.app_main_bg,
            centerTitle: true,
            title: const Text('', style: TextStyles.txt18color000000),
            elevation: 0,
            leading: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Images.pp_back_top_left_page,
              onTap: () => Navigator.pop(context),
            ),
            systemOverlayStyle: ThemeUtils.appSystemUiOverlayStyle()),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20),
                child: Text(
                  '注册账户',
                  style: TextStyles.txt30color272729,
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
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                    //只允许输入字母
                  ],
                  controller: _editingController1,
                  style: TextStyles.txt14color1F2024,
                  maxLength: 18,
                  decoration: const InputDecoration(
                    counterText: '',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: '请输入用户名',
                    hintStyle: TextStyles.txt14color8F9098,
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
                  obscureText: _isObscure,
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
                    hintText: '密码至少8位字符,数字/大写/小写字母/特殊符号组合',
                    hintStyle: TextStyles.txt14color8F9098,
                    suffixIcon: IconButton(
                        icon: Icon(
                          !_isObscure ? Icons.visibility : Icons.visibility_off,
                          size: 20,
                          color: Colours.colorA0BE4B,
                        ),
                        onPressed: () =>
                            setState(() => _isObscure = !_isObscure)),
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
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, //数字，只能是整数
                  ],
                  controller: _editingController3,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyles.txt14color1F2024,
                  maxLength: 18,
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: '请输入支付密码,6位数字',
                    hintStyle: TextStyles.txt14color8F9098,
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
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 10, bottom: 5),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(color: Colours.colorDEDEDE),
                  ),
                  child: Stack(
                    children: [
                      TextField(
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z0-9]')),
                          //只允许输入字母
                        ],
                        controller: _editingController4,
                        style: TextStyles.txt14color1F2024,
                        maxLength: 18,
                        decoration: const InputDecoration(
                          counterText: '',
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: '请输入验证码',
                          hintStyle: TextStyles.txt14color8F9098,
                        ),
                      ),
                      Positioned(
                          right: 10,
                          child: _bytesBase64 != null
                              ? GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () => _getImgCode(),
                                  child: Image.memory(
                                    _bytesBase64!,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : Container())
                    ],
                  )),
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
                        Text('同意协议并注册', style: TextStyles.txt17colorFFFFFF),
                        Expanded(child: Text('')),
                      ],
                    )),
                onTap: () => _goRegister(),
              ),
              Gaps.vGap50,
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: const Row(
                  children: [
                    Expanded(child: Text('')),
                    Text('注册代表您已同意? ', style: TextStyles.txt14color999999),
                    Text('《服务协议》', style: TextStyles.txt14colorA0BE4B),
                    Expanded(child: Text('')),
                  ],
                ),
                onTap: () => goPpUserTxtPage(context),
              )
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
    _editingController4.dispose();
    super.dispose();
  }

  void _goRegister() {
    if (_editingController1.text.isEmpty) {
      Toast.show('请输入用户名');
      return;
    }
    if (_editingController2.text.isEmpty) {
      Toast.show('请输入登录密码');
      return;
    }
    if (_editingController3.text.isEmpty) {
      Toast.show('请输入支付密码');
      return;
    }
    if (_editingController4.text.isEmpty) {
      Toast.show('请输入验证码');
      return;
    }
    _save();
  }

  /// 注册
  Future<void> _save() async =>
      PPHttpClient().post(PpUrlConfig.register, data: {
        'account': _editingController1.text,
        'password': _editingController2.text,
        'pay_password': _editingController3.text,
        'key': _bytesBase64Key,
        'captch_code': _editingController4.text,
        'reg_id': jPushGetRegistrationID,
      }, onSuccess: (jsonMap) {
        final String authorization =
            jsonMap['data']['authorization'].toString();
        SpUtil.putString(Constant.authorization, authorization);
        authorizationGlobal = authorization;
        Toast.show('注册成功');
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const PpRegisterSuccessPage()));
      }, onError: (code, msg) {
        Toast.show(msg + code);
      });

  Future<void> _getImgCode() async =>
      PPHttpClient().get(PpUrlConfig.captcha_image, onSuccess: (jsonMap) {
        final String img = jsonMap['data']['img'].toString().split(',')[1];
        _bytesBase64Key = jsonMap['data']['key'].toString();
        setState(() {
          _bytesBase64 = const Base64Decoder().convert(img);
        });
      }, onError: (code, msg) {
        Toast.show(msg + code);
      });
}
