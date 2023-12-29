import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:photo_view/photo_view.dart';

/// 大图
class PpPhotoViewPage extends StatefulWidget {
  String url;

  PpPhotoViewPage(
    this.url, {
    super.key,
  });

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PpPhotoViewPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colours.app_main_bg,
        appBar: const MyAppBar(
            centerTitle: '查看大图', backgroundColor: Colours.app_main_bg),
        body: PhotoView(imageProvider: CachedNetworkImageProvider(widget.url)),
      );
}
