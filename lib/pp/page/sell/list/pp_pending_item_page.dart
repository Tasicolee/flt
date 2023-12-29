import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/page/sell/list/pp_pending_item.dart';
import 'package:flutter_deer/util/toast_utils.dart';
import 'package:flutter_deer/widgets/my_refresh_list.dart';
import 'package:flutter_deer/widgets/state_layout.dart';

import '../../../../res/resources.dart';
import '../../../dio/pp_httpclient.dart';
import '../../../dio/pp_url_config.dart';

///我的挂单
class PpPendingItemPage extends StatefulWidget {
  const PpPendingItemPage({super.key, required this.index});

  final int index;

  /**
   * 参数名	必选	类型	说明
      page	否	string	页码
      limit	否	string	每页条数
      status	否	string	挂单状态：0.待审核,1.挂单中, 2已下架
      available_amount	否	string	可出售金额 为0为已售罄状态 其他情况不传
   */
  @override
  _PpBuyOrderItemPageState createState() {
    return _PpBuyOrderItemPageState(order_status: _orderStatus());
  }

  int _orderStatus() {
    var orderStatus = 0;
    if (index == 0) {
      orderStatus = -1;
    } else if (index == 1) {
      orderStatus = 1;
    } else if (index == 2) {
      orderStatus = -2;
    } else if (index == 3) {
      orderStatus = 2;
    } else if (index == 4) {
      orderStatus = 0;
    }
    return orderStatus;
  }
}

class _PpBuyOrderItemPageState extends State<PpPendingItemPage>
    with
        AutomaticKeepAliveClientMixin<PpPendingItemPage>,
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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<dynamic> _onRefresh() async => _getList(order_status, true);

  Future<dynamic> _loadMore() async => _getList(order_status, false);

  int _page = 1;
  bool _hasMore = true;

  final StateType _stateType = StateType.loading;

  @override
  Widget build(BuildContext context) => _list.isNotEmpty
      ? DeerListView(
          itemCount: _list.length,
          stateType: _stateType,
          onRefresh: _onRefresh,
          loadMore: _loadMore,
          hasMore: _hasMore,
          itemBuilder: (_, index) =>
              PpPendingListItemPage(item: _list[index], isHome: false))
      : Images.pp_null_list_view;

  @override
  bool get wantKeepAlive => true;

  /**
   * 参数名	必选	类型	说明
      page	否	string	页码
      limit	否	string	每页条数
      status	否	string	挂单状态：0.待审核,1.挂单中, 2已下架
      available_amount	否	string	可出售金额 为0为已售罄状态 其他情况不传

   */

  ///
  void _getList(int orderStatus, bool isRefresh) {
    if (isRefresh) {
      _page = 1;
    }
    var data = {'page': _page};
    if (orderStatus == -1) {
      data = {'page': _page, 'limit': 20};
    } else if (orderStatus == -2) {
      data = {'page': _page, 'limit': 20, 'available_amount': 0};
    } else {
      data = {'page': _page, 'limit': 20, 'status': orderStatus};
    }

    PPHttpClient().get(PpUrlConfig.sell_myList, data: data,
        onSuccess: (jsonMap) {
      _page++;
      final list = jsonMap['data']['data'] as List;
      _hasMore = list.length == 20;
      if (isRefresh) {
        _list = list;
      } else {
        _list.addAll(list);
      }
      setState(() {});
    }, onError: (code, msg) {
      Toast.show(msg + code);
    });
  }
}
