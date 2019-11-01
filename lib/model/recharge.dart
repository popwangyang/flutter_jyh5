

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