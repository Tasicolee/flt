import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/pp/page/mine/pwd/lock/pp_pwd_gesture_lock_page.dart';
import 'package:flutter_deer/pp/page/pp_splash_page.dart';
import 'package:flutter_deer/pp/utils/pp_global.dart';
import 'package:flutter_deer/res/constant.dart';
import 'package:flutter_deer/util/device_utils.dart';
import 'package:flutter_deer/util/handle_error_utils.dart';
import 'package:flutter_deer/util/log_utils.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sp_util/sp_util.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  /// 异常处理
  handleError(() async {
    /// 确保初始化完成
    WidgetsFlutterBinding.ensureInitialized();

    if (Device.isDesktop) {
      await WindowManager.instance.ensureInitialized();
      windowManager.waitUntilReadyToShow().then((_) async {
        /// 设置桌面端窗口大小
        await windowManager.setSize(const Size(400, 800));
        await windowManager.setMinimumSize(const Size(400, 800));

        /// 居中显示
        await windowManager.center();
        await windowManager.show();
        await windowManager.setPreventClose(false);
        await windowManager.setSkipTaskbar(false);
      });
    }

    /// 去除URL中的“#”(hash)，仅针对Web。默认为setHashUrlStrategy
    /// 注意本地部署和远程部署时`web/index.html`中的base标签，https://github.com/flutter/flutter/issues/69760
    setPathUrlStrategy();

    /// sp初始化
    await SpUtil.getInstance();

    /// 监测app状态
    SystemChannels.lifecycle.setMessageHandler((msg) async {
      debugPrint('-----SystemChannels> $msg');
      final time = DateTime.now().millisecondsSinceEpoch;
      final out = SpUtil.getInt(Constant.app_time_out) ?? 0;
      final back = SpUtil.getInt(Constant.app_time_back) ?? 0;
      final pwd = SpUtil.getString(Constant.app_pwd_lock_number_string);
      final isOpen = SpUtil.getBool(Constant.app_pwd_lock_number_open_bool);
      debugPrint('-----SystemChannels>out $out');
      debugPrint('-----SystemChannels>back $back');
      if (isOpen == true &&
          pwd?.isNotEmpty == true &&
          out != 0 &&
          back != 0 &&
          time - out > 1 * 30 * 1000 &&
          !isOpenPpPwdLockGesturePage) {
        navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const PpPwdLockGesturePage()),
            (route) => route == route);
      }

      if (msg == AppLifecycleState.inactive.toString()) {
        SpUtil.putInt(Constant.app_time_out, time);
      } else if (msg == AppLifecycleState.paused.toString()) {
        //离开app
        SpUtil.putInt(Constant.app_time_out, time);
      } else if (msg == AppLifecycleState.resumed.toString()) {
        //返回app
        SpUtil.putInt(Constant.app_time_back, time);
      } else {}

      return msg;
    });
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    Log.init();
  }

  @override
  Widget build(BuildContext context) {
    appContext = context;

    /// Toast 配置
    return OKToast(
        backgroundColor: Colors.black54,
        textPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        radius: 20.0,
        position: ToastPosition.bottom,
        child: _buildMaterialApp());
  }

  Widget _buildMaterialApp() {
    return MaterialApp(
      title: 'ED Pay',
      // showPerformanceOverlay: true, //显示性能标签
      debugShowCheckedModeBanner: false,
      // 去除右上角debug的标签
      // checkerboardRasterCacheImages: true,
      // showSemanticsDebugger: true, // 显示语义视图
      // checkerboardOffscreenLayers: true, // 检查离屏渲染

      // theme: theme ?? provider.getTheme(),
      // themeMode: provider.getThemeMode(),
      home: const PpSplashPage(),
      navigatorKey: navigatorKey,

      builder: (BuildContext context, Widget? child) {
        /// 仅针对安卓
        if (Device.isAndroid) {
          /// 切换深色模式会触发此方法，这里设置导航栏颜色
          ThemeUtils.setAppSystemBarStyle();
        }

        /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },

      restorationScopeId: 'app',
    );
  }
}
