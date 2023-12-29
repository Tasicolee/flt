import 'package:flutter/foundation.dart';

class Constant {
  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction = kReleaseMode;

  static bool isDriverTest = false;
  static bool isUnitTest = false;

  static const String data = 'data';
  static const String message = 'message';
  static const String code = 'code';

  static const String keyGuide = 'keyGuide';
  static const String phone = 'phone';
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';

  static const String theme = 'AppTheme';
  static const String locale = 'locale';

  //PP新增
  static const String isLogin = 'pp_isLogin';
  static const String authorization = 'authorization';
  static const String qiniuToken = 'qiniuToken';
  static const String qiniu_domain = 'qiniu_domain';
  static const String app_time_out = 'app_time_out';
  static const String app_time_back = 'app_time_back';

  static const String app_pwd_lock_number_open_bool =
      'app_pwd_lock_number_open_bool';
  static const String app_pwd_lock_number_string = 'app_pwd_lock_number_string';
  static const String app_pwd_lock_face_string = 'app_pwd_lock_face_string';
  static const String app_pwd_lock_face_replace_bool =
      'app_pwd_lock_face_replace';
}
