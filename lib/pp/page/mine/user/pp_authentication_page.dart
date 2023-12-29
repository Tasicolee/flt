import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/pp/page/mine/user/pp_auth_wait_page.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qiniu_flutter_sdk/qiniu_flutter_sdk.dart';
import 'package:sp_util/sp_util.dart';

import '../../../../res/constant.dart';
import '../../../../util/toast_utils.dart';
import '../../../../widgets/load_image.dart';
import '../../../dio/pp_httpclient.dart';
import '../../../dio/pp_url_config.dart';
import '../../../utils/pp_global.dart';
import '../../../utils/pp_user_utils.dart';

/// 身份认证
class PpAuthenticationPage extends StatefulWidget {
  bool isAgain = false;

  PpAuthenticationPage(this.isAgain, {super.key});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PpAuthenticationPage> {
  String? _qiniuToken = '';
  String? qiniu_domain = '';
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerCode = TextEditingController();

  XFile? pickedFile1;
  XFile? pickedFile2;
  XFile? pickedFile3;

  String _saveUrl1 = '';
  String _saveUrl2 = '';
  String _saveUrl3 = '';

  @override
  void initState() {
    _qiniuToken = SpUtil.getString(Constant.qiniuToken);
    qiniu_domain = SpUtil.getString(Constant.qiniu_domain);
    _getConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colours.app_main_bg,
        appBar: AppBar(
          systemOverlayStyle: ThemeUtils.appSystemUiOverlayStyle(),
          backgroundColor: Colours.app_main_bg,
          centerTitle: true,
          title: const Text('身份认证', style: TextStyles.txt18color000000),
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
                padding: EdgeInsets.only(left: 20.0, top: 10),
                child: Text('姓名', style: TextStyles.txt12color2F3036),
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
                  controller: _controllerName,
                  maxLength: 18,
                  decoration: const InputDecoration(
                    counterText: '',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: '请输入姓名',
                    hintStyle: TextStyles.txt14color8F9098,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20),
                child: Text('身份证号码', style: TextStyles.txt12color2F3036),
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
                  controller: _controllerCode,
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
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20),
                child: Text('身份证正面', style: TextStyles.txt12color2F3036),
              ),
              GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _getImage1(),
                  child: Container(
                      width: double.infinity,
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        border: Border.all(color: Colours.colorDEDEDE),
                      ),
                      child: pickedFile1?.path.isNotEmpty == true
                          ? (isPpWeb()
                              ? LoadImage('${qiniu_domain!}/$_saveUrl1')
                              : Image.file(File(pickedFile1!.path)))
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Images.pp_bg_sfz_front,
                                    Images.pp_icon_add_bank
                                  ],
                                ),
                                Gaps.vGap5,
                                Text('点击上传身份证正面',
                                    style: TextStyles.txt14colorD8D8D8),
                              ],
                            ))),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20),
                child: Text('身份证背面', style: TextStyles.txt12color2F3036),
              ),
              GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _getImage2(),
                  child: Container(
                      width: double.infinity,
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        border: Border.all(color: Colours.colorDEDEDE),
                      ),
                      child: pickedFile2?.path.isNotEmpty == true
                          ? (isPpWeb()
                              ? LoadImage('${qiniu_domain!}/$_saveUrl2')
                              : Image.file(File(pickedFile2!.path)))
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Images.pp_bg_sfz_back,
                                    Images.pp_icon_add_bank
                                  ],
                                ),
                                Gaps.vGap5,
                                Text('点击上传身份证背面',
                                    style: TextStyles.txt14colorD8D8D8),
                              ],
                            ))),
              Gaps.vGap10,
              Container(
                padding: const EdgeInsets.only(
                    left: 10.0, top: 10, right: 10, bottom: 10),
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                decoration: const BoxDecoration(
                  color: Colours.colorFFF7E8,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Images.pp_hint_ask,
                        Gaps.hGap5,
                        Text(
                          '温馨提示:',
                          style: TextStyles.txt14color272729,
                        )
                      ],
                    ),
                    Gaps.vGap8,
                    Text(
                      '身份证照片确保无水印无污溃，身份信息清晰，非文字反向照片，请勿进行PS处理',
                      style: TextStyles.txt12color1E1E1E,
                    ),
                  ],
                ),
              ),
              _userView(),
              Gaps.vGap10,
              _hintUserView(),
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
                        Text('提交', style: TextStyles.txt17colorFFFFFF),
                        Expanded(child: Text('')),
                      ],
                    )),
                onTap: () => _authenticationAdd(),
              ),
              Gaps.vGap50,
            ],
          ),
        ),
      );

  Future<void> _getImage1() async {
    try {
      final ImagePicker picker = ImagePicker();
      pickedFile1 =
          await picker.pickImage(source: ImageSource.gallery, maxWidth: 800);
      if (pickedFile1 != null) {
        setState(() {});
        _upload(pickedFile1!.path, 1);
      }
    } catch (e) {
      if (e is MissingPluginException) {
        Toast.show('当前平台暂不支持！');
      } else {
        Toast.show('没有权限，无法打开相册！');
      }
    }
  }

  Future<void> _getImage2() async {
    try {
      final ImagePicker picker = ImagePicker();
      pickedFile2 =
          await picker.pickImage(source: ImageSource.gallery, maxWidth: 800);
      if (pickedFile2 != null) {
        setState(() {});
        _upload(pickedFile2!.path, 2);
      }
    } catch (e) {
      if (e is MissingPluginException) {
        Toast.show('当前平台暂不支持！');
      } else {
        Toast.show('没有权限，无法打开相册！');
      }
    }
  }

  Future<void> _getImage3() async {
    try {
      final ImagePicker picker = ImagePicker();
      pickedFile3 =
          await picker.pickImage(source: ImageSource.gallery, maxWidth: 800);
      if (pickedFile3 != null) {
        setState(() {});
        _upload(pickedFile3!.path, 3);
      }
    } catch (e) {
      if (e is MissingPluginException) {
        Toast.show('当前平台暂不支持！');
      } else {
        Toast.show('没有权限，无法打开相册！');
      }
    }
  }

  void _upload(String path, int index) {
    // 创建 storage 对象
    final Storage storage = Storage();

    // 创建 Controller 对象
    final PutController putController = PutController();
    // 添加整体进度监听
    putController.addProgressListener((double percent) {
      debugPrint('任务进度变化：已发送：$percent');
    });

    // 添加发送进度监听
    putController.addSendProgressListener((double percent) {
      debugPrint('已上传进度变化：已发送：$percent');
    });

    // 添加状态监听
    putController.addStatusListener((StorageStatus status) {
      debugPrint('状态变化: 当前任务状态：$status');
      if (status == StorageStatus.Success) {
        setState(() {});
      }
    });
    final String key =
        'pp_${ppUserEntityGlobal!.id}_${DateTime.now().millisecondsSinceEpoch}.png';

    if (index == 1) {
      _saveUrl1 = key;
    } else if (index == 2) {
      _saveUrl2 = key;
    } else if (index == 3) {
      _saveUrl3 = key;
    }
    debugPrint('状态变化: 当前任务状态key=：$key');
    // 使用 storage 的 putFile 对象进行文件上传
    storage.putFile(File(path), _qiniuToken.toString(),
        options: PutOptions(
          key: key,
          controller: putController,
        ));
  }

  /**
   * full_name 是 string 真实姓名
      idcard_number 是 string 身份证号码
      front_image_path 是 string 证件正面图片路径
      back_image_path 是 string 证件反面图片路径
      hold_idcard_path 是 string 手持身份证图片路径

   * {"token":"3gizPogd6d4tv0lwg1gJ7-iThLrSWJLF2NPGlViH:HCSDDG_7hfCET-7-jYOAWx_7Cek=:eyJzY29wZSI6ImVkcGF5IiwiZGVhZGxpbmUiOjE2OTg3NTMzODJ9",
   * "qiniu_domain":"s3e5zbmf1.hn-bkt.clouddn.com"},"ts":1698753082}
   */

  /// authenticationAdd
  Future<void> _authenticationAdd() async {
    if (_controllerName.text.isEmpty) {
      Toast.show('请输入姓名');
      return;
    }
    if (_controllerCode.text.isEmpty) {
      Toast.show('请输入身份证');
      return;
    }
    if (_saveUrl1.isEmpty) {
      Toast.show('请上传身份证正面照片');
      return;
    }
    if (_saveUrl2.isEmpty) {
      Toast.show('请上传身份证背面照片');
      return;
    }
    if (hold_idcard_verification_switch == "1" && _saveUrl3.isEmpty) {
      Toast.show('请上传手持照片');
      return;
    }

    PPHttpClient().post(
        widget.isAgain
            ? PpUrlConfig.authenticationUpdate
            : PpUrlConfig.authenticationAdd,
        data: {
          'full_name': _controllerName.text,
          'idcard_number': _controllerCode.text,
          'front_image_path': _saveUrl1,
          'back_image_path': _saveUrl2,
          'hold_idcard_path': _saveUrl3,
        }, onSuccess: (jsonMap) {
      Navigator.pop(context);
      _goPpAuthWaitPage();
    }, onError: (code, msg) {
      Toast.show(msg);
    });
  }

  void _goPpAuthWaitPage() => Navigator.push(
      context, MaterialPageRoute(builder: (_) => const PpAuthWaitPage()));

  Container _hintUserView() => hold_idcard_verification_switch == "1"
      ? Container(
          padding:
              const EdgeInsets.only(left: 10.0, top: 10, right: 10, bottom: 10),
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
          decoration: const BoxDecoration(
            color: Colours.colorFFF7E8,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Images.pp_hint_ask,
                  Gaps.hGap5,
                  Text(
                    '温馨提示:',
                    style: TextStyles.txt14color272729,
                  )
                ],
              ),
              Gaps.vGap8,
              Text(
                '需要您本人单手持您的身份证，另一只手持一张有您手写的ID和当天日期的白纸，确保身份证和白纸在您胸前；不避挡您的脸部；并且身份证和白纸上的信息清晰可见',
                style: TextStyles.txt12color1E1E1E,
              ),
            ],
          ),
        )
      : Container();

  _userView() => hold_idcard_verification_switch == "1"
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20),
              child: Text('手持身份证照片', style: TextStyles.txt12color2F3036),
            ),
            GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _getImage3(),
                child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(color: Colours.colorDEDEDE),
                    ),
                    child: pickedFile3?.path.isNotEmpty == true
                        ? (isPpWeb()
                            ? LoadImage('${qiniu_domain!}/$_saveUrl3')
                            : Image.file(File(pickedFile3!.path)))
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Images.pp_bg_sfz_hand,
                                  Images.pp_icon_add_bank
                                ],
                              ),
                              Gaps.vGap5,
                              Text('点击上传手持身份证照片',
                                  style: TextStyles.txt14colorD8D8D8),
                            ],
                          ))),
          ],
        )
      : Container();

  Future<void> _getConfig() async {
    await sys_config_hold_idcard_verification_switch();
    setState(() {});
  }
}
