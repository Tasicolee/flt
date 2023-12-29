class PpUrlConfig {
  /// base url
  static const String BASE_URL = 'https://payapi.dev6688.com/';

  /// 注册验证码
  static const String captcha_image = 'api/captcha_image';

  /// 注册
  static const String register = 'api/register';

  /**
   *
   * account	是	string	账号
      password	是	string	密码
      key	是	string	验证码key，达到登录次数之后需要加验证码参数
      captch_code	是	string	图形验证码，达到登录失败次数之后需要加验证码
   */

  /// 注册
  static const String login = 'api/login';
  static const String user = 'api/user';
  static const String banner = 'api/common/banner';

  /// 获取用户账户金额信息【token】
  static const String account_info = 'api/user/account_info';
  static const String refresh_token = 'api/user/refresh_token';

  /**
   * 参数名	必选	类型	说明
      old_password	是	string	旧密码
      new_password	是	string	新密码
   */

  ///
  static const String change_password = 'api/user/change_password';
  static const String change_pay_password = 'api/user/change_pay_password';

  /**
   * 请求方式
      get
      请求Query参数
      参数名	必选	类型	说明
      page	否	string	页码
      limit	否	string	每页条数
      status	否	string	挂单状态：0.待审核,1.挂单中, 2已下架
      available_amount	否	string	可出售金额 为0为已售罄状态 其他情况不传
   */

  /// 我的挂单列表
  static const String sell_myList = 'api/transaction/sell/mylist';

  /**
      参数名	必选	类型	说明
      amount	是	string	转账金额
      recipient_wallet_code	是	string	收款钱包地址
      pay_password	是	string	支付密码
   */

  ///
  static const String transfer = 'api/transaction/transfer/transfer';

  ///contact_id	是	string	联系人id
  static const String contactAdd = 'api/contact/add';
  static const String contactList = 'api/contact/list';

  /**
   * 参数名	必选	类型	说明
      order_amount	是	int	出售数量
      account_info_types	是	int	收款类型，多个用英文逗号分割开 账户类型 (1微信, 2支付宝, 3银行卡)
      sell_type	是	int	挂单类型：0 可拆分订单，1 不可拆分订单
      split_amount	否	int	拆分金额可拆分订单最低限额：订单的最小购买金额
   */

  /// 卖币挂单接口
  static const String sellAdd = 'api/transaction/sell/add';

  /// 买币列表页接口展示挂单
  static const String sellList = 'api/transaction/sell/list';
  static const String supply = 'api/supply/index';
  static const String qiniuToken = 'api/common/qiniu/token';
  static const String authenticationAdd = 'api/authentication/add';
  static const String authenticationUpdate = 'api/authentication/update';

  /**
   * 参数名	类型	说明
      id	string	认证id
      user_id	string	用户id
      full_name	string	真实姓名
      idcard_number	string	身份证号码
      front_image_path	string	身份证正面图片路径
      back_image_path	string	身份证反面图片路径
      hold_idcard_path	string	手持身份证图片路径
      is_approved	int	是否通过审核 :0 待审核 1 审核通过 2 审核不通过
      pass_at	string	通过时间
      reject_reason	string	拒绝原因
      op_admin_id	string	后台操作用户id
   */

  /// 查看用户身份认证信息【
  static const String authenticationInfo = 'api/authentication/info';
  static const String getInfoCounts = 'api/account_info/accounts';
  static const String addInfoCard = 'api/account_info/bank_card';
  static const String addInfoZfb = 'api/account_info/alipay';
  static const String addInfoWx = 'api/account_info/weixin';

  static const String sellDetail = 'api/transaction/sell/detail';
  static const String transactionBuy = 'api/transaction/buy/add';
  static const String supplyBuy = 'api/supply/buy';
  static const String buyDetail = 'api/transaction/buy/detail';
  static const String buyOfficeDetail = 'api/supply/detail';
  static const String buyList = 'api/transaction/buy/list';
  static const String buyOfficeList = 'api/supply/list';
  static const String billList = 'api/bill/mylist';
  static const String billType = 'api/bill/get_type';
  static const String buyCancel = 'api/transaction/buy/cancel';
  static const String buyPay = 'api/transaction/buy/pay';
  static const String submit_credential_office = 'api/supply/proof';
  static const String submit_credential =
      'api/transaction/buy/submit_credential';
  static const String sellClose = 'api/transaction/sell/close';
  static const String buyAppeal = 'api/transaction/buy/appeal';
  static const String sellRelease = 'api/transaction/sell/release';
  static const String transferList = 'api/transaction/transfer/list';
  static const String version = 'api/version';
  static const String sys_config = 'api/sys_config';
  static const String payRechargeOther = 'api/transaction/pay/recharge';
  static const String payRechargeSaveOther = 'api/transaction/pay/pay_recharge';
}
