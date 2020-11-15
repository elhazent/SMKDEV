
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smkdevapp/base/base-presenter.dart';
import 'package:smkdevapp/base/base-repository.dart';
import 'package:smkdevapp/model/doctor-model.dart';
import 'package:smkdevapp/model/notification-model.dart';
import 'package:path/path.dart' as Path;

abstract class ProfileContract extends BaseContract{
  showNotification(List<NotificationModel> notification);
  showHistoryBooking(List<DoctorModel> history);
  uploadProfileImage(String url);
  getProfileImage(String url);
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

  uploadProfilePicture(File imageFile) {
    view.showUploadProgress();
    Reference storage = FirebaseStorage.instance
        .ref()
        .child('profile/${Path.basename(imageFile.path)}');
    UploadTask uploadTask = storage.putFile(imageFile);
    saveImageFilePath(Path.basename(imageFile.path));
     uploadTask.then((res) {
      res.ref.getDownloadURL().then((url){
        print("PROFILE_URL : $url");
        view.dismissUploadProgress();
        view.uploadProfileImage(url);
      });
    });
  }

  getProfilePicture(String profilePath)  {
    view.showProgressBar();
    FirebaseStorage.instance
    .ref()
    .child('profile/$profilePath').getDownloadURL().then((url){
      view.getProfileImage(url);
      print("GET_IMAGE_URL : $url");
      view.dismissProgressBar();
    });
  }

  saveImageFilePath(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (path != null) {
      prefs.setString("profile", path);
      print("SAVED SF : $path");
    }
  }
}