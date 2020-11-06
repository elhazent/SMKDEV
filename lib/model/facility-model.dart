class FacilityModel {
  int id;
  String facilityName;
  String tag;
  String image;
  String description;

  FacilityModel(
      {this.id, this.facilityName, this.tag, this.image, this.description});

  FacilityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    facilityName = json['facilityName'];
    tag = json['tag'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['facilityName'] = this.facilityName;
    data['tag'] = this.tag;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }
}