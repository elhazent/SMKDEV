class PartnerModel {
  int id;
  String logo;
  String name;
  String description;
  String tag;

  PartnerModel({this.id, this.logo, this.name, this.description, this.tag});

  PartnerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'];
    name = json['name'];
    description = json['description'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logo'] = this.logo;
    data['name'] = this.name;
    data['description'] = this.description;
    data['tag'] = this.tag;
    return data;
  }
}