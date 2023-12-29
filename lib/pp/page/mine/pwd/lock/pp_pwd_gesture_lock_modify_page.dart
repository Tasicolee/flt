import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:sp_util/sp_util.dart';

import '../../../../../res/constant.dart';

/// 手势密码修改
class PpPwdLockModifyPage extends StatefulWidget {
  const PpPwdLockModifyPage({super.key});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PpPwdLockModifyPage> {
  bool _isOpen = false;

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    _isOpen = SpUtil.getBool(Constant.app_pwd_lock_number_open_bool)!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colours.app_main_bg,
        appBar: const MyAppBar(
            centerTitle: '手势密码', backgroundColor: Colours.app_main_bg),
        body: Column(
          children: <Widget>[
            Gaps.vGap20,
            Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 20, top: 15, bottom: 15),
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                decoration: const BoxDecoration(
                    color: Colours.colorFFFFFF, //设置背景颜色
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Gaps.hGap8,
                        const Text(
                          '手势密码',
                          style: TextStyles.txt16color272729,
                        ),
                        const Expanded(child: Text('')),
                        MergeSemantics(
                          child: CupertinoSwitch(
                            value: _isOpen,
                            onChanged: (bool value) => _onChanged(value),
                          ),
                        ),
                      ],
                    ),
                    Gaps.vGap8,
                    Gaps.lineF6F6F6,
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => goPpPwdLockGestureSetPage(context, '修改手势密码'),
                      child: const Row(
                        children: <Widget>[
                          Gaps.hGap8,
                          Text(
                            '修改手势密码',
                            style: TextStyles.txt16color272729,
                          ),
                          Expanded(child: Text('')),
                          Images.pp_mine_right_arrow,
                        ],
                      ),
                    ),
                    Gaps.vGap8,
                  ],
                )),
          ],
        ),
      );

  void _onChanged(bool value) {
    setState(() {
      _isOpen = value;
    });
    SpUtil.putBool(Constant.app_pwd_lock_number_open_bool, value);
  }
}
