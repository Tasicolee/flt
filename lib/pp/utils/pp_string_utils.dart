import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

///数组转字符串 , 隔开
String getTaskScreen(List list) {
  final List tempList = [];
  String str = '';
  for (int i = 0; i < list.length; i++) {
    final f = list[i];
    tempList.add(f);
  }

  for (final f in tempList) {
    if (str == '') {
      str = '$f';
    } else {
      str = '$str,$f';
    }
  }
  return str;
}

String getDataStr(String time) {
  return (DateTime.fromMillisecondsSinceEpoch(int.parse(time)).toString());
}

/**
 * account_type	string	账户类型 (1微信, 2支付宝, 3银行卡)
 */
String getAccountType(String type) {
  String string = '';
  if (type == '1') {
    string = '微信';
  } else if (type == '2') {
    string = '支付宝';
  } else if (type == '3') {
    string = '银行卡';
  }

  return string;
}

Future<String> versionCodeString() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();

  //APP名称
  final String appName = packageInfo.appName;
  //包名
  final String packageName = packageInfo.packageName;
  //版本名 1.0.0
  final String version = packageInfo.version;
  //版本号 1
  final String buildNumber = packageInfo.buildNumber;

  debugPrint('------$appName=$packageName=$version=$buildNumber');

  return buildNumber;
}

Future<String> versionString() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();

  //APP名称
  final String appName = packageInfo.appName;
  //包名
  final String packageName = packageInfo.packageName;
  //版本名 1.0.0
  final String version = packageInfo.version;
  //版本号 1
  final String buildNumber = packageInfo.buildNumber;

  debugPrint('------$appName=$packageName=$version=$buildNumber');

  return version;
}
