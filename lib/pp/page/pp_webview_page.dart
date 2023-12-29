import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_deer/res/colors.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PpWebViewPage extends StatefulWidget {
  const PpWebViewPage({
    super.key,
    required this.title,
    required this.url,
  });

  final String title;
  final String url;

  @override
  _PpWebViewPageState createState() => _PpWebViewPageState();
}

class _PpWebViewPageState extends State<PpWebViewPage> {
  late final WebViewController _controller;
  int _progressValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (!mounted) {
              return;
            }
            debugPrint('WebView is loading (progress : $progress%)');
            setState(() {
              _progressValue = progress;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          final bool canGoBack = await _controller.canGoBack();
          if (canGoBack) {
            // 网页可以返回时，优先返回上一页
            await _controller.goBack();
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: Scaffold(
          backgroundColor: Colours.app_main_bg,
          appBar: MyAppBar(
            backgroundColor: Colours.app_main_bg,
            centerTitle: widget.title,
          ),
          body: Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: Stack(
              children: [
                WebViewWidget(
                  controller: _controller,
                ),
                if (_progressValue != 100)
                  LinearProgressIndicator(
                    color: Colours.app_main_bg,
                    value: _progressValue / 100,
                    backgroundColor: Colors.transparent,
                    minHeight: 2,
                  )
                else
                  Gaps.empty,
              ],
            ),
          ),
        ),
      );
}
