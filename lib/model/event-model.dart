class EventModel {
  int id;
  String image;
  String tag;
  String title;
  String date;
  String description;

  EventModel(
      {this.id, this.image, this.tag, this.title, this.date, this.description});

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    tag = json['tag'];
    title = json['title'];
    date = json['date'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['tag'] = this.tag;
    data['title'] = this.title;
    data['date'] = this.date;
    data['description'] = this.description;
    return data;
  }
}