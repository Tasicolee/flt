import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../util/toast_utils.dart';
import '../utils/pp_global.dart';

/// 收款码
class PpPaymentCodePage extends StatefulWidget {
  const PpPaymentCodePage({super.key});

  @override
  _PpPaymentCodePageState createState() => _PpPaymentCodePageState();
}

class _PpPaymentCodePageState extends State<PpPaymentCodePage> {
  GlobalKey repaintKey = GlobalKey();

  final String _codeJson =
      '{"wallet_code":"${ppUserEntityGlobal?.wallet_code ?? ''}","type":"transfer"}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.app_main_bg,
      appBar: const MyAppBar(backgroundColor: Colours.app_main_bg),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            decoration: const BoxDecoration(
                color: Colours.colorFFFFFF, //设置背景颜色
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                  child: const Text(
                    '收款地址',
                    style: TextStyles.txt14color272729,
                  ),
                ),
                Gaps.vGap12,
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Text(
                          ppUserEntityGlobal?.wallet_code ?? '',
                          style: TextStyles.txt12color99999,
                        ),
                        Images.pp_home_copy_grey
                      ],
                    ),
                  ),
                  onTap: () =>
                      copyString(ppUserEntityGlobal?.wallet_code ?? ''),
                ),
                Gaps.vGap24,
                Gaps.lineF6F6F6,
                Gaps.vGap24,
                RepaintBoundary(
                    key: repaintKey,
                    child: Container(
                      alignment: Alignment.center,
                      child: QrImageView(
                        backgroundColor: Colours.colorFFFFFF,
                        data: _codeJson,
                        size: 250.0,
                      ),
                    )),
                Gaps.vGap24,
                if (isPpWeb())
                  Container()
                else
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _getPerm(),
                    child: Container(
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        decoration: const BoxDecoration(
                            color: Colours.colorF5F5F5, //设置背景颜色
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: const Text(
                          '保存至相册',
                          style: TextStyles.txt14color292929,
                        ),
                      ),
                    ),
                  ),
                Gaps.vGap24,
              ],
            ),
          ),
          Gaps.vGap24,
          const Row(
            children: [
              Gaps.hGap20,
              Images.pp_hint_ask,
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
                '1.该地址仅支持PP币收款,请勿用于其他比重,否则资产丢失无法找回;'
                '\n2.最小收款金额:1PP,小于金额最小金额的收款将不会上账且无法退回'
                '\n3.您的收款地址不会经常改变,可截图保存并重复使用。',
                style: TextStyles.textGray12,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future _getPerm() async {
    final Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    final status = await Permission.storage.status;
    debugPrint(status.toString());
    if (status.isDenied) {
      openAppSettings(); // 没有权限打开设置页面
    } else {
      capturePng(); // 已有权限开始保存
    }
  }

  Future<void> capturePng() async {
    try {
      final RenderRepaintBoundary boundary = repaintKey.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;

      final image = await boundary.toImage();
      final ByteData? byteData =
          await image.toByteData(format: ImageByteFormat.png);
      if (byteData != null) {
        final result =
            await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
        debugPrint(result.toString());
      }

      debugPrint('开始保存');
      Toast.show('保存成功');
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
