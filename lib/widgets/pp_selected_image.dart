import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/device_utils.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast_utils.dart';
import 'package:image_picker/image_picker.dart';

class PpSelectedImage extends StatefulWidget {
  const PpSelectedImage({
    super.key,
    this.url,
    this.heroTag,
    this.size = 80.0,
  });

  final String? url;
  final String? heroTag;
  final double size;

  @override
  PpSelectedImageState createState() => PpSelectedImageState();
}

class PpSelectedImageState extends State<PpSelectedImage> {
  final ImagePicker _picker = ImagePicker();
  ImageProvider? _imageProvider;
  XFile? pickedFile;

  Future<void> _getImage() async {
    try {
      pickedFile =
          await _picker.pickImage(source: ImageSource.gallery, maxWidth: 800);
      if (pickedFile != null) {
        if (Device.isWeb) {
          _imageProvider = NetworkImage(pickedFile!.path);
        } else {
          _imageProvider = FileImage(File(pickedFile!.path));
        }
      } else {
        _imageProvider = null;
      }
      setState(() {});
    } catch (e) {
      if (e is MissingPluginException) {
        Toast.show('当前平台暂不支持！');
      } else {
        Toast.show('没有权限，无法打开相册！');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorFilter colorFilter = ColorFilter.mode(
        ThemeUtils.isDark(context)
            ? Colours.dark_unselected_item_color
            : Colours.text_gray,
        BlendMode.srcIn);

    Widget image = Container(
      decoration: BoxDecoration(
        // 图片圆角展示
        // borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
            image: _imageProvider ??
                ImageUtils.getImageProvider(widget.url,
                    holderImg: 'store/icon_zj'),
            fit: BoxFit.cover,
            colorFilter: _imageProvider == null && TextUtil.isEmpty(widget.url)
                ? colorFilter
                : null),
      ),
      child: _imageProvider != null
          ? Container()
          : Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              padding: const EdgeInsets.only(left: 20.0, top: 40, right: 20),
              height: 200,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color: Colours.colorDEDEDE),
              ),
              child: const Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [Images.pp_bg_sfz_hand, Images.pp_icon_add_bank],
                  ),
                  Gaps.vGap5,
                  Text('点击上传手持身份证照片', style: TextStyles.txt14colorD8D8D8),
                ],
              )),
    );

    if (widget.heroTag != null && !Device.isWeb) {
      image = Hero(tag: widget.heroTag!, child: image);
    }

    return Semantics(
      label: '选择图片',
      hint: '跳转相册选择图片',
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: _getImage,
        child: image,
      ),
    );
  }
}
