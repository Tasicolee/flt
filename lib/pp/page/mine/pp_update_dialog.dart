import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/load_image.dart';

class PpUpdateDialog extends StatefulWidget {
  String content;
  String apk_url;

  PpUpdateDialog(this.content, this.apk_url, {super.key});

  @override
  _UpdateDialogState createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<PpUpdateDialog> {
  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => true, // 使用false禁止返回键返回，达到强制升级目的
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                constraints:
                    const BoxConstraints(minHeight: 200, minWidth: 100),
                margin: const EdgeInsets.only(
                    left: 50, right: 50, top: 150, bottom: 150),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LoadAssetImage('pp_update_head', fit: BoxFit.fill),
                    Gaps.vGap20,
                    const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          '新版本内容',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    Gaps.vGap10,
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            widget.content,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Color(0xFFB6B6B6),
                              fontSize: 16,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      goBackLastPage(context);
                                    },
                                    child: Container(
                                      height: 44,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFFE5E6EB),
                                          ),
                                          top: BorderSide(
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFFE5E6EB),
                                          ),
                                          right: BorderSide(
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFFE5E6EB),
                                          ),
                                          bottom: BorderSide(
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFFE5E6EB),
                                          ),
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 11),
                                      clipBehavior: Clip.antiAlias,
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              height: 22,
                                              child: Text(
                                                '残忍拒绝',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xFF999999),
                                                  fontSize: 16,
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      launchUrl(Uri.parse(widget.apk_url));
                                    },
                                    child: Container(
                                      height: 44,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 11),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFFE5E6EB),
                                          ),
                                          top: BorderSide(
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFFE5E6EB),
                                          ),
                                          right: BorderSide(
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFFE5E6EB),
                                          ),
                                          bottom: BorderSide(
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFFE5E6EB),
                                          ),
                                        ),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              height: 22,
                                              child: Text(
                                                '立即更新',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xFF0083FB),
                                                  //pp_update_head.png
                                                  fontSize: 16,
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      );
}
