import 'package:smkdevapp/base/base-presenter.dart';
import 'package:smkdevapp/base/base-repository.dart';
import 'package:smkdevapp/model/about-model.dart';
import 'package:smkdevapp/model/office-model.dart';

abstract class AboutContract extends BaseContract{
  showDetailAbout(AboutModel about);
  showOffice(List<OfficeModel> office);
}

class AboutPresenter extends BasePresenter<AboutContract> {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  getDetailAbout(){
    view.showProgressBar();
    repo.fetch("About.json", RequestType.get).then((res){
        AboutModel aboutResponse = AboutModel.fromJson(res);
        view.dismissProgressBar();
        view.showDetailAbout(aboutResponse);
    }).catchError((error){
      view.dismissProgressBar();
      print("Error : $error");
    });
  }

  getOffice(){
    view.showProgressBar();
    repo.fetch("Service.json", RequestType.get).then((res) {
      List<OfficeModel> officeResponse = (res as List).map((office) =>
          OfficeModel.fromJson(office)
      ).toList();
      view.dismissProgressBar();
      view.showOffice(officeResponse);
    }).catchError((error){
      view.dismissProgressBar();
      print("Error : $error");
    });
  }

}
