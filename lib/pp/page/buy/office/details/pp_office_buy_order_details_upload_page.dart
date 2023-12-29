import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/pp/utils/pp_string_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qiniu_flutter_sdk/qiniu_flutter_sdk.dart';
import 'package:sp_util/sp_util.dart';

import '../../../../../res/constant.dart';
import '../../../../../util/toast_utils.dart';
import '../../../../../widgets/load_image.dart';
import '../../../../dio/pp_httpclient.dart';
import '../../../../dio/pp_url_config.dart';
import '../../../../utils/pp_global.dart';

/// 订单详情-购买-上传存款凭证
class PpOfficeBuyOrderDetailsUploadPage extends StatefulWidget {
  String order_id;

  PpOfficeBuyOrderDetailsUploadPage({super.key, required this.order_id});

  @override
  _PageState createState() => _PageState(order_id: order_id);
}

class _PageState extends State<PpOfficeBuyOrderDetailsUploadPage> {
  String order_id;

  _PageState({required this.order_id});

  String? _qiniuToken = '';
  String? qiniu_domain = '';

  @override
  void initState() {
    _qiniuToken = SpUtil.getString(Constant.qiniuToken);
    qiniu_domain = SpUtil.getString(Constant.qiniu_domain);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colours.app_main_bg,
        appBar: const MyAppBar(
          centerTitle: '上传存款凭证',
          backgroundColor: Colours.app_main_bg,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: const SizedBox(
                  child: Text(
                    '1.请上传该笔存款的回执单图片或视频，包含完整的卡号（不能含*）、金额、姓名和银行印章',
                    style: TextStyle(
                      color: Color(0xFF2E3036),
                      fontSize: 14,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
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
                                Images.pp_upload_img,
                                Gaps.vGap10,
                                Text(
                                  '点击上传',
                                  style: TextStyle(
                                    color: Color(0xFFD7D7D7),
                                    fontSize: 14,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ))),
              Gaps.vGap5,
              const Row(
                children: [
                  Expanded(child: Text('')),
                  Text(
                    '点击查看回执单样例',
                    style: TextStyle(
                      color: Color(0xFF0083FB),
                      fontSize: 12,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gaps.hGap20
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: const SizedBox(
                  child: Text(
                    '2.请上传该笔存款的提交时间到当前时间的银行卡收支明细图片或视频',
                    style: TextStyle(
                      color: Color(0xFF2E3036),
                      fontSize: 14,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
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
                                Images.pp_upload_img,
                                Gaps.vGap10,
                                Text(
                                  '点击上传',
                                  style: TextStyle(
                                    color: Color(0xFFD7D7D7),
                                    fontSize: 14,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ))),
              Gaps.vGap5,
              const Row(
                children: [
                  Expanded(child: Text('')),
                  Text(
                    '点击查看回执单样例',
                    style: TextStyle(
                      color: Color(0xFF0083FB),
                      fontSize: 12,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gaps.hGap20
                ],
              ),
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
                        Images.pp_hint_ask_orange,
                        Gaps.hGap5,
                        Text(
                          '温馨提示:',
                          style: TextStyles.txt14color272729,
                        )
                      ],
                    ),
                    Gaps.vGap8,
                    Text(
                      '图片格式为png、jpg、jpeg、gif，且总大小不超过 15MB；\n视频支持mp4、avi、mkv等17种常见格式，且总大小不超过20MB；\n请如实上传凭证，造假将无法再使用该渠道。',
                      style: TextStyles.txt12color1E1E1E,
                    ),
                  ],
                ),
              ),
              Gaps.vGap50,
              Row(
                children: [
                  const Expanded(child: Text('')),
                  SizedBox(
                    width: 335,
                    height: 50,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => _submit_credential(),
                            child: Container(
                              height: 50,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF0083FB),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1000),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x70A0BE4B),
                                    blurRadius: 12,
                                    offset: Offset(0, 5),
                                  )
                                ],
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '提交凭证，加速到账',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: 'PingFang HK',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.37,
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
                  const Expanded(child: Text('')),
                ],
              ),
              Gaps.vGap80
            ],
          ),
        ),
      );

  XFile? pickedFile1;
  XFile? pickedFile2;

  String _saveUrl1 = '';
  String _saveUrl2 = '';

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

    if (index == 1) {
      _saveUrl1 = key;
    } else if (index == 2) {
      _saveUrl2 = key;
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
      参数名	必选	类型	说明
      order_id	是	string	订单id
      payment_proof	是	string	用户上传的支付凭证,多张图用英文逗号*/

  /// authenticationAdd
  Future<void> _submit_credential() async {
    if (_saveUrl1.isEmpty) {
      Toast.show('回执明细照片');
      return;
    }
    if (_saveUrl2.isEmpty) {
      Toast.show('银行明细照片');
      return;
    }
    List list = [];
    list.add(_saveUrl1);
    list.add(_saveUrl2);
    PPHttpClient().post(PpUrlConfig.submit_credential_office, data: {
      'supply_orders_id': order_id,
      'payment_proof': getTaskScreen(list),
    }, onSuccess: (jsonMap) {
      Toast.show('上传成功');
      Navigator.pop(context);
    }, onError: (code, msg) {
      Toast.show(msg);
    });
  }
}
