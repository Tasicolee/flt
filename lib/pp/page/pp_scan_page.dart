import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan/scan.dart';

import '../../res/colors.dart';
import '../../widgets/my_app_bar.dart';

class ScanPage extends StatelessWidget {
  ScanPage({super.key});

  IconData lightIcon = Icons.flash_on;
  final ScanController _controller = ScanController();

  void _getResult(String? result, BuildContext context) {
    debugPrint('-----$result');
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        backgroundColor: Colours.app_main_bg,
        centerTitle: ' 扫码',
      ),
      body: Stack(children: [
        ScanView(
          controller: _controller,
          scanLineColor: const Color(0xFF0083FB),
          onCapture: (data) {
            _controller.pause();
            _getResult(data, context);
          },
        ),
        Positioned(
          left: 100,
          bottom: 100,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return MaterialButton(
                  child: Icon(
                    lightIcon,
                    size: 40,
                    color: const Color(0xFF0083FB),
                  ),
                  onPressed: () {
                    _controller.toggleTorchMode();
                    if (lightIcon == Icons.flash_on) {
                      lightIcon = Icons.flash_off;
                    } else {
                      lightIcon = Icons.flash_on;
                    }
                    setState(() {});
                  });
            },
          ),
        ),
        Positioned(
          right: 100,
          bottom: 100,
          child: MaterialButton(
              child: const Icon(
                Icons.image,
                size: 40,
                color: Color(0xFF0083FB),
              ),
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final pickedFile = await picker.pickImage(
                    source: ImageSource.gallery, maxWidth: 800);

                if (pickedFile != null) {
                  _controller.pause();
                  final String? result = await Scan.parse(pickedFile.path);
                  _getResult(result, context);
                }
              }),
        ),
      ]),
    );
  }
}
