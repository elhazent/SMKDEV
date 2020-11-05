/// id : 1
/// facilityName : "Ruang Perawatan"
/// tag : "Fasilitas"
/// image : "https://mitrakeluarga.com/source/test/layanan%20unggulan%201/B/SVIP.jpg"
/// description : "Fasilitas kamar : \n\n1 tempat tidur elektrik dengan remote control \n1 tempat tidur penunggu \nTV LED 42 \nDVD \nAC \nLemari es \nDispenser \nTelepon \n1 set sofa \nAlmari besar \nNakas & cover bed table \n1 set meja makan \nKamar mandi (air panas dan dingin)."

class FacilityModel {
  int _id;
  String _facilityName;
  String _tag;
  String _image;
  String _description;

  int get id => _id;
  String get facilityName => _facilityName;
  String get tag => _tag;
  String get image => _image;
  String get description => _description;

  FacilityModel({
      int id, 
      String facilityName, 
      String tag, 
      String image, 
      String description}){
    _id = id;
    _facilityName = facilityName;
    _tag = tag;
    _image = image;
    _description = description;
}

  FacilityModel.fromJson(dynamic json) {
    _id = json["id"];
    _facilityName = json["facilityName"];
    _tag = json["tag"];
    _image = json["image"];
    _description = json["description"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["facilityName"] = _facilityName;
    map["tag"] = _tag;
    map["image"] = _image;
    map["description"] = _description;
    return map;
  }

}