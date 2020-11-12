class FacilityModel {
  int id;
  String title;
  String tag;
  String image;
  String description;

  FacilityModel(
      {this.id, this.title, this.tag, this.image, this.description});

  FacilityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    tag = json['tag'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['tag'] = this.tag;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }
}