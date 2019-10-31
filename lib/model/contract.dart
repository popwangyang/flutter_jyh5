
import 'ktv.dart';


class ContractDetail {
  int id;
  String number;
  List<UploadResult> annex;
  String beginDate;
  dynamic endDate;
  String bankUserName;
  String bankName;
  String bankAccount;
  String taxNumber;
  int state;
  int ktv;
  String deductionTime;
  ChargeManage chargeManage;
  String createDate;
  String updateDate;
  dynamic terminalTime;
  String packageName;
  int boxCount;
  String packageId;
  int initBoxCount;
  Null chargeableTime;
  String packageType;

  ContractDetail(
      {this.id,
        this.number,
        this.annex,
        this.beginDate,
        this.endDate,
        this.bankUserName,
        this.bankName,
        this.bankAccount,
        this.taxNumber,
        this.state,
        this.ktv,
        this.deductionTime,
        this.chargeManage,
        this.createDate,
        this.updateDate,
        this.terminalTime,
        this.packageName,
        this.boxCount,
        this.packageId,
        this.initBoxCount,
        this.chargeableTime,
        this.packageType});

  ContractDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    if (json['annex'] != null) {
      annex = new List<UploadResult>();
      json['annex'].forEach((v) {
        annex.add(new UploadResult.fromJson(v));
      });
    }
    beginDate = json['begin_date'];
    endDate = json['end_date'];
    bankUserName = json['bank_user_name'];
    bankName = json['bank_name'];
    bankAccount = json['bank_account'];
    taxNumber = json['tax_number'];
    state = json['state'];
    ktv = json['ktv'];
    deductionTime = json['deduction_time'];
    chargeManage = json['charge_manage'] != null
        ? new ChargeManage.fromJson(json['charge_manage'])
        : null;
    createDate = json['create_date'];
    updateDate = json['update_date'];
    terminalTime = json['terminal_time'];
    packageName = json['package_name'];
    boxCount = json['box_count'];
    packageId = json['package_id'];
    initBoxCount = json['init_box_count'];
    chargeableTime = json['chargeable_time'];
    packageType = json['package_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    if (this.annex != null) {
      data['annex'] = this.annex.map((v) => v.toJson()).toList();
    }
    data['begin_date'] = this.beginDate;
    data['end_date'] = this.endDate;
    data['bank_user_name'] = this.bankUserName;
    data['bank_name'] = this.bankName;
    data['bank_account'] = this.bankAccount;
    data['tax_number'] = this.taxNumber;
    data['state'] = this.state;
    data['ktv'] = this.ktv;
    data['deduction_time'] = this.deductionTime;
    if (this.chargeManage != null) {
      data['charge_manage'] = this.chargeManage.toJson();
    }
    data['create_date'] = this.createDate;
    data['update_date'] = this.updateDate;
    data['terminal_time'] = this.terminalTime;
    data['package_name'] = this.packageName;
    data['box_count'] = this.boxCount;
    data['package_id'] = this.packageId;
    data['init_box_count'] = this.initBoxCount;
    data['chargeable_time'] = this.chargeableTime;
    data['package_type'] = this.packageType;
    return data;
  }
}

class ChargeManage {
  int id;
  int ktv;
  int contract;
  int state;
  int package;

  ChargeManage({this.id, this.ktv, this.contract, this.state, this.package});

  ChargeManage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ktv = json['ktv'];
    contract = json['contract'];
    state = json['state'];
    package = json['package'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ktv'] = this.ktv;
    data['contract'] = this.contract;
    data['state'] = this.state;
    data['package'] = this.package;
    return data;
  }
}