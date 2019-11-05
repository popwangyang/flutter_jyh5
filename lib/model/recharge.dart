

// 套餐model
class RechargeModel {
  int id;
  String name;
  double rechargeAmount;
  String preferentialDetail;
  int initiateState;
  String createDate;
  String updateDate;
  int packageType;
  int promotionMethod;
  String packageTag;
  String giftDeviceDescription;
  double presentAmount;
  String giftDeviceCopy;
  String tag;

  RechargeModel(
      {this.id,
        this.name,
        this.rechargeAmount,
        this.preferentialDetail,
        this.initiateState,
        this.createDate,
        this.updateDate,
        this.packageType,
        this.promotionMethod,
        this.packageTag,
        this.giftDeviceDescription,
        this.presentAmount,
        this.giftDeviceCopy,
        this.tag});

  RechargeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rechargeAmount = json['recharge_amount'];
    preferentialDetail = json['preferential_detail'];
    initiateState = json['initiate_state'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    packageType = json['package_type'];
    promotionMethod = json['promotion_method'];
    packageTag = json['package_tag'];
    giftDeviceDescription = json['gift_device_description'];
    presentAmount = json['present_amount'];
    giftDeviceCopy = json['gift_device_copy'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['recharge_amount'] = this.rechargeAmount;
    data['preferential_detail'] = this.preferentialDetail;
    data['initiate_state'] = this.initiateState;
    data['create_date'] = this.createDate;
    data['update_date'] = this.updateDate;
    data['package_type'] = this.packageType;
    data['promotion_method'] = this.promotionMethod;
    data['package_tag'] = this.packageTag;
    data['gift_device_description'] = this.giftDeviceDescription;
    data['present_amount'] = this.presentAmount;
    data['gift_device_copy'] = this.giftDeviceCopy;
    data['tag'] = this.tag;
    return data;
  }
}

// 充值记录信息
class RechargeRecordModal {
  int id;
  String statusDes;
  String platformDes;
  Null statusUpdateTime;
  String orderId;
  String placeName;
  String placeId;
  Null transactionId;
  Null payTime;
  String createDate;
  double rechargeFee;
  String packageName;
  String rechargeStatus;
  int boxCount;
  String packageTypeDisplay;
  String arrivalAmount;

  RechargeRecordModal(
      {this.id,
        this.statusDes,
        this.platformDes,
        this.statusUpdateTime,
        this.orderId,
        this.placeName,
        this.placeId,
        this.transactionId,
        this.payTime,
        this.createDate,
        this.rechargeFee,
        this.packageName,
        this.rechargeStatus,
        this.boxCount,
        this.packageTypeDisplay,
        this.arrivalAmount});

  RechargeRecordModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    statusDes = json['status_des'];
    platformDes = json['platform_des'];
    statusUpdateTime = json['status_update_time'];
    orderId = json['order_id'];
    placeName = json['place_name'];
    placeId = json['place_id'];
    transactionId = json['transaction_id'];
    payTime = json['pay_time'];
    createDate = json['create_date'];
    rechargeFee = json['recharge_fee'];
    packageName = json['package_name'];
    rechargeStatus = json['recharge_status'];
    boxCount = json['box_count'];
    packageTypeDisplay = json['package_type_display'];
    arrivalAmount = json['arrival_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status_des'] = this.statusDes;
    data['platform_des'] = this.platformDes;
    data['status_update_time'] = this.statusUpdateTime;
    data['order_id'] = this.orderId;
    data['place_name'] = this.placeName;
    data['place_id'] = this.placeId;
    data['transaction_id'] = this.transactionId;
    data['pay_time'] = this.payTime;
    data['create_date'] = this.createDate;
    data['recharge_fee'] = this.rechargeFee;
    data['package_name'] = this.packageName;
    data['recharge_status'] = this.rechargeStatus;
    data['box_count'] = this.boxCount;
    data['package_type_display'] = this.packageTypeDisplay;
    data['arrival_amount'] = this.arrivalAmount;
    return data;
  }
}