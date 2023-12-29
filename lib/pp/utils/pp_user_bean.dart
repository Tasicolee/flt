/**
 * "id": 1,
    "name": "测试昵称",
    "account": "1@gmail.com",
    "avatar": "/slls/sdflk",
    "account_balance": "59890.00",
    "account_balance_frozen": "39912.00",
    "wallet_code": "PPD92cdfcd4709edca4",
    "id_number": "",
    "email": "",
    "birthday": "",
    "register_ip": "",
    "real_name": "",
    "can_recharge": 1,
    "can_withdraw": 1,
    "is_avatar_change": 1,
    "created_at": "2023-10-16T09:50:10.000000Z",
    "updated_at": "2023-10-23T08:56:03.000000Z",
    "is_real_name": 0
 */
/**
 * 参数	类型	描述
    id	string	用户id
    name	string	昵称
    account	string	账号
    account_balance	string	用户资金
    account_balance_frozen	string	用户冻结资金
    wallet_code	string	钱包地址
    is_real_name	string	是否实名认证0否 1是
    created_at	string
    updated_at	string
 */
class PpUserEntity {
  PpUserEntity();

  String? id;

  String? name;
  String? account;
  String? avatar;
  String? account_balance;
  String? account_balance_frozen;
  String? wallet_code;
  String? id_number;
  String? email;
  String? birthday;
  String? register_ip;
  String? real_name;
  String? can_recharge;
  String? can_withdraw;
  String? is_avatar_change;
  String? created_at;
  String? updated_at;
  String? is_real_name;
}
