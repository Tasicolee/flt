import 'package:flutter/cupertino.dart';

import '../../../../res/resources.dart';
import '../../../utils/pp_navigator_utils.dart';

Column getSellTitleMoney(_buyDetail) => Column(
      children: [
        Gaps.vGap10,
        Text(
          _buyDetail == null ? '' : '${_buyDetail['transaction_amount']}币',
          style: const TextStyle(
            color: Color(0xFF1D1D21),
            fontSize: 28,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w500,
          ),
        ),
        Gaps.vGap10,
        Text(
          _buyDetail == null ? '' : '¥${_buyDetail['pay_amount']}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF9194A6),
            fontSize: 14,
            fontFamily: 'PingFang HK',
            fontWeight: FontWeight.w400,
          ),
        ),
        Gaps.vGap10,
        Gaps.lineF6F6F6,
        Gaps.vGap10,
      ],
    );

/// 出售详情 数据
Column itemSellView(buyDetail) => Column(
      children: [
        Row(
          children: [
            Gaps.hGap20,
            const Expanded(
              child: SizedBox(
                child: Text(
                  '下单时间',
                  style: TextStyle(
                    color: Color(0xFF86909C),
                    fontSize: 14,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Text(
              buyDetail == null ? '' : '${buyDetail['created_at'].toString()}',
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF1D2129),
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
            Gaps.hGap20,
          ],
        ),
        Gaps.vGap20,
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Gaps.hGap20,
              const Expanded(
                child: SizedBox(
                  child: Text(
                    '订单号',
                    style: TextStyle(
                      color: Color(0xFF86909C),
                      fontSize: 14,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Text(
                buyDetail == null ? '' : buyDetail['order_number'].toString(),
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Color(0xFF1D2129),
                  fontSize: 14,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gaps.hGap1,
              Images.pp_home_copy_grey,
              Gaps.hGap20,
            ],
          ),
          onTap: () => copyString(
              buyDetail == null ? '' : buyDetail['order_number'].toString()),
        ),
        Gaps.vGap20,
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Gaps.hGap20,
              const Expanded(
                child: SizedBox(
                  child: Text(
                    '付款参考号',
                    style: TextStyle(
                      color: Color(0xFF86909C),
                      fontSize: 14,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Text(
                buyDetail == null ? '' : buyDetail['ref_number'].toString(),
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Color(0xFF1D2129),
                  fontSize: 14,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gaps.hGap1,
              Images.pp_home_copy_grey,
              Gaps.hGap20,
            ],
          ),
          onTap: () => copyString(
              buyDetail == null ? '' : buyDetail['ref_number'].toString()),
        ),
        Gaps.vGap20,
        Row(
          children: [
            Gaps.hGap20,
            const Expanded(
              child: SizedBox(
                child: Text(
                  '卖家昵称',
                  style: TextStyle(
                    color: Color(0xFF86909C),
                    fontSize: 14,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Text(
              buyDetail == null
                  ? ''
                  : '${buyDetail['buyer_nickname'].toString()}',
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF1D2129),
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
            Gaps.hGap20,
          ],
        ),
        Gaps.vGap20,
        Row(
          children: [
            Gaps.hGap20,
            const Expanded(
              child: SizedBox(
                child: Text(
                  '收款人',
                  style: TextStyle(
                    color: Color(0xFF86909C),
                    fontSize: 14,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Text(
              buyDetail == null ? '' : '${buyDetail['buyer_name'].toString()}',
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF1D2129),
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
            Gaps.hGap20,
          ],
        ),
        Gaps.vGap20,
      ],
    );
