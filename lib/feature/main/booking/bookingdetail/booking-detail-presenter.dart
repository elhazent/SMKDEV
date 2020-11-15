import 'package:shared_preferences/shared_preferences.dart';
import 'package:smkdevapp/base/base-presenter.dart';
import 'package:smkdevapp/model/doctor-model.dart';

import '../../../../constants.dart';
import 'booking-detail-page.dart';

abstract class BookingDetailContract extends BaseContract{

}

class BookingDetailPresenter extends BasePresenter<BookingDetailContract>{
  @override
  void dispose() {
    // TODO: implement dispose
  }

  SharedPreferences _prefs;

  postRegister(String name,int gender,String phone,DoctorModel data)async{
    view.showProgressBar();
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString(DefaultKey.Name, name);
    if (gender == 1){
      _prefs.setString(DefaultKey.Gender, "Laki-laki");
    } else {
      _prefs.setString(DefaultKey.Gender, "Perempuan");
    }
    _prefs.setString(DefaultKey.NomerHp, phone);
    Future.delayed(Duration(seconds: 2)).then((value) {
      view.dismissProgressBar();
      view.push(BookingDetailPage(data));
    });
  }

}