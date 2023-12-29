import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../../../utils/pp_navigator_utils.dart';

/// 支付宝绑定
class PpAddZfbPage extends StatefulWidget {
  const PpAddZfbPage({super.key});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PpAddZfbPage> {
  String? _qiniuToken = '';
  String? qiniu_domain = '';
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  void initState() {
    _qiniuToken = SpUtil.getString(Constant.qiniuToken);
    qiniu_domain = SpUtil.getString(Constant.qiniu_domain);

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colours.app_main_bg,
        appBar: AppBar(
          systemOverlayStyle: ThemeUtils.appSystemUiOverlayStyle(),
          backgroundColor: Colours.app_main_bg,
          centerTitle: true,
          title: const Text('支付宝绑定', style: TextStyles.txt18color000000),
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
                  '支付宝名称',
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
                    hintText: '请输入用户名',
                    hintStyle: TextStyles.txt14color8F9098,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20),
                child: Text(
                  '身份证号码',
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
                  controller: _controller2,
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
                child: Text(
                  '收款码照片',
                  style: TextStyles.txt12color2F3036,
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(color: Colours.colorDEDEDE),
                    ),
                    child: pickedFile != null
                        ? (isPpWeb()
                            ? LoadImage('${qiniu_domain!}/$_saveUrl')
                            : Image.file(File(pickedFile!.path)))
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Images.pp_upload_img,
                              Gaps.vGap5,
                              Text('上传照片', style: TextStyles.txt14colorD8D8D8),
                            ],
                          )),
                onTap: () {
                  _getImage();
                },
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

  XFile? pickedFile;

  String _saveUrl = '';

  Future<void> _getImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      pickedFile =
          await picker.pickImage(source: ImageSource.gallery, maxWidth: 800);
      if (pickedFile != null) {
        setState(() {});
        _upload(pickedFile!.path, 3);
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
    });
    final String key =
        'pp_${ppUserEntityGlobal!.id}_${DateTime.now().millisecondsSinceEpoch}.png';

    _saveUrl = key;
    debugPrint('状态变化: 当前任务状态key=：$key');
    // 使用 storage 的 putFile 对象进行文件上传
    storage.putFile(File(path), _qiniuToken.toString(),
        options: PutOptions(
          key: key,
          controller: putController,
        ));
  }

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
    if (_saveUrl.isEmpty) {
      Toast.show('请上传照片');
      return;
    }
    PPHttpClient().post(PpUrlConfig.addInfoZfb, data: {
      'name': _controller1.text,
      'id_number': _controller2.text,
      'pay_qrcode_url': _saveUrl,
    }, onSuccess: (jsonMap) {
      Toast.show('绑定成功');
      goBackLastPage(context);
    }, onError: (code, msg) {
      Toast.show(msg + code);
    });
  }
}
