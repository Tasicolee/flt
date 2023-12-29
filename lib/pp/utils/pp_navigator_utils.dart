import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/pp/utils/pp_global.dart';
import 'package:flutter_deer/pp/utils/pp_view_photo_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../util/toast_utils.dart';
import '../page/bill/pp_bill_list_page.dart';
import '../page/buy/office/details/pp_office_buy_order_details_appeal.dart';
import '../page/buy/office/details/pp_office_buy_order_details_cancel.dart';
import '../page/buy/office/details/pp_office_buy_order_details_done.dart';
import '../page/buy/office/details/pp_office_buy_order_details_paid_page.dart';
import '../page/buy/office/details/pp_office_buy_order_details_upload_page.dart';
import '../page/buy/office/details/pp_office_buy_order_details_wait_page.dart';
import '../page/buy/office/details/pp_office_buy_order_details_waiting_release_page.dart';
import '../page/buy/office/list/pp_buy_office_order_list_page.dart';
import '../page/buy/office/pp_bug_office_page.dart';
import '../page/buy/order/details/pp_buy_order_details_appeal.dart';
import '../page/buy/order/details/pp_buy_order_details_cancel.dart';
import '../page/buy/order/details/pp_buy_order_details_done.dart';
import '../page/buy/order/details/pp_buy_order_details_paid_page.dart';
import '../page/buy/order/details/pp_buy_order_details_upload_page.dart';
import '../page/buy/order/details/pp_buy_order_details_wait_page.dart';
import '../page/buy/order/details/pp_buy_order_details_waiting_release_page.dart';
import '../page/buy/order/list/pp_buy_order_list_page.dart';
import '../page/buy/pp_bug_confirm_page.dart';
import '../page/buy/pp_buy_list_page.dart';
import '../page/login/pp_login_page.dart';
import '../page/mine/add/pp_add_bank_page.dart';
import '../page/mine/add/pp_add_wx_page.dart';
import '../page/mine/add/pp_add_zfb_page.dart';
import '../page/mine/add/pp_collection_management_page.dart';
import '../page/mine/pp_about_page.dart';
import '../page/mine/pp_txt_user_page.dart';
import '../page/mine/pwd/face/pp_pwd_face_modify_page.dart';
import '../page/mine/pwd/lock/pp_pwd_gesture_lock_modify_page.dart';
import '../page/mine/pwd/lock/pp_pwd_gesture_lock_page.dart';
import '../page/mine/pwd/lock/pp_pwd_gesture_lock_set_close.dart';
import '../page/mine/pwd/lock/pp_pwd_gesture_lock_set_hint_page.dart';
import '../page/mine/pwd/lock/pp_pwd_gesture_lock_set_page.dart';
import '../page/mine/pwd/modify/pp_change_login_password_page.dart';
import '../page/mine/pwd/modify/pp_change_pay_password_page.dart';
import '../page/mine/pwd/pp_set_safety_page.dart';
import '../page/mine/user/pp_auth_fail_page.dart';
import '../page/mine/user/pp_auth_success_page.dart';
import '../page/mine/user/pp_auth_wait_page.dart';
import '../page/mine/user/pp_authentication_page.dart';
import '../page/pp_home_tab_page.dart';
import '../page/pp_payment_code_page.dart';
import '../page/pp_webview_page.dart';
import '../page/sell/details/pp_sell_order_details_appeal.dart';
import '../page/sell/details/pp_sell_order_details_cancel.dart';
import '../page/sell/details/pp_sell_order_details_done.dart';
import '../page/sell/details/pp_sell_order_details_paid_page.dart';
import '../page/sell/details/pp_sell_order_details_wait_page.dart';
import '../page/sell/details/pp_sell_order_details_waiting_release_page.dart';
import '../page/sell/list/pp_pending_list_page.dart';
import '../page/sell/pp_sell_order_details_page.dart';
import '../page/sell/pp_sell_page.dart';
import '../page/transfer/history/pp_transfer_history_list_page.dart';
import '../page/transfer/pp_transfer_moeny_page.dart';
import '../page/transfer/pp_transfer_other_page.dart';
import '../page/transfer/pp_transfer_other_success_page.dart';
import '../page/transfer/pp_transfer_page.dart';

EventBus eventBus = EventBus();

void goBackLastPage(BuildContext context) => Navigator.pop(context);

/// 跳转并关闭当前页面
Future goPpLoginPage(BuildContext context) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const PpLoginPage()),
    (route) => route == null);

/// 跳转并关闭当前页面
Future goPpLoginPageSavePage(BuildContext context) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const PpLoginPage()),
        (route) => route == route);

/// 跳转并关闭当前页面
Future goPPHomeTabPage(BuildContext context,
        {required bool isRefresh, required bool needPwd}) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => PPHomeTabPage(
                  isRefresh: isRefresh,
                  needPwdLock: needPwd,
                )),
        (route) => route == null);

Future goPPHomeTabPageFast(BuildContext context,
        {required bool isRefresh, required bool needPwd}) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => PPHomeTabPage(
                  isRefresh: isRefresh,
                  needPwdLock: needPwd,
                )),
        (route) => route == null);

Future goPpUserTxtPage(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => const PpUserTxtPage()));

Future goPpPhotoViewPage(BuildContext context, String url) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => PpPhotoViewPage(url)));

Future<void> launchPpURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    Toast.show('地址错误');
  }
}

void goWeb(BuildContext context, String? url) {
  if (url?.isNotEmpty == true && url != 'null') {
    if (isPpWeb()) {
      launchPpURL(url!);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => PpWebViewPage(title: '网页', url: url.toString())));
    }
  } else {
    Toast.show('地址错误');
  }
}

void goKf(BuildContext context) {
  debugPrint('------$customerServiceAddress');
  if (customerServiceAddress?.isNotEmpty == true &&
      customerServiceAddress != 'null') {
    if (isPpWeb()) {
      launchPpURL(customerServiceAddress!);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => PpWebViewPage(
                  title: '在线客服', url: customerServiceAddress.toString())));
    }
  } else {
    Toast.show('客服地址错误');
  }
}

Future goPpTransferPage(BuildContext context) => Navigator.push(context,
    MaterialPageRoute(builder: (_) => PpTransferPage(wallet_code: '')));

Future goPpChangeLoginPasswordPage(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const PpChangeLoginPasswordPage()));

Future goPpChangePayPasswordPage(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const PpChangePayPasswordPage()));

Future goPpPwdLockGestureSetHintPage(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const PpPwdLockGestureSetHintPage()));

Future goPpPwdLockModifyPage(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => const PpPwdLockModifyPage()));

Future goPpBugConfirmPage(BuildContext context, String sellOrdersId) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PpBugConfirmPage(sellOrdersId: sellOrdersId)));

Future goPpBugOfficePage(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => PpBugOfficePage()));

Future goPpTransferPageCode(BuildContext context, String walletCode) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PpTransferPage(wallet_code: walletCode)));

Future goPpTransferOtherPage(BuildContext context, String walletCode) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                PpTransferOtherPage(platform_order_no: walletCode)));

Future goPpTransferMoneyPage(
    BuildContext context, String walletCode, bool showAdd) {
  return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) =>
              PpTransferMoneyPage(walletCode: walletCode, showAdd: showAdd)));
}

Future goPpPaymentCodePage(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => const PpPaymentCodePage()));

Future goPpTransferHistoryListPage(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const PpTransferHistoryListPage()));

Future goPpPendingListPage(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => const PpPendingListPage()));

Future goPpBuyOrderListPage(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => const PpBuyOrderListPage()));

Future goPpBuyOfficeOrderListPage(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const PpBuyOfficeOrderListPage()));

Future goPpCollectionManagementPage(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const PpCollectionManagementPage()));

Future goPpSellOrderDetailsPage(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => const PpSellOrderDetailsPage()));

/// 复制内容
Future<void> copyString(String? text) async {
  Clipboard.setData(ClipboardData(text: text ?? ''));
  Toast.show('复制成功');
}

Future goPpSellPage(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => const PpSellPage()));

Future goPpPwdLockGestureClosePage(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const PpPwdLockGestureClosePage()));

Future goPpBillListPage(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => const PpBillListPage()));

Future goPpSafetyPage(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => const PpSafetyPage()));

Future goPpPwdLockGesturePage(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => const PpPwdLockGesturePage()));

Future goPpPwdLockGestureSetPage(BuildContext context, String title) =>
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => PpPwdLockGestureSetPage(title)));

Future goPpPwdFaceModifyPage(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => const PpPwdFaceModifyPage()));

Future goPpAboutPage(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => const PpAboutPage()));

Future goPpAddZfbPage(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => const PpAddZfbPage()));

Future goPpAddWxPage(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => const PpAddWxPage()));

Future goPpAddBankPage(BuildContext context) =>
    Navigator.push(context, MaterialPageRoute(builder: (_) => PpAddBankPage()));

Future goPpBuyMyListPage(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => const PpBuyMyListPage()));

Future goPpBuyOrderDetailsWaitPage(BuildContext context,
        {required String order_id}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PpBuyOrderDetailsWaitPage(order_id: order_id)));

Future goPpBuyOrderDetailsPaidPage(BuildContext context,
        {required String order_id}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PpBuyOrderDetailsPaidPage(order_id: order_id)));

Future goPpOfficeBuyOrderDetailsPaidPage(BuildContext context,
        {required String order_id}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                PpOfficeBuyOrderDetailsPaidPage(order_id: order_id)));

Future goPpOfficeBuyOrderDetailsWaitingReleasePage(BuildContext context,
        {required String order_id}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                PpOfficeBuyOrderDetailsWaitingReleasePage(order_id: order_id)));

Future goPpOfficeBuyOrderDetailsDonePage(BuildContext context,
        {required String order_id}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                PpOfficeBuyOrderDetailsDonePage(order_id: order_id)));

Future goPpOfficeBuyOrderDetailsCancelPage(BuildContext context,
        {required String order_id}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                PpOfficeBuyOrderDetailsCancelPage(order_id: order_id)));

Future goPpOfficeBuyOrderDetailsAppealPage(BuildContext context,
        {required String order_id}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                PpOfficeBuyOrderDetailsAppealPage(order_id: order_id)));

Future goPpOfficeBuyOrderDetailsUploadPage(BuildContext context,
        {required String order_id}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                PpOfficeBuyOrderDetailsUploadPage(order_id: order_id)));

Future goPpBuyOrderDetailsUploadPage(BuildContext context,
        {required String order_id}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PpBuyOrderDetailsUploadPage(order_id: order_id)));

Future goPpBuyOrderDetailsWaitingReleasePage(BuildContext context,
        {required String order_id}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                PpBuyOrderDetailsWaitingReleasePage(order_id: order_id)));

Future goPpBuyOrderDetailsCancelPage(BuildContext context,
        {required String order_id}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PpBuyOrderDetailsCancelPage(order_id: order_id)));

Future goPpBuyOrderDetailsDonePage(BuildContext context,
        {required String order_id}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PpBuyOrderDetailsDonePage(order_id: order_id)));

Future goPpBuyOrderDetailsAppealPage(BuildContext context,
        {required String order_id}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PpBuyOrderDetailsAppealPage(order_id: order_id)));

/// 出售
Future goPpSellOrderDetailsWaitPage(BuildContext context,
        {required String order_id}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PpSellOrderDetailsWaitPage(order_id: order_id)));

/// 出售
Future goPpSellOrderDetailsPaidPage(BuildContext context,
        {required String order_id}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PpSellOrderDetailsPaidPage(order_id: order_id)));

/// 出售
Future goPpSellOrderDetailsWaitingReleasePage(BuildContext context,
        {required String order_id}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                PpSellOrderDetailsWaitingReleasePage(order_id: order_id)));

/// 出售
Future goPpSellOrderDetailsDonePage(BuildContext context,
        {required String order_id}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PpSellOrderDetailsDonePage(order_id: order_id)));

/// 出售
Future goPpSellOrderDetailsCancelPage(BuildContext context,
        {required String order_id}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PpSellOrderDetailsCancelPage(order_id: order_id)));

/// 出售
Future goPpSellOrderDetailsAppealPage(BuildContext context,
        {required String order_id}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PpSellOrderDetailsAppealPage(order_id: order_id)));

Future goPpAuthenticationPage(BuildContext context, bool isAgain) =>
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => PpAuthenticationPage(isAgain)));

Future goPpAuthSuccessPage(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => const PpAuthSuccessPage()));

Future goPpAuthWaitPage(BuildContext context) => Navigator.push(
    context, MaterialPageRoute(builder: (_) => const PpAuthWaitPage()));

Future goPpAuthFailPage(BuildContext context, String rejectReason) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PpAuthFailPage(reject_reason: rejectReason)));

Future goPpTransferOtherSuccessPage(BuildContext context, String amount) {
  //跳转并关闭当前页面
  return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => PpTransferOtherSuccessPage(
                amount: amount,
              )),
      (route) => route == null);
}

Future goPpOfficeBuyOrderDetailsWaitPage(BuildContext context,
        {required String order_id}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                PpOfficeBuyOrderDetailsWaitPage(order_id: order_id)));
