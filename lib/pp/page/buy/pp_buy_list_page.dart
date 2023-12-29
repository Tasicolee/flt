import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/util/theme_utils.dart';

import '../../../res/resources.dart';
import '../../../util/other_utils.dart';
import '../../../util/toast_utils.dart';
import '../../../widgets/my_refresh_list.dart';
import '../../dio/pp_httpclient.dart';
import '../../dio/pp_url_config.dart';
import '../../utils/pp_dialog_utils.dart';
import '../../utils/pp_navigator_utils.dart';
import '../../utils/pp_string_utils.dart';

/// 购买
class PpBuyMyListPage extends StatefulWidget {
  const PpBuyMyListPage({super.key});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<PpBuyMyListPage> {
  int _page = 1;

  List? _listSell = [];
  bool _hasMore = true;

  bool _isNeedCard = false;
  bool _isNeedWx = false;
  bool _isNeedZfb = false;
  String _money = '';

  final TextEditingController _inputController = TextEditingController();

  Future<dynamic> _onRefresh() async => _sellList(true);

  Future<dynamic> _loadMore() async => _sellList(false);

  @override
  void initState() {
    _onRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colours.app_main_bg,
      appBar: AppBar(
        systemOverlayStyle: ThemeUtils.appSystemUiOverlayStyle(),
        backgroundColor: Colours.app_main_bg,
        centerTitle: true,
        title: const Text('购买', style: TextStyles.txt18color000000),
        actions: [
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Images.pp_icon_filter,
              onTap: () => _showFilterDialog()),
          Gaps.hGap20,
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Images.pp_icon_history,
              onTap: () => goPpBuyOrderListPage(context)),
          Gaps.hGap20
        ],
        elevation: 0,
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Images.pp_back_top_left_page,
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: _listSell?.isNotEmpty == true
          ? DeerListView(
              itemCount: _listSell?.length ?? 0,
              onRefresh: _onRefresh,
              loadMore: _loadMore,
              hasMore: _hasMore,
              itemBuilder: (_, index) => _buildItem(index))
          : Images.pp_null_list_view);

  Widget _buildItem(int i) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      decoration: const BoxDecoration(
          color: Colours.colorFFFFFF, //设置背景颜色
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Images.pp_logo_circle24,
              Gaps.hGap10,
              Text(_listSell![i]['name'].toString(),
                  style: TextStyles.txt14color000000),
              const Expanded(child: Text('')),
              Images.pp_icon_hand,
              Gaps.hGap5,
              Text('成交量：${_listSell![i]['orders_count']}',
                  style: TextStyles.txt11colorB7B7B7)
            ],
          ),
          Gaps.vGap10,
          const Text('数量', style: TextStyles.txt11colorB7B7B7),
          Gaps.vGap10,
          Text(_listSell![i]['available_amount'].toString(),
              style: TextStyles.txt24color000000),
          Gaps.vGap10,
          Text('最低拆分限额：¥${_listSell![i]['available_amount']}',
              style: TextStyles.txt11colorB7B7B7),
          Stack(
            clipBehavior: Clip.none,
            children: [
              _getTypeView(
                  _listSell![i]['account_info_types'].toString().split(',')),
              Positioned(
                right: 0,
                child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
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
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child:
                          const Text('购买', style: TextStyles.txt14colorFFFFFF),
                    ),
                    onTap: () {
                      if (isNeedAuthentication()) {
                        showPpAuthenticationPageDialog(context);
                      } else {
                        _buy(_listSell![i]['order_amount'].toString(),
                            _listSell![i]['id'].toString());
                      }
                    }),
              )
            ],
          ),
        ],
      ));

  /// account_info_types 账户类型 (1微信, 2支付宝, 3银行卡)
  GridView _getTypeView(List list) => GridView.builder(
        padding: const EdgeInsets.only(top: 20, bottom: 5),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 15, //每行三列
          crossAxisSpacing: 10.0, // 横向间距
          mainAxisSpacing: 15.0, // 纵向间距
        ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          if (list[index].toString() == '1') {
            return Images.pp_card_icon_wx;
          } else if (list[index].toString() == '2') {
            return Images.pp_card_icon_zfb;
          } else if (list[index].toString() == '3') {
            return Images.pp_card_icon_card;
          }
        },
      );

  Future<void> _sellList(bool isRefresh) async {
    if (isRefresh) {
      _page = 1;
    }

    final List types = [];
    if (_isNeedWx) {
      types.add(1);
    }
    if (_isNeedZfb) {
      types.add(2);
    }
    if (_isNeedCard) {
      types.add(3);
    }

    final String s = getTaskScreen(types);
    PPHttpClient().get(PpUrlConfig.sellList, data: {
      'page': _page,
      'limit': 20,
      if (_money.isNotEmpty) 'order_amount': _money,
      if (_isNeedWx || _isNeedZfb || _isNeedCard) 'account_info_types': s,
    }, onSuccess: (jsonMap) {
      _page++;
      final list = jsonMap['data']['data'] as List;
      if (isRefresh) {
        _listSell = list;
      } else {
        _listSell?.addAll(list);
      }
      _hasMore = list?.length == 20;
      setState(() {});
    }, onError: (code, msg) {
      Toast.show(msg + code);
    });
  }

  /**
   * 参数名	必选	类型	说明
      transaction_amount	是	int	买币数量
      account_info_type	是	int	收款方式类型 1
      sell_orders_id	是	int	挂单id

   */

  ///
  void _buy(String transactionAmount, String sellOrdersId) {
    goPpBugConfirmPage(context, sellOrdersId);
  }

  Future<Future<int?>> _showFilterDialog() async {
    _money = '';
    _isNeedCard = false;
    _isNeedWx = false;
    _isNeedZfb = false;
    return showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (context, setStateDialog) =>
            _showFilterDialogView(setStateDialog),
      ),
    );
  }

  Container _showFilterDialogView(StateSetter setStateDialog) => Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Colours.app_main_bg,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        height: MediaQuery.of(context).size.height * 0.45,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    '筛选',
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
          Gaps.vGap20,
          GestureDetector(
            child: SizedBox(
              height: 52,
              child: Stack(
                children: [
                  Positioned(
                    left: 90,
                    top: 0,
                    child: Container(
                      width: 263,
                      height: 52,
                      padding: const EdgeInsets.all(15),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x0C4A590E),
                            blurRadius: 16,
                            offset: Offset(0, 6),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 22,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _money.isNotEmpty ? _money : '请输入',
                                    style: TextStyle(
                                      color: Color(_money.isNotEmpty
                                          ? 0xFF272729
                                          : 0xFFD7D7D7),
                                      fontSize: 14,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 20,
                    top: 15,
                    child: Text(
                      '币数量',
                      style: TextStyle(
                        color: Color(0xFF272729),
                        fontSize: 14,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () => _showHintDialog(setStateDialog),
          ),
          Gaps.vGap40,
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              '付款方式',
              style: TextStyle(
                color: Color(0xFF272729),
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
                height: 0.11,
              ),
            ),
          ),
          Gaps.vGap20,
          Row(
            children: [
              Gaps.hGap20,
              GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 38,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: ShapeDecoration(
                      color: Color(_isNeedCard ? 0xFF0083FB : 0xFFffffff),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x0C4A590E),
                          blurRadius: 16,
                          offset: Offset(0, 6),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Images.pp_card_icon_card17,
                        Gaps.hGap5,
                        Text(
                          '银行卡',
                          style: TextStyle(
                            color: Color(_isNeedCard ? 0xFFffffff : 0xFF999999),
                            fontSize: 14,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () =>
                      setStateDialog(() => _isNeedCard = !_isNeedCard)),
              Gaps.hGap20,
              GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 38,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: ShapeDecoration(
                      color: Color(_isNeedWx ? 0xFF0083FB : 0xFFffffff),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x0C4A590E),
                          blurRadius: 16,
                          offset: Offset(0, 6),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Images.pp_card_icon_wx17,
                        Gaps.hGap5,
                        Text(
                          '微信',
                          style: TextStyle(
                            color: Color(_isNeedWx ? 0xFFffffff : 0xFF999999),
                            fontSize: 14,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () => setStateDialog(() => _isNeedWx = !_isNeedWx)),
              Gaps.hGap20,
              GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 38,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: ShapeDecoration(
                      color: Color(_isNeedZfb ? 0xFF0083FB : 0xFFffffff),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x0C4A590E),
                          blurRadius: 16,
                          offset: Offset(0, 6),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Images.pp_card_icon_zfb17,
                        Gaps.hGap5,
                        Text(
                          '支付宝',
                          style: TextStyle(
                            color: Color(_isNeedZfb ? 0xFFffffff : 0xFF999999),
                            fontSize: 14,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () => setStateDialog(() => _isNeedZfb = !_isNeedZfb)),
              Gaps.hGap20,
            ],
          ),
          Gaps.vGap50,
          SizedBox(
            height: 50,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.hGap20,
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              goBackLastPage(context);
                            },
                            child: Container(
                              height: 50,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1000),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x0C4A590E),
                                    blurRadius: 16,
                                    offset: Offset(0, 6),
                                  )
                                ],
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '取消',
                                    style: TextStyle(
                                      color: Color(0xFFB6B6B6),
                                      fontSize: 17,
                                      fontFamily: 'PingFang HK',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.37,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      goBackLastPage(context);
                      _sellList(true);
                    },
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: ShapeDecoration(
                                // color: Colours.app_main_bg,
                                gradient: LinearGradient(
                                  begin: Alignment(1.00, -0.07),
                                  end: Alignment(-1, 0.07),
                                  colors: [
                                    Color(0xFF00CEF6),
                                    Color(0xFF0057FB)
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1000),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x70A0BE4B),
                                    blurRadius: 12,
                                    offset: Offset(0, 5),
                                  )
                                ],
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '筛选',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: 'PingFang HK',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.37,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Gaps.hGap20,
              ],
            ),
          ),
          Gaps.vGap50
        ]),
      );

  void _showHintDialog(StateSetter setStateDialog) {
    _inputController.text = _money;

    /// 关闭输入法，避免弹出
    //FocusManager.instance.primaryFocus?.unfocus();
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
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF0083FB),
                fontSize: 16,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w600,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, //数字，只能是整数
              ],
              controller: _inputController,
              maxLength: 18,
              decoration: const InputDecoration(
                counterText: '',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: '0',
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
                  onTap: () {
                    goBackLastPage(context);
                    _money = _inputController.text;
                    setStateDialog(() {});
                  },
                  child: const Text(
                    '确定',
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
}
