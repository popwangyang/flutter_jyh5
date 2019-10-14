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
  int flag;
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
      flag: json['flag'],
      days: json['days'],
      start: json['start'],
      end: json['end']
    );
  }
}