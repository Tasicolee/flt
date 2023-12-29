import 'dart:async';

import 'package:flutter/cupertino.dart';

//分：秒倒计时器
class PpCountDownWidget extends StatefulWidget {
  final String validTime;
  final double? textSize;
  final Color? textColor;
  final ValueChanged<bool>? isFinish;

  //CountDownWidget(this.validTime, {this.textSize});
  const PpCountDownWidget(this.validTime,
      {Key? key, this.textSize, this.textColor, this.isFinish})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CountDownWidgetState();
  }
}

class _CountDownWidgetState extends State<PpCountDownWidget> {
  var _timer;

  @override
  void dispose() {
    if (_timer?.isActive == true) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // log("_timerString    240000");
    if (widget.validTime.isEmpty) {
      return Container();
    }
    int endTime = int.parse(widget.validTime);
    //数字格式化，将 0~9 的时间转换为 00~09
    DateTime now = DateTime.now();
    //把后台返回的结束时间换为DateTime类型
    DateTime endTimeDate = DateTime.fromMillisecondsSinceEpoch(endTime);
    //和当前时间相减
    Duration difference = endTimeDate.difference(now);
    //获取运算完成的时间
    int computingTime = difference.inSeconds;
    String computingTimeDate = constructFirstTime(computingTime);
    var txtArray = computingTimeDate.split(",");
    late String textContext = constructTime(computingTime);

    if (computingTime < 0) {
      textContext = "计时结束";
      if (widget.isFinish != null) {
        widget.isFinish!(true);
      }

      return Text(
        '计时结束',
        style: TextStyle(
            fontSize: widget.textSize ?? 12.0,
            color: widget.textColor ??
                CupertinoDynamicColor.resolve(
                    CupertinoColors.systemRed, context)),
      );
    } else {
      if (int.parse(txtArray[0]) > 0) {
        return Text(
          '59:59',
          style: TextStyle(
              fontSize: widget.textSize ?? 12.0,
              color: widget.textColor ??
                  CupertinoDynamicColor.resolve(
                      CupertinoColors.systemRed, context)),
        );
      } else {
        if (computingTime > 0) {
          _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            if (computingTime > 0) {
              final String computingTimeDate = constructTime(computingTime);
              textContext = computingTimeDate;
              setState(() {});
              timer.cancel();
            } else {
              timer.cancel();
              textContext = '计时结束';
              if (widget.isFinish != null) {
                widget.isFinish!(true);
              }

              setState(() {});
            }
          });
        } else {
          if (widget.isFinish != null) {
            widget.isFinish!(true);
          }

          return Text(
            '计时结束',
            style: TextStyle(
                fontSize: widget.textSize ?? 12.0,
                color: widget.textColor ??
                    CupertinoDynamicColor.resolve(
                        CupertinoColors.systemRed, context)),
          );
        }
      }

      return Text(
        textContext,
        style: TextStyle(
            fontSize: widget.textSize ?? 12.0,
            color: widget.textColor ??
                CupertinoDynamicColor.resolve(
                    CupertinoColors.systemRed, context)),
      );
    }
  }

  String formatTime(int timeNum) {
    return timeNum < 10 ? '0$timeNum' : timeNum.toString();
  }

  String constructFirstTime(int seconds) {
    final int hour = seconds ~/ 3600;
    final int minute = seconds % 3600 ~/ 60;
    final int second = seconds % 60;
    return '${formatTime(hour)},${formatTime(minute)}:${formatTime(second)}';
  }

  String constructTime(int seconds) {
    final int minute = seconds % 3600 ~/ 60;
    final int second = seconds % 60;
    return '${formatTime(minute)}:${formatTime(second)}';
  }
}
