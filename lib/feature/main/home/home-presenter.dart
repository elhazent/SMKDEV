import 'package:smkdevapp/base/base-presenter.dart';
import 'package:smkdevapp/base/base-repository.dart';
import 'package:smkdevapp/model/doctor-model.dart';
import 'package:smkdevapp/model/event-model.dart';
import 'package:smkdevapp/model/service-model.dart';

abstract class HomeContract extends BaseContract{
  fetchService(List<ServiceModel> dataService);
  fetchSlider(List<EventModel> dataSlider);
  fetchDoctor(List<DoctorModel> dataDoctor);
}

class HomePresenter extends BasePresenter<HomeContract>{
  @override
  void dispose() {
    // TODO: implement dispose
  }

  getService(){
    view.showProgressBar();
    repo.fetch("Service.json", RequestType.get).then((res) {
      List<ServiceModel> serviceResponse = (res as List).map((e) => ServiceModel.fromJson(e)).toList();
      view.fetchService(serviceResponse);
      view.dismissProgressBar();
    }).catchError((error) {
      view.dismissProgressBar();
      print(error);
    });
  }
  getSlider(){
    view.showProgressBar();
    repo.fetch("Event.json", RequestType.get).then((res) {
      List<EventModel> sliderResponse = (res as List).map((e) => EventModel.fromJson(e)).toList();
      view.fetchSlider(sliderResponse);
      view.dismissProgressBar();
    }).catchError((error) {
      view.dismissProgressBar();
      print(error);
    });
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