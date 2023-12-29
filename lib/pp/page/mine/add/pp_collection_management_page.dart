import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';

import '../../../../util/toast_utils.dart';
import '../../../dio/pp_httpclient.dart';
import '../../../dio/pp_url_config.dart';

/// 收款管理
class PpCollectionManagementPage extends StatefulWidget {
  const PpCollectionManagementPage({super.key});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PpCollectionManagementPage> {
  @override
  void initState() {
    _getInfoCounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colours.app_main_bg,
        appBar: AppBar(
          systemOverlayStyle: ThemeUtils.appSystemUiOverlayStyle(),
          backgroundColor: Colours.app_main_bg,
          centerTitle: true,
          title: const Text('收款管理', style: TextStyles.txt18color000000),
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
              if (_beanZfb != null)
                _zfbView()
              else
                Container(
                    padding: const EdgeInsets.only(left: 30.0),
                    width: double.infinity,
                    height: 130,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    decoration: const BoxDecoration(
                        color: Colours.colorFFFFFF, //设置背景颜色
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: const Row(
                        children: [
                          Images.pp_icon_add_bank,
                          Gaps.hGap10,
                          Text(
                            '添加支付宝收款',
                            style: TextStyles.txt16colorA0BE4B,
                          ),
                          Expanded(child: Text('')),
                          Images.pp_bank_zfb
                        ],
                      ),
                      onTap: () async {
                        await goPpAddZfbPage(context);
                        _getInfoCounts();
                      },
                    )),
              if (_beanYhk != null)
                _yhkView()
              else
                Container(
                  padding: const EdgeInsets.only(left: 30.0),
                  width: double.infinity,
                  height: 130,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  decoration: const BoxDecoration(
                      color: Colours.colorFFFFFF, //设置背景颜色
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: const Row(
                      children: [
                        Images.pp_icon_add_bank,
                        Gaps.hGap10,
                        Text(
                          '添加银行卡收款',
                          style: TextStyles.txt16colorA0BE4B,
                        ),
                        Expanded(child: Text('')),
                        Images.pp_bank_bank
                      ],
                    ),
                    onTap: () async {
                      await goPpAddBankPage(context);
                      _getInfoCounts();
                    },
                  ),
                ),
              if (_beanWx != null)
                _wxView()
              else
                Container(
                    padding: const EdgeInsets.only(left: 30.0),
                    width: double.infinity,
                    height: 130,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    decoration: const BoxDecoration(
                        color: Colours.colorFFFFFF, //设置背景颜色
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: const Row(
                        children: [
                          Images.pp_icon_add_bank,
                          Gaps.hGap10,
                          Text(
                            '添加微信收款',
                            style: TextStyles.txt16colorA0BE4B,
                          ),
                          Expanded(child: Text('')),
                          Images.pp_bank_weixin
                        ],
                      ),
                      onTap: () async {
                        await goPpAddWxPage(context);
                        _getInfoCounts();
                      },
                    )),
              Gaps.vGap24,
              const Row(
                children: [
                  Gaps.hGap20,
                  Images.pp_hint_ask_orange,
                  Gaps.hGap5,
                  Text(
                    '温馨提示:',
                    style: TextStyles.txt14color272729,
                  )
                ],
              ),
              Gaps.vGap12,
              const Row(
                children: [
                  Gaps.hGap20,
                  Text(
                    '1.最多绑定一个支付宝，一个银行卡，一个微信\n2.收款姓名必须与认证信息一致，信息须真实有效\n3.若填写错误信息可能导致交易失效',
                    style: TextStyles.textGray12,
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  dynamic? _beanWx;
  dynamic? _beanZfb;
  dynamic? _beanYhk;

  Container _zfbView() => Container(
        padding: const EdgeInsets.only(left: 30.0),
        width: double.infinity,
        height: 130,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(0.91, 0.41),
            end: Alignment(-0.91, -0.41),
            colors: [Color(0xFF009EFE), Color(0xFF009EFE)],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x141A1F44),
              blurRadius: 30,
              offset: Offset(0, 16),
            )
          ],
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.vGap20,
                Images.pp_ban_zfb_logo,
                Gaps.vGap20,
                Text(
                  _beanZfb['id_number'].toString(),
                  style: const TextStyle(
                    color: Color(0xFFF7F7F7),
                    fontSize: 16,
                    fontFamily: 'HK Grotesk',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Gaps.vGap20,
                Text(
                  _beanZfb['name'].toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'PingFang HK',
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.41,
                  ),
                )
              ],
            ),
            const Expanded(child: Text('')),
            Images.pp_bank_zfb_white
          ],
        ),
      );

  Container _yhkView() => Container(
        padding: const EdgeInsets.only(left: 30.0),
        width: double.infinity,
        height: 130,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(0.91, 0.41),
            end: Alignment(-0.91, -0.41),
            colors: [Color(0xFF302883), Color(0xFF857AF5)],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x141A1F44),
              blurRadius: 30,
              offset: Offset(0, 16),
            )
          ],
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.vGap20,
                Text(
                  _beanYhk['name'].toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'PingFang HK',
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.41,
                  ),
                ),
                Gaps.vGap20,
                Text(
                  _beanYhk['card_number'].toString(),
                  style: const TextStyle(
                    color: Color(0xFFF7F7F7),
                    fontSize: 16,
                    fontFamily: 'HK Grotesk',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Gaps.vGap20,
                Text(
                  _beanYhk['bank_name'].toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'PingFang HK',
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.41,
                  ),
                )
              ],
            ),
            const Expanded(child: Text('')),
            Images.pp_bank_card_white
          ],
        ),
      );

  Container _wxView() => Container(
        padding: const EdgeInsets.only(left: 30.0),
        width: double.infinity,
        height: 130,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        decoration: ShapeDecoration(
          color: const Color(0xFF00B837),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0C4A590E),
              blurRadius: 16,
              offset: Offset(0, 6),
            )
          ],
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.vGap20,
                Images.pp_bank_wx_logo,
                Gaps.vGap20,
                Text(
                  _beanWx['id_number'].toString(),
                  style: const TextStyle(
                    color: Color(0xFFF7F7F7),
                    fontSize: 16,
                    fontFamily: 'HK Grotesk',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Gaps.vGap20,
                Text(
                  _beanWx['name'].toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'PingFang HK',
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.41,
                  ),
                )
              ],
            ),
            const Expanded(child: Text('')),
            Images.pp_bank_wx_white
          ],
        ),
      );

  /**
   * account_type	string	账户类型 (1微信, 2支付宝, 3银行卡)
   */

  ///
  Future<void> _getInfoCounts() async {
    PPHttpClient().get(PpUrlConfig.getInfoCounts, onSuccess: (jsonMap) {
      final List list = jsonMap['data'] as List;
      list.forEach((element) {
        if (element['account_type'] == '1') {
          _beanWx = element;
        } else if (element['account_type'] == '2') {
          _beanZfb = element;
        } else if (element['account_type'] == '3') {
          _beanYhk = element;
        }
      });
      setState(() {});
    }, onError: (code, msg) {
      Toast.show(msg + code);
    });
  }
}
