import 'package:shared_preferences/shared_preferences.dart';
import 'package:smkdevapp/base/base-presenter.dart';

import '../../../../constants.dart';

abstract class BookingDetailContract extends BaseContract{

}

class BookingDetailPresenter extends BasePresenter<BookingDetailContract>{
  @override
  void dispose() {
    // TODO: implement dispose
  }

  SharedPreferences _prefs;

  postRegister(String username)async{
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString(DefaultKey.AccessToken, username);
  }

}