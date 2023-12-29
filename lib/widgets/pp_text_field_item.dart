import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/input_formatter/number_text_input_formatter.dart';

/// 封装输入框
class PPTextFieldItem extends StatelessWidget {
  const PPTextFieldItem({
    super.key,
    this.controller,
    required this.title,
    this.keyboardType = TextInputType.text,
    this.hintText = '',
    this.focusNode,
    required this.inputFormatters,
  });

  final TextEditingController? controller;
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final List<FilteringTextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    final Row child = Row(
      children: <Widget>[
        Text(
          title,
          style: TextStyles.txt16color000000,
        ),
        Gaps.hGap16,
        Expanded(
          child: Semantics(
            label: hintText.isEmpty ? '输入$title' : hintText,
            child: TextField(
                focusNode: focusNode,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters ?? _getInputFormatters(),
                controller: controller,
                //style: TextStyles.textDark14,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyles.txt16colorD8D8D8,
                  border: InputBorder.none, //去掉下划线
                  //hintStyle: TextStyles.textGrayC14
                ),
                style: TextStyles.txt16colorA0BE4B),
          ),
        ),
        Gaps.hGap16
      ],
    );

    return Container(
      child: child,
    );
  }

  List<TextInputFormatter>? _getInputFormatters() {
    if (keyboardType == const TextInputType.numberWithOptions(decimal: true)) {
      return <TextInputFormatter>[UsNumberTextInputFormatter()];
    }
    if (keyboardType == TextInputType.number ||
        keyboardType == TextInputType.phone) {
      return <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly];
    }
    return null;
  }
}
