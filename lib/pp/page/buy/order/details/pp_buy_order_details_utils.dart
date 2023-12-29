import 'package:flutter/cupertino.dart';
import 'package:sp_util/sp_util.dart';

import '../../../../../res/constant.dart';
import '../../../../../res/resources.dart';
import '../../../../../widgets/load_image.dart';
import '../../../../utils/pp_navigator_utils.dart';

Column getBuyTitleMoney(_buyDetail) => Column(
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

/// 收款方式
Row getBuyPayView(payType) => Row(
      children: [
        Gaps.hGap20,
        const Expanded(
          child: SizedBox(
            child: Text(
              '收款方式',
              style: TextStyle(
                color: Color(0xFF86909C),
                fontSize: 14,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        getBuyPayType(payType),
        Images.arrowRight,
        Gaps.hGap20,
      ],
    );

///账户类型 (1微信, 2支付宝, 3银行卡)
Row getBuyPayType(payType) {
  var icon = Images.pp_card_icon_wx;
  String str = '';
  if (payType == '1') {
    str = '微信';
    icon = Images.pp_card_icon_wx;
  } else if (payType == '2') {
    str = '支付宝';
    icon = Images.pp_card_icon_zfb;
  } else if (payType == '3') {
    str = '银行卡';
    icon = Images.pp_card_icon_card;
  }
  final text = Text(
    str,
    textAlign: TextAlign.right,
    style: const TextStyle(
      color: Color(0xFF1D2129),
      fontSize: 14,
      fontFamily: 'PingFang SC',
      fontWeight: FontWeight.w500,
    ),
  );
  return Row(children: [icon, Gaps.hGap4, text]);
}

/// 出售详情 数据
Column itemBuyView(buyDetail) => Column(
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
              buyDetail == null ? '' : buyDetail['created_at'].toString(),
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
              buyDetail == null ? '' : buyDetail['seller_nickname'].toString(),
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

/// 付款类型
GestureDetector getBuyPayViewWx(BuildContext context, walletCode) {
  final String? qiniuDomain = SpUtil.getString(Constant.qiniu_domain);
  return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        goPpPhotoViewPage(context, '$qiniuDomain/$walletCode');
      },
      child: LoadImage(
        '$qiniuDomain/$walletCode',
        fit: BoxFit.fill,
        holderImg: 'pp_null_list',
      ));
}

GestureDetector getBuyPayViewZfb(BuildContext context, walletCode) =>
    getBuyPayViewWx(context, walletCode);

Column getBuyPayViewBank(paymentInfo) => Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            copyString(
              paymentInfo == null ? '' : paymentInfo['card_number'].toString(),
            );
          },
          child: Row(
            children: [
              Gaps.hGap20,
              const Expanded(
                child: SizedBox(
                  child: Text(
                    '银行卡号',
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
                paymentInfo == null
                    ? ''
                    : paymentInfo['card_number'].toString(),
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
        ),
        Gaps.vGap20,
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            copyString(
              paymentInfo == null ? '' : paymentInfo['bank_name'].toString(),
            );
          },
          child: Row(
            children: [
              Gaps.hGap20,
              const Expanded(
                child: SizedBox(
                  child: Text(
                    '开户行',
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
                paymentInfo == null ? '' : paymentInfo['bank_name'].toString(),
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
        )
      ],
    );
