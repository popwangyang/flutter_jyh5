import 'dart:convert' as util;
import 'package:jy_h5/libs/utils.dart';
import 'dart:io';

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

class UploadToken{
  String credential;
  String key;

  UploadToken({
    this.key,
    this.credential,
  });

  factory UploadToken.fromJson(dynamic json){
    return UploadToken(
      credential: json['credential'],
      key: json['key'],
    );
  }
}


// 上传成功的返回值
class UploadResult {
  String format;
  int id;
  String key;
  String name;
  dynamic size;
  File file;
  String downloadUrl;

  UploadResult(
      {this.format,
        this.id,
        this.key,
        this.name,
        this.file,
        this.downloadUrl,
        this.size});

  UploadResult.fromJson(Map<String, dynamic> json) {
    format = json['format'];
    id = json['id'];
    key = json['key'];
    name = json['name'];
    size = json['size'];
    file = json['file'];
    downloadUrl = json['download_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['format'] = this.format;
    data['id'] = this.id;
    data['key'] = this.key;
    data['name'] = this.name;
    data['size'] = this.size;
    data['file'] = this.file;
    data['download_url'] = this.downloadUrl;
    return data;
  }

  @override
  bool operator ==(other) {
    return this.id == other.id;
  }
}

// 企业信息
class Enterprise {
  String legalRepresentativeCard;
  String licenseNumber;
  String companyName;
  UploadResult licensePhoto;
  String legalRepresentative;
  UploadResult identityCardPhoto;
  int id;

  Enterprise(
      {this.legalRepresentativeCard,
        this.licenseNumber,
        this.companyName,
        this.licensePhoto,
        this.legalRepresentative,
        this.identityCardPhoto,
        this.id});

  Enterprise.fromJson(Map<String, dynamic> json) {
    legalRepresentativeCard = json['legal_representative_card'];
    licenseNumber = json['license_number'];
    companyName = json['company_name'];
    licensePhoto = json['license_photo'] != null ? UploadResult.fromJson(json['license_photo']):null;
    legalRepresentative = json['legal_representative'];
    identityCardPhoto = json['identity_card_photo'] != null ? UploadResult.fromJson(json['identity_card_photo']):null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['legal_representative_card'] = this.legalRepresentativeCard;
    data['license_number'] = this.licenseNumber;
    data['company_name'] = this.companyName;
    data['license_photo'] = this.licensePhoto;
    data['legal_representative'] = this.legalRepresentative;
    data['identity_card_photo'] = this.identityCardPhoto;
    data['id'] = this.id;
    return data;
  }
}

// 实施信息
class Implement {
  int id;
  String vodKtvId;
  String vodVersion;
  String implementBoxCount;
  String brand;
  String createDate;
  String updateDate;
  int ktv;
  String acronym;

  Implement(
      {this.id,
        this.vodKtvId,
        this.vodVersion,
        this.implementBoxCount,
        this.brand,
        this.createDate,
        this.updateDate,
        this.ktv,
        this.acronym});

  Implement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vodKtvId = json['vod_ktv_id'];
    vodVersion = json['vod_version'];
    implementBoxCount = json['implement_box_count'].toString();
    brand = json['brand'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    ktv = json['ktv'];
    acronym = json['acronym'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vod_ktv_id'] = this.vodKtvId;
    data['vod_version'] = this.vodVersion;
    data['implement_box_count'] = this.implementBoxCount;
    data['brand'] = this.brand;
    data['create_date'] = this.createDate;
    data['update_date'] = this.updateDate;
    data['ktv'] = this.ktv;
    data['acronym'] = this.acronym;
    return data;
  }
}

// vod升级记录
class VodUpgradeRecord {
  String originalVersion;
  int id;
  String newVersion;
  int vodKtv;
  String createDate;
  String updateDate;

  VodUpgradeRecord(
      {this.originalVersion,
        this.id,
        this.newVersion,
        this.vodKtv,
        this.createDate,
        this.updateDate});

  VodUpgradeRecord.fromJson(Map<String, dynamic> json) {
    originalVersion = json['original_version'];
    id = json['id'];
    newVersion = json['new_version'];
    vodKtv = json['vod_ktv'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['original_version'] = this.originalVersion;
    data['id'] = this.id;
    data['new_version'] = this.newVersion;
    data['vod_ktv'] = this.vodKtv;
    data['create_date'] = this.createDate;
    data['update_date'] = this.updateDate;
    return data;
  }
}