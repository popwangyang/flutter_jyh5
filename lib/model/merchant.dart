import 'ktv.dart';
// 商户模型

class Merchant {
  String name;  // 商户名称
  int id;  // 商户id
  String createDate; // 商户创建时间
  String serialNumber;  // 商户编号
  int merchantAmount;  // 商户场所数量

  Merchant({
    this.name,
    this.id,
    this.createDate,
    this.merchantAmount,
    this.serialNumber
  });

  factory Merchant.fromJson(dynamic json){
    return Merchant(
      name: json['name'],
      id: json['id'],
      createDate: json['create_date'],
      merchantAmount: json['merchant_amount'],
      serialNumber: json['serial_number']
    );
  }
}

// 商户列表

class MerchantList {

  List<Merchant> data;

  MerchantList(this.data);

  factory MerchantList.fromJson(List json){

    return MerchantList(
       json.map((i) => Merchant.fromJson(i)).toList()
    );
  }

}

// 商户详情模型
class MerchantDetailModel {
  int merchantID;
  int id;
  String name;
  String phone;
  String brandName;
  String email;
  bool accountStatues;
  String createDate;
  List ktvList;

  MerchantDetailModel({
    this.ktvList,
    this.accountStatues,
    this.brandName,
    this.createDate,
    this.email,
    this.merchantID,
    this.id,
    this.phone,
    this.name
  });

  factory MerchantDetailModel.fromJson(dynamic json){
    return MerchantDetailModel(
      name: json['name'],
      id: json['id'],
      merchantID: json['acc']['id'],
      phone: json['acc']['phone'],
      brandName: json['acc']['brand'] == null ? '暂无':json['acc']['brand']['name'],
      email: json['acc']['email'],
      accountStatues: json['acc']['is_active'],
      createDate: json['acc']['create_date'],
      ktvList: json['ktv_list'].map((i) => KTV.fromJson(i)).toList()
    );
  }

}
