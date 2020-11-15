class DoctorModel {
  String avatar;
  String doctorName;
  String specialist;
  List<DoctorSchedule> doctorSchedule;
  String bio;
  String credential;
  String academicAffiliation;

  DoctorModel(
      {this.avatar,
        this.doctorName,
        this.specialist,
        this.doctorSchedule,
        this.bio,
        this.credential,
        this.academicAffiliation});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    doctorName = json['doctorName'];
    specialist = json['specialist'];
    if (json['doctorSchedule'] != null) {
      doctorSchedule = new List<DoctorSchedule>();
      json['doctorSchedule'].forEach((v) {
        doctorSchedule.add(new DoctorSchedule.fromJson(v));
      });
    }
    bio = json['bio'];
    credential = json['credential'];
    academicAffiliation = json['academicAffiliation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['doctorName'] = this.doctorName;
    data['specialist'] = this.specialist;
    if (this.doctorSchedule != null) {
      data['doctorSchedule'] =
          this.doctorSchedule.map((v) => v.toJson()).toList();
    }
    data['bio'] = this.bio;
    data['credential'] = this.credential;
    data['academicAffiliation'] = this.academicAffiliation;
    return data;
  }
}

class DoctorSchedule {
  int id;
  String day;
  String hour;
  String place;

  DoctorSchedule({this.id, this.day, this.hour, this.place});

  DoctorSchedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    hour = json['hour'];
    place = json['place'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day'] = this.day;
    data['hour'] = this.hour;
    data['place'] = this.place;
    return data;
  }
}