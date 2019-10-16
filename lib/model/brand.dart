
class Brand {
  int id;
  int initiateState;
  String brand;
  String acronym;
  String createDate;
  String updateDate;

  Brand(
      {this.id,
        this.initiateState,
        this.brand,
        this.acronym,
        this.createDate,
        this.updateDate});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    initiateState = json['initiate_state'];
    brand = json['brand'];
    acronym = json['acronym'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['initiate_state'] = this.initiateState;
    data['brand'] = this.brand;
    data['acronym'] = this.acronym;
    data['create_date'] = this.createDate;
    data['update_date'] = this.updateDate;
    return data;
  }
}

class CompanyBrands {
  int id;
  String name;

  CompanyBrands(
      {this.id,
        this.name,
      });

  CompanyBrands.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}