
class CarrierModel {
  int id;
  String tag;
  String titleJob;
  String image;
  String date;
  String description;

  CarrierModel(
      {this.id,
        this.tag,
        this.titleJob,
        this.image,
        this.date,
        this.description});

  CarrierModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tag = json['tag'];
    titleJob = json['titleJob'];
    image = json['image'];
    date = json['date'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tag'] = this.tag;
    data['titleJob'] = this.titleJob;
    data['image'] = this.image;
    data['date'] = this.date;
    data['description'] = this.description;
    return data;
  }
}