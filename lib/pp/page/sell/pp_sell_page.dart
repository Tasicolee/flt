import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/pp/utils/pp_navigator_utils.dart';
import 'package:flutter_deer/pp/utils/pp_string_utils.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';

import '../../../util/other_utils.dart';
import '../../../util/toast_utils.dart';
import '../../dio/pp_httpclient.dart';
import '../../dio/pp_url_config.dart';
import '../../utils/pp_global.dart';

/// 出售 ED币
class PpSellPage extends StatefulWidget {
  const PpSellPage({super.key});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PpSellPage> {
  final TextEditingController _inputController = TextEditingController();
  bool _isCanOpen = false;
  String _openMoney = '1';
  final TextEditingController _controllerDialog = TextEditingController();

  @override
  void initState() {
    _getInfoCounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colours.app_main_bg,
      appBar: const MyAppBar(
          centerTitle: '出售 ED币', backgroundColor: Colours.app_main_bg),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gaps.vGap20,
            Container(
              width: 198,
              padding: const EdgeInsets.all(2),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: const Color(0x0509090B),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => setState(() => _isCanOpen = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color:
                                !_isCanOpen ? Colors.white : Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '不拆分出售',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: !_isCanOpen
                                          ? const Color(0xFF18181B)
                                          : const Color(0xFFB6B6B6),
                                      fontSize: 14,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => setState(() => _isCanOpen = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color:
                              !_isCanOpen ? Colors.transparent : Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '可拆分出售',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: !_isCanOpen
                                        ? const Color(0xFFB6B6B6)
                                        : const Color(0xFF18181B),
                                    fontSize: 14,
                                    fontFamily: 'PingFang SC',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Gaps.vGap50,
            //9194A6
            const Row(
              children: [
                Expanded(child: Text('')),
                Images.pp_home_card_logo,
                Gaps.hGap4,
                Text('ED币', style: TextStyles.txt20color9194A6),
                Expanded(child: Text(''))
              ],
            ),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, //数字，只能是整数
                  ],
                  textAlign: TextAlign.center,
                  style: TextStyles.txt48colorB2D33,
                  controller: _inputController,
                  maxLength: 18,
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding:
                        const EdgeInsets.only(left: 90, top: 20, bottom: 20),
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: '0',
                    hintStyle: TextStyles.txt48colorB7B7B7,
                    suffixIcon: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                          alignment: Alignment.center,
                          width: 60,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 1.0),
                          margin:
                              const EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
                          decoration: const BoxDecoration(
                              color: Colours.colorFFFFFF, //设置背景颜色
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: const Text('max',
                              style: TextStyles.txt17color272729)),
                      onTap: () => _inputController.text =
                          ppUserEntityGlobal!.account_balance.toString(),
                    ),
                  ),
                ),
              ],
            ),
            Text('余额：${ppUserEntityGlobal?.account_balance}',
                style: TextStyles.txt12color9194A6),
            Gaps.vGap12,
            if (!_isCanOpen)
              Container()
            else
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '最低可拆分限额：$_openMoney',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF9194A6),
                      fontSize: 12,
                      fontFamily: 'PingFang HK',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.37,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: const Text(
                      '修改',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF0083FB),
                        fontSize: 12,
                        fontFamily: 'PingFang HK',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.37,
                      ),
                    ),
                    onTap: () => _showMoneyDialog(),
                  )
                ],
              ),
            Gaps.vGap150,
            Gaps.lineF6F6F6,
            Gaps.vGap20,
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _showBankCardDialog(),
              child: Row(
                children: [
                  Gaps.hGap20,
                  const Text(
                    '选择收款方式',
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 14,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Expanded(child: Text('')),
                  if (_isNeedBank) Images.pp_card_icon_card else Container(),
                  if (_isNeedBank) Gaps.hGap5 else Gaps.hGap0,
                  if (_isNeedWx) Images.pp_card_icon_wx else Container(),
                  if (_isNeedWx) Gaps.hGap5 else Gaps.hGap0,
                  if (_isNeedZfb) Images.pp_card_icon_zfb else Container(),
                  if (_isNeedZfb) Gaps.hGap5 else Gaps.hGap0,
                  Images.arrowRight,
                  Gaps.hGap20,
                ],
              ),
            ),
            Gaps.vGap32,
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _summit(),
              child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 15.0),
                  margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                  decoration: const BoxDecoration(
                      color: Colours.colorA0BE4B, //设置背景颜色
                      gradient: LinearGradient(
                        begin: Alignment(1.00, -0.07),
                        end: Alignment(-1, 0.07),
                        colors: [
                          Color(0xFF00CEF6),
                          Color(0xFF0057FB),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: const Row(
                    children: [
                      Expanded(child: Text('')),
                      Text('出售', style: TextStyles.txt17colorFFFFFF),
                      Expanded(child: Text('')),
                    ],
                  )),
            ),
          ],
        ),
      ));

  void _summit() {
    if (_inputController.text.isEmpty) {
      Toast.show('请输入出售金额');
      return;
    }
    _save();
  }

  bool _isNeedBank = false;
  bool _isNeedWx = false;
  bool _isNeedZfb = false;

  bool _isBindBank = false;
  bool _isBindWx = false;
  bool _isBindZfb = false;

  Future<Future<int?>> _showBankCardDialog() async => showModalBottomSheet<int>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
          builder: (context, setStateDialog) =>
              _showBankCardDialogView(setStateDialog),
        ),
      );

  Container _showBankCardDialogView(StateSetter setStateDialog) => Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Colours.app_main_bg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(children: [
          SizedBox(
            height: 50,
            child: Stack(
              textDirection: TextDirection.rtl,
              children: [
                Positioned(
                    left: 0,
                    top: 5,
                    child: IconButton(
                        icon: const Icon(Icons.keyboard_arrow_left),
                        onPressed: () => Navigator.of(context).pop())),
                const Center(
                  child: Text(
                    '收款方式',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1F2024),
                      fontSize: 16,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Gaps.vGap20,
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    padding: const EdgeInsets.only(
                        left: 10, top: 20, bottom: 20, right: 10),
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colours.colorFFFFFF,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Row(
                      children: [
                        Gaps.hGap10,
                        Images.pp_card_icon_card_20,
                        Gaps.hGap10,
                        const Text(
                          '银行卡',
                          style: TextStyle(
                            color: Color(0xFF1D2129),
                            fontSize: 16,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Expanded(child: Text('')),
                        if (_isBindBank)
                          if (_isNeedBank)
                            Images.pp_icon_selected
                          else
                            Images.pp_icon_selected_un
                        else
                          _goBindView(),
                        Gaps.hGap10,
                      ],
                    ),
                  ),
                  onTap: () async {
                    if (_isBindBank) {
                      setStateDialog(() {
                        _isNeedBank = !_isNeedBank;
                      });
                      setState(() {});
                    } else {
                      goBackLastPage(context);
                      await goPpAddBankPage(context);
                      _getInfoCounts();
                    }
                  },
                ),
                Gaps.vGap20,
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    padding: const EdgeInsets.only(
                        left: 10, top: 20, bottom: 20, right: 10),
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colours.colorFFFFFF,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Row(
                      children: [
                        Gaps.hGap10,
                        Images.pp_card_icon_wx_20,
                        Gaps.hGap10,
                        const Text(
                          '微信支付',
                          style: TextStyle(
                            color: Color(0xFF1D2129),
                            fontSize: 16,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Expanded(child: Text('')),
                        if (_isBindWx)
                          if (_isNeedWx)
                            Images.pp_icon_selected
                          else
                            Images.pp_icon_selected_un
                        else
                          _goBindView(),
                        Gaps.hGap10,
                      ],
                    ),
                  ),
                  onTap: () async {
                    if (_isBindWx) {
                      setStateDialog(() {
                        _isNeedWx = !_isNeedWx;
                      });
                      setState(() {});
                    } else {
                      goBackLastPage(context);
                      await goPpAddWxPage(context);
                      _getInfoCounts();
                    }
                  },
                ),
                Gaps.vGap20,
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    padding: const EdgeInsets.only(
                        left: 10, top: 20, bottom: 20, right: 10),
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Colours.colorFFFFFF,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Row(
                      children: [
                        Gaps.hGap10,
                        Images.pp_card_icon_zfb_20,
                        Gaps.hGap10,
                        const Text(
                          '支付宝',
                          style: TextStyle(
                            color: Color(0xFF1D2129),
                            fontSize: 16,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Expanded(child: Text('')),
                        if (_isBindZfb)
                          if (_isNeedZfb)
                            Images.pp_icon_selected
                          else
                            Images.pp_icon_selected_un
                        else
                          _goBindView(),
                        Gaps.hGap10,
                      ],
                    ),
                  ),
                  onTap: () async {
                    // _updateCard();
                    if (_isBindZfb) {
                      setStateDialog(() {
                        _isNeedZfb = !_isNeedZfb;
                      });
                      setState(() {});
                    } else {
                      goBackLastPage(context);
                      await goPpAddZfbPage(context);
                      _getInfoCounts();
                    }
                  },
                ),
              ],
            ),
          ),
        ]),
      );

  Text _goBindView() => const Text(
        '去绑定',
        textAlign: TextAlign.right,
        style: TextStyle(
          color: Color(0xFF0083FB),
          fontSize: 16,
          fontFamily: 'PingFang SC',
          fontWeight: FontWeight.w400,
        ),
      );

  void _showMoneyDialog() {
    _controllerDialog.text = _openMoney;

    /// 关闭输入法，避免弹出
    FocusManager.instance.primaryFocus?.unfocus();
    showElasticDialog<void>(
      context: context,
      builder: (BuildContext context) {
        const OutlinedBorder buttonShape = RoundedRectangleBorder();
        final Widget content = Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              '输入金额',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFB6B6B6),
                fontSize: 16,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w600,
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, //数字，只能是整数
              ],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF0083FB),
                fontSize: 16,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w600,
              ),
              controller: _controllerDialog,
              maxLength: 18,
              decoration: const InputDecoration(
                counterText: '',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: '输入金额',
                hintStyle: TextStyle(
                  color: Color(0xFFeeeeee),
                  fontSize: 16,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Gaps.lineF6F6F6,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    '取消',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 16,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )),
                const SizedBox(
                    height: 50,
                    child: VerticalDivider(color: Colours.colorF5F5F5)),
                Expanded(
                    child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _saveMoneyDialog(),
                  child: const Text(
                    '保存',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF0083FB),
                      fontSize: 16,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )),
              ],
            )
          ],
        );

        final Widget decoration = Container(
          decoration: BoxDecoration(
            color: Colours.app_main_bg,
            borderRadius: BorderRadius.circular(8.0),
          ),
          width: 270.0,
          padding: const EdgeInsets.only(top: 24.0),
          child: TextButtonTheme(
            data: TextButtonThemeData(
              style: TextButton.styleFrom(
                // 文字颜色
                foregroundColor: const Color(0xFFB6B6B6),
                // 按钮大小
                minimumSize: Size.infinite,
                // 修改默认圆角
                shape: buttonShape,
              ),
            ),
            child: content,
          ),
        );

        return Material(
          color: Colours.app_main_bg,
          type: MaterialType.transparency,
          child: Center(
            child: decoration,
          ),
        );
      },
    );
  }

  void _saveMoneyDialog() {
    final String str = _controllerDialog.text;
    if (int.parse(_inputController.text) < int.parse(str)) {
      Toast.show('拆分金额不能大于出售金额');
      return;
    }
    _openMoney = str;
    setState(() {});
    goBackLastPage(context);
  }

  Future<void> _getInfoCounts() async {
    PPHttpClient().get(PpUrlConfig.getInfoCounts, onSuccess: (jsonMap) {
      final List list = jsonMap['data'] as List;
      list.forEach((element) {
        if (element['account_type'] == '1') {
          _isBindWx = true;
          _isNeedWx = true;
        } else if (element['account_type'] == '2') {
          _isBindZfb = true;
          _isNeedZfb = true;
        } else if (element['account_type'] == '3') {
          _isBindBank = true;
          _isNeedBank = true;
        }
      });
      setState(() {});
    }, onError: (code, msg) {
      Toast.show(msg + code);
    });
  }

  /**
   * 参数名	必选	类型	说明
      order_amount	是	int	出售数量
      account_info_types	是	int	收款类型，多个用英文逗号分割开 账户类型 (1微信, 2支付宝, 3银行卡)
      sell_type	是	int	挂单类型：0 可拆分订单，1 不可拆分订单
      split_amount	否	int	拆分金额可拆分订单最低限额：订单的最小购买金额
   */

  /// 卖币挂单接口
  Future<void> _save() async {
    final List types = [];
    if (_isNeedWx) {
      types.add(1);
    }
    if (_isNeedZfb) {
      types.add(2);
    }
    if (_isNeedBank) {
      types.add(3);
    }
    if (!_isNeedWx && !_isNeedZfb && !_isNeedBank) {
      Toast.show('请先选择付款方式');
      return;
    }
    final String s = getTaskScreen(types);
    PPHttpClient().post(PpUrlConfig.sellAdd, data: {
      'order_amount': _inputController.text,
      'account_info_types': s,
      'sell_type': _isCanOpen ? '0' : '1',
      if (_isCanOpen) 'split_amount': _openMoney,
    }, onSuccess: (jsonMap) {
      Toast.show('出售成功');
      goBackLastPage(context);
      goPpPendingListPage(context);
    }, onError: (code, msg) {
      Toast.show(msg + code);
    });
  }
}
