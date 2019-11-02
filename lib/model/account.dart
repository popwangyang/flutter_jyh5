
class AccountDetail {
  int id;
  String code;
  String nickname;
  String username;
  String email;
  bool isSuperuser;
  bool isActive;
  int isAgreed;
  Brand brand;
  String phone;
  int gender;
  int jobState;
  bool isAllArea;
  int ktvId;
  Null merchantId;
  Null rightId;
  Null lastLoginDate;
  String createDate;
  String updateDate;
  String codeShow;

  AccountDetail(
      {this.id,
        this.code,
        this.nickname,
        this.username,
        this.email,
        this.isSuperuser,
        this.isActive,
        this.isAgreed,
        this.brand,
        this.phone,
        this.gender,
        this.jobState,
        this.isAllArea,
        this.ktvId,
        this.merchantId,
        this.rightId,
        this.lastLoginDate,
        this.createDate,
        this.updateDate,
        this.codeShow});

  AccountDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    nickname = json['nickname'];
    username = json['username'];
    email = json['email'];
    isSuperuser = json['is_superuser'];
    isActive = json['is_active'];
    isAgreed = json['is_agreed'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    phone = json['phone'];
    gender = json['gender'];
    jobState = json['job_state'];
    isAllArea = json['is_all_area'];
    ktvId = json['ktv_id'];
    merchantId = json['merchant_id'];
    rightId = json['right_id'];
    lastLoginDate = json['last_login_date'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    codeShow = json['code_show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['nickname'] = this.nickname;
    data['username'] = this.username;
    data['email'] = this.email;
    data['is_superuser'] = this.isSuperuser;
    data['is_active'] = this.isActive;
    data['is_agreed'] = this.isAgreed;
    if (this.brand != null) {
      data['brand'] = this.brand.toJson();
    }
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['job_state'] = this.jobState;
    data['is_all_area'] = this.isAllArea;
    data['ktv_id'] = this.ktvId;
    data['merchant_id'] = this.merchantId;
    data['right_id'] = this.rightId;
    data['last_login_date'] = this.lastLoginDate;
    data['create_date'] = this.createDate;
    data['update_date'] = this.updateDate;
    data['code_show'] = this.codeShow;
    return data;
  }
}

class Brand {
  int id;
  String name;
  int logo01;
  int logo02;
  String wxPublicId;
  int wxPublicQrCode;
  String wxUuid;

  Brand(
      {this.id,
        this.name,
        this.logo01,
        this.logo02,
        this.wxPublicId,
        this.wxPublicQrCode,
        this.wxUuid});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo01 = json['logo_01'];
    logo02 = json['logo_02'];
    wxPublicId = json['wx_public_id'];
    wxPublicQrCode = json['wx_public_qr_code'];
    wxUuid = json['wx_uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo_01'] = this.logo01;
    data['logo_02'] = this.logo02;
    data['wx_public_id'] = this.wxPublicId;
    data['wx_public_qr_code'] = this.wxPublicQrCode;
    data['wx_uuid'] = this.wxUuid;
    return data;
  }
}