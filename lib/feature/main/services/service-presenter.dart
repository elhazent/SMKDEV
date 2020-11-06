import 'package:smkdevapp/base/base-presenter.dart';
import 'package:smkdevapp/base/base-repository.dart';
import 'package:smkdevapp/model/event-model.dart';
import 'package:smkdevapp/model/facility-model.dart';
import 'package:smkdevapp/model/promo-model.dart';

abstract class ServiceContract extends BaseContract {
  showServiceFacility(List<FacilityModel> serviceFacility);
  showEvent(List<EventModel> event);
  showPromo(List<PromoModel> promo);
}

class ServicePresenter extends BasePresenter<ServiceContract> {

  @override
  void dispose() {
    // TODO: implement dispose
  }

  getServiceFacility(){
    view.showProgressBar();
    repo.fetch("Facility.json", RequestType.get).then((res) {
      List<FacilityModel> serviceFacilityResponse = (res as List).map((facility) =>
        FacilityModel.fromJson(facility)
      ).toList();
      view.showServiceFacility(serviceFacilityResponse);
      view.dismissProgressBar();
    }).catchError((error) {
      view.dismissProgressBar();
      print(error);
    });
  }

  getEvent(){
    view.showProgressBar();
    repo.fetch("Event.json", RequestType.get).then((res) {
      List<EventModel> eventResponse = (res as List).map((event) => 
      EventModel.fromJson(event)
      ).toList();
      view.showEvent(eventResponse);
      print(eventResponse);
      view.dismissProgressBar();
    }).catchError((onError){
      view.dismissProgressBar();
      print(onError);
    });
  }

  getPromo(){
    view.showProgressBar();
    repo.fetch("Promo.json", RequestType.get).then((res) {
      List<PromoModel> promoResponse = (res as List).map((promo) =>
      PromoModel.fromJson(promo)
      ).toList();
      view.showPromo(promoResponse);
      view.dismissProgressBar();
    }).catchError((error){
      view.dismissProgressBar();
      print(error);
    });
  }
}
