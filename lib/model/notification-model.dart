class NotificationModel {
  int id;
  String tag;
  String notifOverview;
  String notifTitle;
  String notifContent;
  String date;
  String time;
  List<Place> place;
  String image;

  NotificationModel(
      {this.id,
        this.tag,
        this.notifOverview,
        this.notifTitle,
        this.notifContent,
        this.date,
        this.time,
        this.place,
        this.image});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tag = json['tag'];
    notifOverview = json['notifOverview'];
    notifTitle = json['notifTitle'];
    notifContent = json['notifContent'];
    date = json['date'];
    time = json['time'];
    if (json['place'] != null) {
      place = new List<Place>();
      json['place'].forEach((v) {
        place.add(new Place.fromJson(v));
      });
    }
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tag'] = this.tag;
    data['notifOverview'] = this.notifOverview;
    data['notifTitle'] = this.notifTitle;
    data['notifContent'] = this.notifContent;
    data['date'] = this.date;
    data['time'] = this.time;
    if (this.place != null) {
      data['place'] = this.place.map((v) => v.toJson()).toList();
    }
    data['image'] = this.image;
    return data;
  }
}

class Place {
  String name;
  String address;

  Place({this.name, this.address});

  Place.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    return data;
  }
}