import 'package:smkdevapp/base/base-presenter.dart';
import 'package:smkdevapp/base/base-repository.dart';
import 'package:smkdevapp/model/carrier-model.dart';
import 'package:smkdevapp/model/partner-model.dart';

abstract class PartnerCarrierContract extends BaseContract{
  showPartner(List<PartnerModel> partner);
  showCarrier(List<CarrierModel> carrier);
}

class PartnerCarrierPresenter extends BasePresenter<PartnerCarrierContract> {
  @override
  void dispose() {
    // TODO: implement dispose
  }
  getPartner(){
    view.showProgressBar();
    repo.fetch("Partners.json", RequestType.get).then((res) {
      List<PartnerModel> partnerResponse = (res as List).map((partner) =>
          PartnerModel.fromJson(partner)
      ).toList();
      view.showPartner(partnerResponse);
      view.dismissProgressBar();
    }).catchError((error){
      print("Error : $error");
    });
  }

  getCarrier(){
    view.showProgressBar();
    repo.fetch("Carrier.json", RequestType.get).then((res){
      List<CarrierModel> carrierResponse = (res as List).map((carrier) =>
          CarrierModel.fromJson(carrier)
      ).toList();
      view.showCarrier(carrierResponse);
      view.dismissProgressBar();
    }).catchError((error){
      print("Error : $error");
    });
  }
}