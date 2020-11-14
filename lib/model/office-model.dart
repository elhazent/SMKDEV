class OfficeModel {
  int id;
  String officeName;
  String address;
  String officeHourNormal;
  String officeHourWeekend;

  OfficeModel(
      {this.id,
        this.officeName,
        this.address,
        this.officeHourNormal,
        this.officeHourWeekend});

  OfficeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    officeName = json['officeName'];
    address = json['address'];
    officeHourNormal = json['officeHourNormal'];
    officeHourWeekend = json['officeHourWeekend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['officeName'] = this.officeName;
    data['address'] = this.address;
    data['officeHourNormal'] = this.officeHourNormal;
    data['officeHourWeekend'] = this.officeHourWeekend;
    return data;
  }
}