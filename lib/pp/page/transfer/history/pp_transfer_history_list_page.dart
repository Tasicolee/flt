import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_deer/pp/page/transfer/history/pp_transfer_item.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';

import '../../../../util/toast_utils.dart';
import '../../../../widgets/my_refresh_list.dart';
import '../../../dio/pp_httpclient.dart';
import '../../../dio/pp_url_config.dart';
import '../../../utils/pp_navigator_utils.dart';

/// 记录-转账记录
class PpTransferHistoryListPage extends StatefulWidget {
  const PpTransferHistoryListPage({super.key});

  @override
  _PpBillListPageState createState() => _PpBillListPageState();
}

class _PpBillListPageState extends State<PpTransferHistoryListPage>
    with
        AutomaticKeepAliveClientMixin<PpTransferHistoryListPage>,
        SingleTickerProviderStateMixin {
  _PpBillListPageState();

  List _list = [];

  Future<dynamic> _onRefresh() async => _transferList(true);

  Future<dynamic> _loadMore() async => _transferList(false);

  int _page = 1;

  bool _hasMore = true;

  String _timeStart = '';
  String _timeEnd = '';
  String _timeStartMilliseconds = '';
  String _timeEndMilliseconds = '';
  bool _isOutType = false;

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
          title: const Text('转账记录', style: TextStyles.txt18color000000),
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
        body: _list?.isNotEmpty == true
            ? DeerListView(
                itemCount: _list.length,
                onRefresh: _onRefresh,
                loadMore: _loadMore,
                hasMore: _hasMore,
                itemBuilder: (_, index) =>
                    PpTransferListItemPage(item: _list[index]))
            : Images.pp_null_list_view,
      );

  @override
  bool get wantKeepAlive => true;

  Future<Future<int?>> _showFilterDialog() async {
    _timeStart = '';
    _timeEnd = '';
    _timeStartMilliseconds = '';
    _timeEndMilliseconds = '';
    _isOutType = false;
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

  Container _showFilterDialogView(StateSetter setState) => Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Colours.app_main_bg,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        height: MediaQuery.of(context).size.height * 0.45,
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
                    onTap: () => _showTime(setState, true),
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
                onTap: () => _showTime(setState, false),
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
          Row(
            children: [
              Gaps.hGap20,
              GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 87.50,
                    height: 38,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: ShapeDecoration(
                      color: Color(_isOutType ? 0xFFffffff : 0xFF0083FB),
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
                          '转入',
                          style: TextStyle(
                            color: Color(_isOutType ? 0xFF999999 : 0xFFffffff),
                            fontSize: 14,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () => setState(() => _isOutType = false)),
              Gaps.hGap20,
              GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 87.50,
                    height: 38,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: ShapeDecoration(
                      color: Color(_isOutType ? 0xFF0083FB : 0xFFffffff),
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
                          '转出',
                          style: TextStyle(
                            color: Color(_isOutType ? 0xFFffffff : 0xFF999999),
                            fontSize: 14,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () => setState(() => _isOutType = true))
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
          Gaps.vGap30
        ]),
      );

  void _showTime(setStateDialog, bool isStart) {
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
  }

  void _save() {
    goBackLastPage(context);
    _transferList(true);
  }

  /// transferList
  void _transferList(bool isRefresh) {
    if (isRefresh) {
      _page = 1;
    }
    //	type 否	string	转账类型 1.转入 2.转出
    final data = {
      'page': _page,
      'limit': 20,
      if (_timeStartMilliseconds.isNotEmpty)
        'start_time': _timeStartMilliseconds,
      if (_timeEndMilliseconds.isNotEmpty) 'end_time': _timeEndMilliseconds,
      if (_timeStartMilliseconds.isNotEmpty && _timeEndMilliseconds.isNotEmpty)
        'type': _isOutType ? '2' : '1'
    };

    PPHttpClient().get(PpUrlConfig.transferList, data: data,
        onSuccess: (jsonMap) {
      _page++;
      final list = jsonMap['data']['data'] as List;
      if (isRefresh) {
        _list = jsonMap['data']['data'] as List;
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
