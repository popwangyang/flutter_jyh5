class VODProvider {
  int id;
  int initiateState;
  String brand;
  String acronym;

  VODProvider({this.id, this.initiateState, this.brand, this.acronym});

  VODProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    initiateState = json['initiate_state'];
    brand = json['brand'];
    acronym = json['acronym'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['initiate_state'] = this.initiateState;
    data['brand'] = this.brand;
    data['acronym'] = this.acronym;
    return data;
  }
}