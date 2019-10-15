import 'dart:convert';

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
  String place_contact;
  String phone_number;
  String province_code;
  String city_code;
  String county_code;
  String address;
  String opening_hours;
  BusinessHours businessHours;

  KTV({
    this.id,
    this.address,
    this.name,
    this.merchant_name,
    this.city_code,
    this.county_code,
    this.opening_hours,
    this.phone_number,
    this.place_contact,
    this.province_code,
    this.type,
    this.businessHours
  });
  
  factory KTV.fromJson(dynamic data){
    return KTV(
      id: data['id'],
      name: data['name'],
      merchant_name: data['merchant_name'],
      address: data['address'],
      province_code: data['province_code'],
      city_code: data['city_code'],
      county_code: data['county_code'],
      opening_hours: data['opening_hours'],
      phone_number: data['phone_number'],
      type: data['type'],
      place_contact: data['place_contact'],
      businessHours: BusinessHours.fromJson(json.decode(data['business_hours']))
    );
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
}

class KtvDetailModel {
  int id;
  String name;
  int type;
  String contact;
  String placeContact;
  String phoneNumber;
  String address;
  String openingHours;
  String businessHours;
  int businessState;
  double balance;
  String serialNumber;
  String provinceCode;
  String cityCode;
  String countyCode;
  int accountStatus;
  String chargeableTime;
  int merchant;
  int owenBoxCount;
  int implementBoxCount;

  KtvDetailModel(
      {this.id,
        this.name,
        this.type,
        this.contact,
        this.placeContact,
        this.phoneNumber,
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
        this.merchant,
        this.owenBoxCount,
        this.implementBoxCount});

  KtvDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    contact = json['contact'];
    placeContact = json['place_contact'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    openingHours = json['opening_hours'];
    businessHours = json['business_hours'];
    businessState = json['business_state'];
    balance = json['balance'];
    serialNumber = json['serial_number'];
    provinceCode = json['province_code'];
    cityCode = json['city_code'];
    countyCode = json['county_code'];
    accountStatus = json['account_status'];
    chargeableTime = json['chargeable_time'];
    merchant = json['merchant'];
    owenBoxCount = json['owen_box_count'];
    implementBoxCount = json['implement_box_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['contact'] = this.contact;
    data['place_contact'] = this.placeContact;
    data['phone_number'] = this.phoneNumber;
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
    data['merchant'] = this.merchant;
    data['owen_box_count'] = this.owenBoxCount;
    data['implement_box_count'] = this.implementBoxCount;
    return data;
  }
}