import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/pp/page/login/pp_register_page.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/pp/utils/pp_user_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/toast_utils.dart';
import 'package:sp_util/sp_util.dart';

import '../../../res/constant.dart';
import '../../../util/theme_utils.dart';
import '../../dio/pp_httpclient.dart';
import '../../dio/pp_url_config.dart';
import '../../utils/pp_global.dart';

/// 登陆
class PpLoginPage extends StatefulWidget {
  const PpLoginPage({super.key});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PpLoginPage> {
  final TextEditingController _editingController1 = TextEditingController();
  final TextEditingController _editingController2 = TextEditingController();
  final TextEditingController _editingController4 = TextEditingController();

  bool _isObscure = true;

  int _indexFail = 0;
  Uint8List? _bytesBase64;
  String? _bytesBase64Key;

  @override
  void initState() {
    sys_config_login();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            backgroundColor: Colours.app_main_bg,
            centerTitle: true,
            title: const Text('', style: TextStyles.txt18color000000),
            elevation: 0,
            systemOverlayStyle: ThemeUtils.appSystemUiOverlayStyle()),
        backgroundColor: Colours.app_main_bg,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.vGap100,
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20, bottom: 10),
                child: Images.pp_logo_circle60,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20),
                child: Text(
                  '欢迎使用ED Pay',
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
                  style: TextStyles.txt14color1F2024,
                  controller: _editingController1,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                    //只允许输入字母
                  ],
                  maxLength: 18,
                  decoration: const InputDecoration(
                    counterText: '',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: '请输入账号',
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
                  style: TextStyles.txt14color1F2024,
                  controller: _editingController2,
                  maxLength: 18,
                  keyboardType: TextInputType.visiblePassword,
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
              if (_indexFail < int.parse(login_err_num ?? '100'))
                Container()
              else
                Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    padding:
                        const EdgeInsets.only(left: 20.0, top: 10, bottom: 5),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
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
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 1),
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
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => goKf(context),
                child: const Row(
                  children: [
                    Expanded(child: Text('')),
                    Padding(
                        padding: EdgeInsets.only(right: 20.0, top: 10),
                        child:
                            Text('忘记密码?', style: TextStyles.txt14color999999)),
                  ],
                ),
              ),
              Gaps.vGap32,
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _login(),
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 15.0),
                    margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                    decoration: const BoxDecoration(
                        // color: Colours.colorA0BE4B, //设置背景颜色
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
                        Text('登录', style: TextStyles.txt17colorFFFFFF),
                        Expanded(child: Text('')),
                      ],
                    )),
              ),
              Gaps.vGap20,
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: const Row(
                  children: [
                    Expanded(child: Text('')),
                    Text('还没有账户? ', style: TextStyles.txt14color272729NoBold),
                    Text('立即注册', style: TextStyles.txt14colorA0BE4B),
                    Expanded(child: Text('')),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PpRegisterPage()));
                },
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
    super.dispose();
  }

  void _login() {
    if (_editingController1.text.isEmpty) {
      Toast.show('请输入账号');
      return;
    }
    if (_editingController2.text.isEmpty) {
      Toast.show('请输入密码');
      return;
    }
    _save();
  }

  /**
   *  account	是	string	账号
      password	是	string	密码
      key	是	string	验证码key，达到登录次数之后需要加验证码参数
      captch_code	是	string	图形验证码，达到登录失败次数之后需要加验证码
   */

  /// 注册
  Future<void> _save() async => PPHttpClient().post(PpUrlConfig.login, data: {
        'account': _editingController1.text,
        'password': _editingController2.text,
        'key': _bytesBase64Key,
        if (_indexFail < int.parse(login_err_num ?? '100'))
          'captch_code': _editingController4.text,
        if (_indexFail < int.parse(login_err_num ?? '100'))
          'reg_id': jPushGetRegistrationID,
      }, onSuccess: (jsonMap) {
        final String authorization =
            jsonMap['data']['authorization'].toString();
        SpUtil.putString(Constant.authorization, authorization);
        authorizationGlobal = authorization;
        Toast.show('登录成功');
        SpUtil.putBool(Constant.isLogin, true);
        _goMain();
      }, onError: (code, msg) {
    _indexFail++;
        Toast.show(msg + code);
        setState(() {});
        if (_indexFail < int.parse(login_err_num ?? '100')) {
          _getImgCode();
        }
      });

  void _goMain() => goPPHomeTabPage(context, isRefresh: true, needPwd: false);

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
