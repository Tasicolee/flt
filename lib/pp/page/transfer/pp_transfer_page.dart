import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';

import '../../../util/toast_utils.dart';
import '../../../widgets/pp_text_field_item.dart';
import '../../dio/pp_httpclient.dart';
import '../../dio/pp_url_config.dart';
import '../../utils/pp_global.dart';
import '../../utils/pp_user_utils.dart';
import '../pp_scan_page.dart';

/// 转账
class PpTransferPage extends StatefulWidget {
  String wallet_code;

  PpTransferPage({super.key, required this.wallet_code});

  @override
  _PpTransferPageState createState() => _PpTransferPageState();
}

class _PpTransferPageState extends State<PpTransferPage> {
  List? _listContact;

  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    _contactList();
    sys_config_transfer_fee();
    _inputController.text = widget.wallet_code;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colours.app_main_bg,
      appBar: AppBar(
        systemOverlayStyle: ThemeUtils.appSystemUiOverlayStyle(),
        backgroundColor: Colours.app_main_bg,
        centerTitle: true,
        title: const Text('转账', style: TextStyles.txt18color000000),
        actions: [
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Images.pp_icon_history,
              onTap: () => goPpTransferHistoryListPage(context)),
          Gaps.hGap20
        ],
        elevation: 0,
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Images.pp_back_top_left_page,
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                PPTextFieldItem(
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                    //只允许输入字母
                  ],
                  controller: _inputController,
                  title: '转账给',
                  hintText: '输入收款地址',
                ),
                Positioned(
                    right: 0.0,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        final String s = await paste();
                        _inputController.text = s;
                      },
                      child: const Row(
                        children: [
                          Images.pp_icon_pate,
                          Gaps.hGap5,
                          Text('粘贴', style: TextStyles.txt16colorA0BE4B)
                        ],
                      ),
                    )),
                //.png
              ],
            ),
          ),
          Gaps.vGap10,
          Row(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _scan(),
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 15.0),
                    margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                    decoration: const BoxDecoration(
                        color: Colours.colorFFFFFF, //设置背景颜色
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: const Row(
                      children: [
                        Images.pp_icon_scan,
                        Gaps.hGap20,
                        Text('扫一扫', style: TextStyles.txt17color272729),
                      ],
                    )),
              ),
              const Expanded(child: Text('')),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 15.0),
                    margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                    decoration: const BoxDecoration(
                        color: Colours.colorFFFFFF, //设置背景颜色
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: const Row(
                      children: [
                        Images.pp_icon_contact,
                        Gaps.hGap20,
                        Text('通讯录', style: TextStyles.txt17color272729),
                      ],
                    )),
                onTap: () => _showBottomDialog(),
              )
            ],
          ),
          Gaps.vGap20,
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _summit(),
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
                    Text('下一步', style: TextStyles.txt17colorFFFFFF),
                    Expanded(child: Text('')),
                  ],
                )),
          ),
        ],
      ));

  Future<void> _scan() async {
    if (isPpWeb()) {
      Toast.show('暂不支持该平台');
    } else {
      final result = await Navigator.push(
          context, MaterialPageRoute(builder: (_) => ScanPage()));
      final resultStr = result.toString();
      if (resultStr.isNotEmpty && resultStr != 'null') {
        final jsonMap = jsonDecode(resultStr);
        final type = jsonMap['type'].toString();
        if (type == 'transfer') {
          final wallet_code = jsonMap['wallet_code'].toString();
          setState(() {});
          _inputController.text = wallet_code;
        } else {
          Toast.show('未检测到有效二维码');
        }
      } else {
        Toast.show('未检测到二维码');
      }
    }
  }

  /// 获取内容
  static Future<String> paste() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    return clipboardData?.text ?? '';
  }

  void _summit() {
    if (_inputController.text.isEmpty) {
      Toast.show('请输入收款地址');
      return;
    }
    var showAdd = true;
    _listContact?.forEach((element) {
      if (element['wallet_code'] == _inputController.text) {
        showAdd = false;
      }
    });
    goPpTransferMoneyPage(context, _inputController.text, showAdd);
  }

  Future<Future<int?>> _showBottomDialog() async {
    return showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colours.app_main_bg,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            children: [
              Gaps.vGap20,
              Row(
                children: [
                  Gaps.hGap20,
                  const Expanded(
                      child: Text(
                    '通讯录',
                    style: TextStyle(
                      color: Color(0xFF272729),
                      fontSize: 17,
                      fontFamily: 'PingFang HK',
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Images.pp_close_right,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Gaps.hGap20,
                ],
              ),
              Gaps.vGap20,
              Expanded(child: _getListView()),
            ],
          ),
        );
      },
    );
  }

  Future<void> _contactList() async {
    PPHttpClient().get(PpUrlConfig.contactList, data: {}, onSuccess: (jsonMap) {
      _listContact = jsonMap['data']['data'] as List;
    }, onError: (code, msg) {
      Toast.show(msg + code);
    });
  }

  ListView _getListView() => ListView.builder(
      itemCount: _listContact?.length ?? 0,
      itemBuilder: (_, int index) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            setState(() {
              _inputController.text =
                  _listContact![index]["wallet_code"].toString();
              goBackLastPage(context);
            });
          },
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
            padding:
                const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colours.colorFFFFFF,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(_listContact![index]["name"].toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w600,
                            ))),
                    Text(
                      _listContact![index]["name"].toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFD4D4D4),
                        fontSize: 12,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                Gaps.vGap12,
                Text(
                  _listContact![index]["wallet_code"].toString(),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Color(0xFFA8A8A8),
                    fontSize: 12,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          )));

  Container _addView() => Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
        padding:
            const EdgeInsets.only(left: 10, top: 15, bottom: 15, right: 10),
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Colours.colorFFFFFF,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Images.pp_icon_add_bank16,
                Gaps.hGap8,
                Text(
                  '添加联系人',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF0083FB),
                    fontSize: 14,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ],
        ),
      );
}
