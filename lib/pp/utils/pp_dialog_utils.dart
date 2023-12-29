import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/utils/pp_global.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../res/resources.dart';
import '../../util/other_utils.dart';
import '../../util/toast_utils.dart';
import '../dio/pp_httpclient.dart';
import '../dio/pp_url_config.dart';

///     is_real_name	string	是否实名认证0否 1是
bool isNeedAuthentication() => ppUserEntityGlobal?.is_real_name != '1';

void showPpAuthenticationPageDialog(BuildContext c) {
  /// 关闭输入法，避免弹出
  FocusManager.instance.primaryFocus?.unfocus();
  showElasticDialog<void>(
    context: c,
    builder: (BuildContext context) {
      const OutlinedBorder buttonShape = RoundedRectangleBorder();
      final Widget content = Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            '请先完成身份认证',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF272729),
              fontSize: 16,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ),
          Images.pp_card_id,
          Gaps.lineF6F6F6,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: GestureDetector(
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
                onTap: () {
                  Navigator.pop(context);
                  _clickAuth(context);
                },
                child: const Text(
                  '去认证',
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
          color: Colours.colorFFFFFF,
          borderRadius: BorderRadius.circular(8.0),
        ),
        width: 270.0,
        // height: 230.0,
        padding: const EdgeInsets.only(top: 24.0),
        child: TextButtonTheme(
          data: TextButtonThemeData(
            style: TextButton.styleFrom(
              // 文字颜色
              foregroundColor: Colours.colorFFFFFF,
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
        type: MaterialType.transparency,
        child: Center(
          child: decoration,
        ),
      );
    },
  );
}

Future<void> _clickAuth(BuildContext context) async {
  if (ppUserEntityGlobal?.is_real_name == '1') {
    goPpAuthSuccessPage(context);
  } else {
    _authenticationInfo(context);
  }
}

Future<void> _authenticationInfo(BuildContext context) async => PPHttpClient()
        .get(PpUrlConfig.authenticationInfo, onSuccess: (jsonMap) async {
      if (jsonMap['data'] == null) {
        goPpAuthenticationPage(context, false);
      } else {
        // 0 待审核 1 审核通过 2 审核不通过
        final String is_approved = jsonMap['data']['is_approved'].toString();
        final String reject_reason =
            jsonMap['data']['reject_reason'].toString();
        if (is_approved == '0') {
          goPpAuthWaitPage(context);
        } else if (is_approved == '1') {
          ppUserEntityGlobal?.is_real_name = '1';
          goPpAuthSuccessPage(context);
        } else if (is_approved == '2') {
          goPpAuthFailPage(context, reject_reason);
        }
      }
    }, onError: (code, msg) {
      Toast.show(msg + code);
    });

void showHomeDialog(BuildContext c, String title, String text) {
  /// 关闭输入法，避免弹出
  FocusManager.instance.primaryFocus?.unfocus();
  showElasticDialog<void>(
    context: c,
    builder: (BuildContext context) {
      const OutlinedBorder buttonShape = RoundedRectangleBorder();
      final Widget content = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF272729),
              fontSize: 16,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w600,
            ),
          ),
          Gaps.vGap20,
          Center(child: Html(data: text)),
          Gaps.lineF6F6F6,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                  height: 40,
                  child: VerticalDivider(color: Colours.colorF5F5F5)),
              Expanded(
                  child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  '好的',
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
          color: Colours.colorFFFFFF,
          borderRadius: BorderRadius.circular(8.0),
        ),
        width: 270.0,
        // height: 230.0,
        padding: const EdgeInsets.only(top: 24.0),
        child: TextButtonTheme(
          data: TextButtonThemeData(
            style: TextButton.styleFrom(
              // 文字颜色
              foregroundColor: Colours.colorFFFFFF,
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
        type: MaterialType.transparency,
        child: Center(
          child: decoration,
        ),
      );
    },
  );
}
