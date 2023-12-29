import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';

import '../../../../util/theme_utils.dart';
import '../../../../util/toast_utils.dart';
import '../../../dio/pp_httpclient.dart';
import '../../../dio/pp_url_config.dart';

/// 银行卡绑定
class PpAddBankPage extends StatefulWidget {
  const PpAddBankPage({super.key});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PpAddBankPage> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colours.app_main_bg,
        appBar: AppBar(
          systemOverlayStyle: ThemeUtils.appSystemUiOverlayStyle(),
          backgroundColor: Colours.app_main_bg,
          centerTitle: true,
          title: const Text('银行卡绑定', style: TextStyles.txt18color000000),
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
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20),
                child: Text(
                  '请输入持卡人姓名',
                  style: TextStyles.txt12color2F3036,
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
                  controller: _controller1,
                  style: TextStyles.txt14color1F2024,
                  maxLength: 18,
                  decoration: const InputDecoration(
                    counterText: '',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: '请输入持卡人姓名',
                    hintStyle: TextStyles.txt14color8F9098,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20),
                child: Text(
                  '请输入银行卡号',
                  style: TextStyles.txt12color2F3036,
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
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, //数字，只能是整数
                  ],
                  controller: _controller2,
                  style: TextStyles.txt14color1F2024,
                  maxLength: 18,
                  decoration: const InputDecoration(
                    counterText: '',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: '请输入银行卡号',
                    hintStyle: TextStyles.txt14color8F9098,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20),
                child: Text(
                  '请输入开户行信息',
                  style: TextStyles.txt12color2F3036,
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
                  controller: _controller3,
                  style: TextStyles.txt14color1F2024,
                  maxLength: 18,
                  decoration: const InputDecoration(
                    counterText: '',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: '请输入开户行信息',
                    hintStyle: TextStyles.txt14color8F9098,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20),
                child: Text(
                  '请输入身份证号码',
                  style: TextStyles.txt12color2F3036,
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
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                    //只允许输入字母
                  ],
                  controller: _controller4,
                  style: TextStyles.txt14color1F2024,
                  maxLength: 18,
                  decoration: const InputDecoration(
                    counterText: '',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: '请输入身份证号码',
                    hintStyle: TextStyles.txt14color8F9098,
                  ),
                ),
              ),
              Gaps.vGap50,
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
                        Text('绑定提交', style: TextStyles.txt17colorFFFFFF),
                        Expanded(child: Text('')),
                      ],
                    )),
                onTap: () {
                  _save();
                },
              )
            ],
          ),
        ),
      );

  /**
   *
      参数名	必选	类型	说明
      name	是	string	姓名
      card_number	是	string	卡号
      bank_name	是	string	开户行
      id_number	是	string	身份证号码
   */

  ///
  Future<void> _save() async {
    if (_controller1.text.isEmpty) {
      Toast.show('请输入姓名');
      return;
    }
    if (_controller2.text.isEmpty) {
      Toast.show('请输入银行卡');
      return;
    }
    if (_controller3.text.isEmpty) {
      Toast.show('请输入开户行');
      return;
    }
    if (_controller4.text.isEmpty) {
      Toast.show('请输入身份证');
      return;
    }
    PPHttpClient().post(PpUrlConfig.addInfoCard, data: {
      'name': _controller1.text,
      'card_number': _controller2.text,
      'bank_name': _controller3.text,
      'id_number': _controller4.text,
    }, onSuccess: (jsonMap) {
      Toast.show('绑定成功');
      goBackLastPage(context);
    }, onError: (code, msg) {
      Toast.show(msg + code);
    });
  }
}
