import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_deer/pp/page/bill/pp_bill_item.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast_utils.dart';
import 'package:flutter_deer/widgets/my_refresh_list.dart';
import 'package:flutter_deer/widgets/state_layout.dart';

import '../../../res/resources.dart';
import '../../dio/pp_httpclient.dart';
import '../../dio/pp_url_config.dart';
import '../../utils/pp_global.dart';
import '../../utils/pp_navigator_utils.dart';

///账单记录
class PpBillListPage extends StatefulWidget {
  const PpBillListPage({super.key});

  @override
  _PpBillListPageState createState() => _PpBillListPageState();
}

class _PpBillListPageState extends State<PpBillListPage> {
  _PpBillListPageState();

  List _list = [];

  int _page = 1;
  bool _hasMore = true;

  StateType _stateType = StateType.loading;

  String _timeStart = '';
  String _timeEnd = '';
  String _timeStartMilliseconds = '';
  String _timeEndMilliseconds = '';

  final List? _listType = (billTypeGlobal as Map?)?.values?.toList();

  int _listTypeIndex = -1;

  Future<dynamic> _onRefresh() async => _buyList(true);

  Future<dynamic> _loadMore() async => _buyList(false);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colours.app_main_bg,
        appBar: AppBar(
          systemOverlayStyle: ThemeUtils.appSystemUiOverlayStyle(),
          backgroundColor: Colours.app_main_bg,
          centerTitle: true,
          title: const Text('账单记录', style: TextStyles.txt18color000000),
          elevation: 0,
          leading: IconButton(
              icon: Images.pp_back_top_left_page,
              onPressed: () => Navigator.of(context).pop()),
          actions: [
            GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Images.pp_icon_filter,
                onTap: () => _showFilterDialog()),
            Gaps.hGap20
          ],
        ),
        body: _list.isNotEmpty
            ? DeerListView(
                itemCount: _list.length,
                stateType: _stateType,
                onRefresh: _onRefresh,
                loadMore: _loadMore,
                hasMore: _hasMore,
                itemBuilder: (_, index) =>
                    PpBillListItemPage(item: _list[index]))
            : Images.pp_null_list_view,
      );

  Future<Future<int?>> _showFilterDialog() async {
    _timeStart = '';
    _timeEnd = '';
    _timeStartMilliseconds = '';
    _timeEndMilliseconds = '';
    _listTypeIndex = -1;

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
        height: MediaQuery.of(context).size.height * 0.6,
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
          Row(
            children: [
              Gaps.hGap20,
              const Text(
                '开始时间',
                style: TextStyle(
                  color: Color(0xFF272729),
                  fontSize: 14,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Gaps.hGap20,
              Expanded(
                child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _showTime(setStateDialog, true),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _timeStart.isEmpty ? '请选择开始时间' : _timeStart,
                                    style: TextStyle(
                                      color: Color(_timeStart.isEmpty
                                          ? 0xFFD7D7D7
                                          : 0xFF272729),
                                      fontSize: 14,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(width: 35),
                                  Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 16,
                                          height: 16,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(),
                                          child: const Stack(children: [
                                            Images.pp_icon_time_picker
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              Gaps.hGap20,
            ],
          ),
          Gaps.vGap20,
          Row(
            children: [
              Gaps.hGap20,
              const Text(
                '结束时间',
                style: TextStyle(
                  color: Color(0xFF272729),
                  fontSize: 14,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Gaps.hGap20,
              Expanded(
                  child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _showTime(setStateDialog, false),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _timeEnd.isEmpty ? '请选择结束时间' : _timeEnd,
                                style: TextStyle(
                                  color: Color(_timeEnd.isEmpty
                                      ? 0xFFD7D7D7
                                      : 0xFF272729),
                                  fontSize: 14,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(width: 35),
                              Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(),
                                      child: const Stack(children: [
                                        Images.pp_icon_time_picker
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
              Gaps.hGap20,
            ],
          ),
          Gaps.vGap20,
          Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: _getTypeView(setStateDialog)),
          Gaps.vGap20,
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
                            onTap: () => goBackLastPage(context),
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
                    onTap: () => _save(),
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
          Gaps.vGap50,
        ]),
      );

  GridView _getTypeView(setStateDialog) => GridView.builder(
    shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, //每行三列
          childAspectRatio: 2.0, //显示区域宽高相等
          crossAxisSpacing: 20.0, // 横向间距
          mainAxisSpacing: 15.0, // 纵向间距
        ),
        itemCount: _listType?.length,
        itemBuilder: (context, index) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: ShapeDecoration(
                color: Color(_listTypeIndex == index ? 0xFF0083FB : 0xFFffffff),
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
                  Text(
                    _listType![index]['type_name'].toString(),
                    style: TextStyle(
                      color: Color(
                          _listTypeIndex == index ? 0xFFffffff : 0xFF999999),
                      fontSize: 11,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () => setStateDialog(() => _listTypeIndex = index)),
      );

  void _showTime(setStateDialog, bool isStart) =>
      DatePicker.showDatePicker(context,
          minTime: DateTime(2022, 11, 11),
          maxTime: DateTime.timestamp(), onChanged: (date) {
        debugPrint('change $date');
      }, onConfirm: (date) {
        setStateDialog(() {
          if (isStart) {
            _timeStartMilliseconds =
                (date.millisecondsSinceEpoch / 1000).ceil().toString();
            _timeStart = '${date.year}-${date.month}-${date.day}';
          } else {
            _timeEndMilliseconds =
                (date.millisecondsSinceEpoch / 1000).ceil().toString();
            _timeEnd = '${date.year}-${date.month}-${date.day}';
          }
        });
      }, currentTime: DateTime.now(), locale: LocaleType.zh);

  void _save() {
    goBackLastPage(context);
    _buyList(true);
  }

  /**
   * page	是	string	页码
      limit	是	string	每页条数
      order_status	否
      int	订单状态 4.已完成，5.已取消，6.申述中 进行中的状态 123（是数字一百二十三哦

      "1": "卖家挂单冻结金额",
      "2": "人工上分", .
      "3": "人工下分", .
      "4": "卖家放行扣减卖家冻结金额",
      "5": "买家买分",
      "6": "转出", .
      "7": "转入 .
   */

  /// billList
  void _buyList(bool isRefresh) {
    if (isRefresh) {
      _page = 1;
    }
    final data = {
      'page': _page,
      'limit': 20,
      if (_timeStartMilliseconds.isNotEmpty)
        'start_time': _timeStartMilliseconds,
      if (_timeEndMilliseconds.isNotEmpty) 'end_time': _timeEndMilliseconds,
      if (_listTypeIndex != -1)
        'type': _listType![_listTypeIndex]['type_id'].toString()
    };

    PPHttpClient().get(PpUrlConfig.billList, data: data, onSuccess: (jsonMap) {
      _page++;
      final list = jsonMap['data']['data'] as List;
      if (isRefresh) {
        _list = list;
      } else {
        _list.addAll(list);
      }
      _hasMore = list.length == 20;

      setState(() {});
    }, onError: (code, msg) {
      Toast.show(msg + code);

      setState(() {});
    });
  }
}
