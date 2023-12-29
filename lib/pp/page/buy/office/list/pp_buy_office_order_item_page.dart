import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/page/buy/office/list/pp_buy_office_order_item.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/toast_utils.dart';
import 'package:flutter_deer/widgets/my_refresh_list.dart';
import 'package:flutter_deer/widgets/state_layout.dart';

import '../../../../dio/pp_httpclient.dart';
import '../../../../dio/pp_url_config.dart';
import '../../../../utils/pp_navigator_utils.dart';

///订单记录-购买
class PpBuyOfficeOrderItemPage extends StatefulWidget {
  const PpBuyOfficeOrderItemPage({super.key, required this.index});

  final int index;

  @override
  _PpBuyOrderItemPageState createState() =>
      _PpBuyOrderItemPageState(order_status: _orderStatus());

  ///   int	订单状态 23.进行中，4.已完成，57.失败 全部状态的不需要传
  int _orderStatus() {
    var orderStatus = 0;
    if (index == 0) {
      orderStatus = -1;
    } else if (index == 1) {
      orderStatus = 23;
    } else if (index == 2) {
      orderStatus = 4;
    } else if (index == 3) {
      orderStatus = 57;
    }
    return orderStatus;
  }
}

class _PpBuyOrderItemPageState extends State<PpBuyOfficeOrderItemPage>
    with
        AutomaticKeepAliveClientMixin<PpBuyOfficeOrderItemPage>,
        SingleTickerProviderStateMixin {
  _PpBuyOrderItemPageState({required this.order_status});

  final int order_status;

  late AnimationController _controller;
  List _list = [];

  @override
  void initState() {
    super.initState();
    // 初始化动画控制
    _controller = AnimationController(
        duration: const Duration(milliseconds: 450), vsync: this);

    _onRefresh();
    eventBus.on<PpBuyOfficeOrderItemPage>().listen((event) {
      _onRefresh();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<dynamic> _onRefresh() async => _buyList(order_status, true);

  Future<dynamic> _loadMore() async => _buyList(order_status, false);

  int _page = 1;

  // late int _maxPage;
  StateType _stateType = StateType.loading;
  bool _hasMore = true;

  @override
  Widget build(BuildContext context) => _list.isNotEmpty
      ? DeerListView(
          itemCount: _list.length,
          stateType: _stateType,
          onRefresh: _onRefresh,
          loadMore: _loadMore,
          hasMore: _hasMore,
          itemBuilder: (_, index) =>
              PpBuyOfficeListItemPage(item: _list[index]))
      : Images.pp_null_list_view;

  @override
  bool get wantKeepAlive => true;

  /**
   * page	是	string	页码
      limit	是	string	每页条数
      order_status	否
      int	订单状态 23.进行中，4.已完成，57.失败 全部状态的不需要传
   */

  ///
  void _buyList(int orderStatus, bool isRefresh) {
    if (isRefresh) {
      _page = 1;
    }
    var data = {'page': _page};
    if (orderStatus == -1) {
      data = {'page': _page, 'limit': 20};
    } else {
      data = {'page': _page, 'limit': 20, 'order_status': orderStatus};
    }

    PPHttpClient().get(PpUrlConfig.buyOfficeList, data: data,
        onSuccess: (jsonMap) {
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