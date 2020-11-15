class AboutModel {
  String hospitalName;
  String image;
  String about;
  String email;
  List<EmergencyService> emergencyService;

  AboutModel(
      {this.hospitalName,
        this.image,
        this.about,
        this.email,
        this.emergencyService});

  AboutModel.fromJson(Map<String, dynamic> json) {
    hospitalName = json['hospitalName'];
    image = json['image'];
    about = json['about'];
    email = json['email'];
    if (json['emergencyService'] != null) {
      emergencyService = new List<EmergencyService>();
      json['emergencyService'].forEach((v) {
        emergencyService.add(new EmergencyService.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hospitalName'] = this.hospitalName;
    data['image'] = this.image;
    data['about'] = this.about;
    data['email'] = this.email;
    if (this.emergencyService != null) {
      data['emergencyService'] =
          this.emergencyService.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmergencyService {
  int id;
  String serviceName;
  String shortName;
  String openAt;
  List<Contact> contact;
  String noPhone;

  EmergencyService(
      {this.id,
        this.serviceName,
        this.shortName,
        this.openAt,
        this.contact,
        this.noPhone});

  EmergencyService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['serviceName'];
    shortName = json['shortName'];
    openAt = json['openAt'];
    if (json['contact'] != null) {
      contact = new List<Contact>();
      json['contact'].forEach((v) {
        contact.add(new Contact.fromJson(v));
      });
    }
    noPhone = json['noPhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serviceName'] = this.serviceName;
    data['shortName'] = this.shortName;
    data['openAt'] = this.openAt;
    if (this.contact != null) {
      data['contact'] = this.contact.map((v) => v.toJson()).toList();
    }
    data['noPhone'] = this.noPhone;
    return data;
  }
}

class Contact {
  String wa;
  String office;

  Contact({this.wa, this.office});

  Contact.fromJson(Map<String, dynamic> json) {
    wa = json['wa'];
    office = json['office'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wa'] = this.wa;
    data['office'] = this.office;
    return data;
  }
}