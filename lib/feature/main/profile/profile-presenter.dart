
import 'package:smkdevapp/base/base-presenter.dart';
import 'package:smkdevapp/base/base-repository.dart';
import 'package:smkdevapp/model/doctor-model.dart';
import 'package:smkdevapp/model/notification-model.dart';

abstract class ProfileContract extends BaseContract{
  showNotification(List<NotificationModel> notification);
  showHistoryBooking(List<DoctorModel> history);
}

class ProfilePresenter extends BasePresenter<ProfileContract>{
  @override
  void dispose() {
    // TODO: implement dispose
  }
  
  getAllNotification(){
    view.showProgressBar();
    repo.fetch("Notifications.json", RequestType.get).then((res) {
      List<NotificationModel> notificationResponse = (res as List).map((notification) =>
        NotificationModel.fromJson(notification)
      ).toList();
      view.showNotification(notificationResponse);
      view.dismissProgressBar();
    }).catchError((error){
      view.dismissProgressBar();
      print(error);
    });
  }

  getAllHistoryBooking(){
    view.showProgressBar();
    repo.fetch("Doctor.json", RequestType.get).then((res) {
      List<DoctorModel> historyBooking = (res as List).map((history) =>
        DoctorModel.fromJson(history)
      ).toList();
      view.showHistoryBooking(historyBooking);
      view.dismissProgressBar();
    }).catchError((error){
      view.dismissProgressBar();
      print(error);
    });
  }
}