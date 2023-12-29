import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_deer/pp/dio/pp_url_config.dart';

import '../utils/pp_global.dart';
import '../utils/pp_navigator_utils.dart';

typedef NetSuccessCallback<String> = Function(String data);
typedef NetErrorCallback = Function(String code, String msg);

class PPHttpClient {
  ///工厂构造函数与普通构造函数的区别在于，
  ///工厂构造函数可以自定义实例的创建过程，并根据需要返回一个新的对象或现有的对象。
  factory PPHttpClient() {
    return instance;
  }

  PPHttpClient._internal() {
    dio = Dio();
    dio.options.baseUrl = PpUrlConfig.BASE_URL;
    dio.interceptors.add(LogInterceptor(
        responseBody: true, requestBody: true, request: true)); // 输出响应内容体
  }

  late Dio dio;
  static PPHttpClient instance = PPHttpClient._internal();

  /// get请求
  Future<Response?> get(String url,
      {NetSuccessCallback<dynamic?>? onSuccess,
      NetErrorCallback? onError,
      Map<String, dynamic>? data}) async {
    try {
      final Map<String, dynamic> httpHeaders = {
        'Accept': 'application/json,*/*',
        'Content-Type': 'application/json',
        'authorization': authorizationGlobal
      };
      dio.options.headers = httpHeaders;
      debugPrint('------data=$data');
      final result = await dio.get(url, queryParameters: data);
      final jsonMap = jsonDecode(result.toString());
      if (result.statusCode == 200) {
        if (jsonMap['code'].toString() == '200') {
          onSuccess?.call(jsonMap);
        } else {
          onError?.call(
              jsonMap['code'].toString(), jsonMap['message'].toString());
          _tokenFailLogin(jsonMap['message'].toString());
        }
      } else {
        onError?.call(
            result.statusCode.toString(), result.statusMessage.toString());
      }
      return result;
    } catch (e) {
      onError?.call('-1', '服务器异常');
      return null;
    }
  }

  ///post请求
  Future<Response?> post(String url,
      {NetSuccessCallback<dynamic?>? onSuccess,
      NetErrorCallback? onError,
      Map<String, dynamic>? data}) async {
    try {
      final Map<String, dynamic> httpHeaders = {
        'Accept': 'application/json,*/*',
        'Content-Type': 'application/json',
        'authorization': authorizationGlobal
      };
      dio.options.headers = httpHeaders;
      debugPrint('------data=$data');
      final result = await dio.post(url, queryParameters: data);
      final jsonMap = jsonDecode(result.toString());
      if (result.statusCode == 200) {
        if (jsonMap['code'].toString() == '200') {
          onSuccess?.call(jsonMap);
        } else {
          onError?.call(
              jsonMap['code'].toString(), jsonMap['message'].toString());
          _tokenFailLogin(jsonMap['message'].toString());
        }
      } else {
        onError?.call(
            result.statusCode.toString(), result.statusMessage.toString());
      }
      return result;
    } catch (e) {
      onError?.call('-1', '服务器异常');
      return null;
    }
  }

  void _tokenFailLogin(String msg) {
    if (msg.contains('认证失败')) {
      goPpLoginPage(appContext!);
    }
  }
}
