import 'package:flutter/material.dart';
import 'package:flutter_deer/pp/page/buy/order/list/pp_buy_order_item_page.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/theme_utils.dart';

/// 订单记录-购买
class PpBuyOrderListPage extends StatefulWidget {
  const PpBuyOrderListPage({super.key});

  @override
  _GoodsPageState createState() => _GoodsPageState();
}

class _GoodsPageState extends State<PpBuyOrderListPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? _tabController;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  /// https://github.com/flutter/flutter/issues/72908
  @override
  // ignore: must_call_super
  void didChangeDependencies() {}

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colours.app_main_bg,
      appBar: AppBar(
        systemOverlayStyle: ThemeUtils.appSystemUiOverlayStyle(),
        backgroundColor: Colours.app_main_bg,
        centerTitle: true,
        title: const Text('订单记录', style: TextStyles.txt18color000000),
        elevation: 0,
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Images.pp_back_top_left_page,
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            // 隐藏点击效果
            child: TabBar(
              onTap: (index) {
                if (!mounted) {
                  return;
                }
                _pageController.jumpToPage(index);
              },
              isScrollable: true,
              controller: _tabController,
              labelStyle: const TextStyle(
                color: Color(0xFF4E5969),
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
              indicatorColor: const Color(0xFF0083FB),
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: const EdgeInsets.only(left: 20, right: 20),
              unselectedLabelColor: Colours.text,
              labelColor: const Color(0xFF0083FB),
              indicatorPadding: const EdgeInsets.only(left: 1, right: 1),
              tabs: const <Widget>[
                _TabView('全部'),
                _TabView('进行中'),
                _TabView('已完成'),
                _TabView('已取消'),
                _TabView('已申诉'),
              ],
            ),
          ),
          Gaps.lineF5F5F5,
          Expanded(
            child: PageView.builder(
                key: const Key('pageView'),
                itemCount: 5,
                onPageChanged: _onPageChange,
                controller: _pageController,
                itemBuilder: (_, int index) =>
                    PpBuyOrderItemPage(index: index)),
          )
        ],
      ));

  void _onPageChange(int index) {
    _tabController?.animateTo(index);
  }

  @override
  bool get wantKeepAlive => true;
}

class _TabView extends StatelessWidget {
  const _TabView(this.tabName);

  final String tabName;

  @override
  Widget build(BuildContext context) => Tab(
        child: SizedBox(
          child: Row(children: <Widget>[Text(tabName)]),
        ),
      );
}
