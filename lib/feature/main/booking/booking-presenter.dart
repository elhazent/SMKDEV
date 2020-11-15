import 'package:shared_preferences/shared_preferences.dart';
import 'package:smkdevapp/base/base-presenter.dart';
import 'package:smkdevapp/base/base-repository.dart';
import 'package:smkdevapp/model/doctor-model.dart';
import 'package:smkdevapp/constants.dart';

abstract class BookingContract extends BaseContract{
  fetchDoctor(List<DoctorModel> dataDoctor);
}

class BookingPresenter extends BasePresenter<BookingContract>{
  @override
  void dispose() {
    // TODO: implement dispose
  }


  getDoctor(){
    view.showProgressBar();
    repo.fetch("Doctor.json", RequestType.get).then((res) {
      List<DoctorModel> doctorResponse = (res as List).map((e) => DoctorModel.fromJson(e)).toList();
      view.fetchDoctor(doctorResponse);
      view.dismissProgressBar();
    }).catchError((error) {
      view.dismissProgressBar();
      print(error);
    });
  }


}