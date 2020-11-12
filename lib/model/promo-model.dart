class PromoModel {
  int id;
  String tag;
  String image;
  String title;
  String date;
  String description;

  PromoModel(
      {this.id, this.tag, this.image, this.title, this.date, this.description});

  PromoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tag = json['tag'];
    image = json['image'];
    title = json['title'];
    date = json['date'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tag'] = this.tag;
    data['image'] = this.image;
    data['title'] = this.title;
    data['date'] = this.date;
    data['description'] = this.description;
    return data;
  }
}