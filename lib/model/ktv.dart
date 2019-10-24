import 'dart:convert' as util;
import 'package:jy_h5/libs/utils.dart';

class KtvList {
  List<KTV> data;

  KtvList(this.data);

  factory KtvList.fromJson(List data){
    return KtvList(
        data.map((i) => KTV.fromJson(i)).toList()
    );
  }
}

class KTV {
  int id;
  int type;
  String name;
  String merchant_name;

  KTV({
    this.id,
    this.name,
    this.merchant_name,
    this.type,
  });
  
  factory KTV.fromJson(dynamic data){
    return KTV(
      id: data['id'],
      name: data['name'],
      merchant_name: data['merchant_name'],
      type: data['type']
    );
  }

}



class KtvDetailModel {
  int id;  // ktv id
  String name;  // ktv 名称
  int type;  // ktv 类型（量贩， 夜店）
  String contact; // ktv 管理人员
  String placeContact; // ktv 场所电话
  String phoneNumber;  // ktv 管理人员电话
  String province;
  String city;
  String county;
  String address;
  String openingHours;
  BusinessHours businessHours;
  int businessState;
  String balance;  // 账户余额
  String serialNumber;
  String provinceCode;
  String cityCode;
  String countyCode;
  int accountStatus;
  Null chargeableTime;
  String merchantName;
  int implementState;
  int owenBoxCount;
  int implementBoxCount;
  String detailAddress;

  KtvDetailModel(
      {this.id,
        this.name,
        this.type,
        this.contact,
        this.placeContact,
        this.phoneNumber,
        this.province,
        this.city,
        this.county,
        this.address,
        this.openingHours,
        this.businessHours,
        this.businessState,
        this.balance,
        this.serialNumber,
        this.provinceCode,
        this.cityCode,
        this.countyCode,
        this.accountStatus,
        this.chargeableTime,
        this.merchantName,
        this.implementState,
        this.owenBoxCount,
        this.detailAddress,
        this.implementBoxCount});

  KtvDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    contact = json['contact'];
    placeContact = json['place_contact'];
    phoneNumber = json['phone_number'];
    province = json['province'];
    city = json['city'];
    county = json['county'];
    address = json['address'];
    openingHours = json['opening_hours'];
    businessHours = BusinessHours.fromJson(util.json.decode(json['business_hours']));
    businessState = json['business_state'];
    balance = json['balance'];
    serialNumber = json['serial_number'];
    provinceCode = json['province_code'];
    cityCode = json['city_code'];
    countyCode = json['county_code'];
    accountStatus = json['account_status'];
    chargeableTime = json['chargeable_time'];
    merchantName = json['merchant_name'];
    implementState = json['implement_state'];
    owenBoxCount = json['owen_box_count'];
    implementBoxCount = json['implement_box_count'];
    detailAddress = "${json['province']},${json['city']},${json['county']},${json['address']}";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['contact'] = this.contact;
    data['place_contact'] = this.placeContact;
    data['phone_number'] = this.phoneNumber;
    data['province'] = this.province;
    data['city'] = this.city;
    data['county'] = this.county;
    data['address'] = this.address;
    data['opening_hours'] = this.openingHours;
    data['business_hours'] = this.businessHours;
    data['business_state'] = this.businessState;
    data['balance'] = this.balance;
    data['serial_number'] = this.serialNumber;
    data['province_code'] = this.provinceCode;
    data['city_code'] = this.cityCode;
    data['county_code'] = this.countyCode;
    data['account_status'] = this.accountStatus;
    data['chargeable_time'] = this.chargeableTime;
    data['merchant_name'] = this.merchantName;
    data['implement_state'] = this.implementState;
    data['owen_box_count'] = this.owenBoxCount;
    data['implement_box_count'] = this.implementBoxCount;
    data['detailAddress'] = this.detailAddress;
    return data;
  }
}

class BusinessHours {
  String flag;
  List days;
  String start;
  String end;

  BusinessHours({
    this.days,
    this.end,
    this.flag,
    this.start,
  });

  factory BusinessHours.fromJson(dynamic json){
    return BusinessHours(
        flag: json['flag'].toString(),
        days: json['days'],
        start: json['start'],
        end: json['end']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['days'] = this.days;
    data['end'] = this.end;
    data['flag'] = this.flag;
    data['start'] = this.start;
    return data;
  }

  @override
  String toString(){
    String result;
    if(this.flag == '0'){
      result = "全部时间段";
    }else{
      String days = '';
      for(var i = 0; i < this.days.length; i++){
        days += Utils.weekChang(this.days[i])+" , ";
      }
      days = days.substring(0, days.length -2);
      result = "${this.start}~${this.end}  $days";
    }
    return result;
  }
}