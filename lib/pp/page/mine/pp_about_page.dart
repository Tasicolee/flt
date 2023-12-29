import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/page/mine/pp_update_dialog.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/device_utils.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';

import '../../../util/toast_utils.dart';
import '../../dio/pp_httpclient.dart';
import '../../dio/pp_url_config.dart';
import '../../utils/pp_string_utils.dart';

/// 关于我们
class PpAboutPage extends StatefulWidget {
  const PpAboutPage({super.key});

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<PpAboutPage> {
  String _string = '';

  @override
  void initState() {
    _setVersion();
    super.initState();
  }

  Future<void> _setVersion() async {
    final String version = await versionString();
    final String code = await versionCodeString();
    _string = '$version($code)';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colours.app_main_bg,
        appBar: const MyAppBar(
            centerTitle: '关于我们', backgroundColor: Colours.app_main_bg),
        body: Column(
          children: <Widget>[
            Gaps.vGap50,
            Images.pp_logo_circle90,
            Gaps.vGap50,
            Container(
                padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15),
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                decoration: const BoxDecoration(
                    color: Colours.colorFFFFFF, //设置背景颜色
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Column(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _version(),
                      child: Row(
                        children: <Widget>[
                          Gaps.hGap20,
                          const Text(
                            'APP版本',
                            style: TextStyles.txt16color272729,
                          ),
                          const Expanded(child: Text('')),
                          Text(_string),
                          Gaps.hGap20,
                          Images.pp_mine_right_arrow,
                          Gaps.hGap20,
                        ],
                      ),
                    ),
                    Gaps.vGap8,
                    Gaps.lineF6F6F6,
                    Gaps.vGap8,
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => goKf(context),
                      child: const Row(
                        children: <Widget>[
                          Gaps.hGap20,
                          Text(
                            '联系客服',
                            style: TextStyles.txt16color272729,
                          ),
                          Expanded(child: Text('')),
                          Images.pp_mine_right_arrow,
                          Gaps.hGap20,
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      );

  Future<void> _version() async => PPHttpClient().get(PpUrlConfig.version,
      onSuccess: (jsonMap) async {
        final String contentStr = jsonMap['data']['content'].toString();
        final String apk_version = jsonMap['data']['apk_version'].toString();
        final String ios_version = jsonMap['data']['ios_version'].toString();
        final String apk_url = jsonMap['data']['apk_url'].toString();
        final String ios_url = jsonMap['data']['ios_url'].toString();
        final String v = await versionCodeString();
        if (Device.isAndroid) {
          if (double.parse(apk_version) > int.parse(v)) {
            _showUpdateDialog(contentStr, apk_url);
          } else {
            Toast.show('已经是最新版本了');
          }
        } else if (Device.isIOS) {
          if (double.parse(ios_version) > int.parse(v)) {
            _showUpdateDialog(contentStr, ios_url);
          } else {
            Toast.show('已经是最新版本了');
          }
        }
      },
      onError: (code, msg) => Toast.show(msg + code));

  Future<void> _showUpdateDialog(String contentStr, String apkUrl) async {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => PpUpdateDialog(contentStr, apkUrl));
  }
}
