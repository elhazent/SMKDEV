import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smkdevapp/base/base-state.dart';
import 'package:smkdevapp/constants.dart';
import 'package:smkdevapp/feature/main/profile/profile-presenter.dart';
import 'package:smkdevapp/feature/main/services/detailService-page.dart';
import 'package:smkdevapp/model/doctor-model.dart';
import 'package:smkdevapp/model/notification-model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class ProfilePage extends BaseStatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends BaseState<ProfilePage, ProfilePresenter> implements ProfileContract {
  ScrollController scrollController = ScrollController();
  List<NotificationModel> notifications = [];
  List<DoctorModel> historyBooking = [];
  bool maxScroll = false;
  File imageFile;
  String uploadedUrl = "";
  String defaultImage = "https://firebasestorage.googleapis.com/v0/b/my-application-f751a.appspot.com/o/profile%2Fuser.png?alt=media&token=0e7839a9-857c-4e45-9b69-c6150acd5dbf";
  String profilePath;
  final picker = ImagePicker();
  List<int> imageBytes;
  String image;
  bool selectedTabNotification = true;
  bool selectedTabHistory = false;


  onMaxScroll(){
    print(scrollController.position.pixels);
  }


  Future pickFromGallery() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((pickedImage) {
      setState(() {
        if(pickedImage != null){
          imageFile = pickedImage;
          imageBytes = imageFile.readAsBytesSync();
          image = base64Encode(imageBytes);
          print("_______________start___________");
          print(image);
          print("_______________stop____________");
        }else{
          print("No Image Selected");
        }
      });
      uploadFile();
    });
  }

  Future uploadFile() async {
    Reference storage = FirebaseStorage.instance
        .ref()
        .child('profile/${Path.basename(imageFile.path)}');
    UploadTask uploadTask = storage.putFile(imageFile);
    saveImageFilePath(Path.basename(imageFile.path));
    await uploadTask.then((res) {
      res.ref.getDownloadURL().then((url) {
        print("PROFILE_URL : $url");
        setState(() {
          uploadedUrl = url;
        });
      });
    });
  }

  Future getProfileImage() async {
    print("GET IMAGE");
    FirebaseStorage.instance
        .ref()
        .child("profile/$profilePath").getDownloadURL().then((url) {
      print("IMAGE_URL : $url");
      setState(() {
        uploadedUrl = url;
      });
    });
  }

  saveImageFilePath(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (path != null) {
      prefs.setString("profile", path);
      print("SAVED SF : $path");
    }
  }

  getImageFilePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var imagePath = prefs.getString("profile");
    print("SF GET : $imagePath");
    setState(() {
      profilePath = imagePath;
    });
    if (profilePath != null) {
      getProfileImage();
    }else{
      print("NULL");
    }
  }

  @override
  void initMvp() {
    super.initMvp();
    presenter = ProfilePresenter();
    presenter.setView(this);
    presenter.getAllNotification();
    presenter.getAllHistoryBooking();
    getImageFilePath();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile",
            style: TextStyle(
              color: DefaultColor.textPrimary
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              color: DefaultColor.primaryColor,
            ),
            NotificationListener<ScrollUpdateNotification>(
              onNotification: (notification) {
                if(notification.metrics.pixels >= 150){
                  setState(() {
                    maxScroll = true;
                  });
                }else{
                  setState(() {
                    maxScroll = false;
                  });
                }
              },
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.80,
                  margin: EdgeInsets.only(top: 180),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: !maxScroll ?
                    BorderRadius.only(
                      topLeft: Radius.circular(DefaultDimen.radius*10),
                      topRight: Radius.circular(DefaultDimen.radius*10),
                    ):
                    BorderRadius.all(Radius.circular(0))
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment(0, -1.3),
                        child: GestureDetector(
                          onTap: (){
                            pickFromGallery();
                          },
                          child: !maxScroll ? Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(DefaultDimen.spaceMedium)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(uploadedUrl.isNotEmpty ? uploadedUrl : defaultImage)
                              )
                            ),
                          ) : SizedBox(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(top: DefaultDimen.spaceExtraLarge),
                          child: Column(
                            children: [
                              !maxScroll ?  Container(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: DefaultDimen.textLarge,
                                          bottom: DefaultDimen.spaceSmall
                                      ),
                                      child: Text(
                                        "Joko Anwar",
                                        style: TextStyle(
                                          fontFamily: DefaultFont.PoppinsFont,
                                          fontSize: DefaultDimen.textExtraLarge,
                                          fontWeight: DefaultFontWeight.bold,
                                          color: DefaultColor.textPrimary
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: DefaultDimen.spaceSmall
                                      ),
                                      child: Text(
                                        "Laki-Laki",
                                        style: TextStyle(
                                            fontFamily: DefaultFont.PoppinsFont,
                                            fontSize: DefaultDimen.textLarge,
                                            color: DefaultColor.textPrimary
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: DefaultDimen.spaceMedium
                                      ),
                                      child: Text(
                                        "081280005000",
                                        style: TextStyle(
                                            fontFamily: DefaultFont.PoppinsFont,
                                            fontSize: DefaultDimen.textMedium,
                                            fontWeight: DefaultFontWeight.semiBold,
                                            color: Colors.grey
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ) :
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 100,
                                          margin: EdgeInsets.only(
                                            left: DefaultDimen.spaceMedium,
                                            bottom: DefaultDimen.spaceMedium,
                                            right: DefaultDimen.spaceLarge
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(DefaultDimen.radius*2),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(uploadedUrl.isNotEmpty ? uploadedUrl : defaultImage)
                                            )
                                          ),
                                        ),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: DefaultDimen.spaceSmall
                                                ),
                                                child: Text(
                                                  "Joko Anwar",
                                                  style: TextStyle(
                                                      fontFamily: DefaultFont.PoppinsFont,
                                                      fontSize: DefaultDimen.textExtraLarge,
                                                      fontWeight: DefaultFontWeight.bold,
                                                      color: DefaultColor.textPrimary
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: DefaultDimen.spaceSmall
                                                ),
                                                child: Text(
                                                  "Laki-Laki",
                                                  style: TextStyle(
                                                      fontFamily: DefaultFont.PoppinsFont,
                                                      fontSize: DefaultDimen.textLarge,
                                                      color: DefaultColor.textPrimary
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: DefaultDimen.spaceMedium
                                                ),
                                                child: Text(
                                                  "081280005000",
                                                  style: TextStyle(
                                                      fontFamily: DefaultFont.PoppinsFont,
                                                      fontSize: DefaultDimen.textMedium,
                                                      fontWeight: DefaultFontWeight.semiBold,
                                                      color: Colors.grey
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                              Container(
                                height: 50,
                                width: 300,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                  top: DefaultDimen.spaceMedium,
                                  bottom: DefaultDimen.spaceMedium,
                                ),
                                padding: EdgeInsets.all(DefaultDimen.spaceTiny),
                                decoration: BoxDecoration(
                                  color : Colors.grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(DefaultDimen.spaceSmall),
                                  )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                     GestureDetector(
                                       onTap :(){
                                         setState(() {
                                           selectedTabNotification = !selectedTabNotification ? true : false;
                                           if(selectedTabNotification){
                                             selectedTabHistory = false;
                                           }else{
                                             selectedTabHistory = true;
                                           }
                                         });
                                       },
                                       child: Container(
                                         height: 50,
                                         width: 125,
                                         alignment: Alignment.center,
                                         decoration: BoxDecoration(
                                             color: selectedTabNotification ? Colors.white : Colors.grey,
                                             borderRadius: BorderRadius.all(
                                               Radius.circular(DefaultDimen.spaceTiny),
                                             )
                                         ),
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                                           children: [
                                             Text(
                                               "Notifikasi",
                                               style: TextStyle(
                                                 fontFamily: DefaultFont.PoppinsFont,
                                                 fontWeight: DefaultFontWeight.semiBold,
                                               ),
                                             ),
                                             notifications.isNotEmpty ?
                                             Container(
                                               height: 20,
                                               width: 20,
                                               alignment: Alignment.center,
                                               decoration: BoxDecoration(
                                                 color: Colors.amber,
                                                 shape: BoxShape.circle
                                               ),
                                               child: Text(
                                                 "${notifications.length}",
                                                 style: TextStyle(
                                                   color: Colors.white,
                                                   fontFamily: DefaultFont.PoppinsFont,
                                                   fontWeight: DefaultFontWeight.semiBold
                                                 ),
                                               ),
                                             ):
                                             SizedBox()
                                           ],
                                         ),
                                       ),
                                     ),
                                    GestureDetector(
                                      onTap :(){
                                        setState(() {
                                          selectedTabHistory = !selectedTabHistory ? true : false;
                                          if(selectedTabHistory){
                                            selectedTabNotification = false;
                                          }else{
                                            selectedTabNotification = true;
                                          }
                                        });
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 160,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: selectedTabHistory ? Colors.white : Colors.grey,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(DefaultDimen.spaceTiny),
                                            )
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "Histori Booking",
                                              style: TextStyle(
                                                fontFamily: DefaultFont.PoppinsFont,
                                                fontWeight: DefaultFontWeight.semiBold,
                                              ),
                                            ),
                                            notifications.isNotEmpty ?
                                            Container(
                                              height: 20,
                                              width: 20,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.amber,
                                                  shape: BoxShape.circle
                                              ),
                                              child: Text(
                                                "${historyBooking.length}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: DefaultFont.PoppinsFont,
                                                  fontWeight: DefaultFontWeight.semiBold,
                                                ),
                                              ),
                                            ):
                                            SizedBox()
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.45,
                                  child: selectedTabNotification ? isOnProgress ?
                                  ListView.builder(
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.grey[100],
                                          child: Container(
                                          height: 150,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                margin: EdgeInsets.fromLTRB(
                                                    DefaultDimen.spaceSmall,
                                                    DefaultDimen.spaceSmall,
                                                    DefaultDimen.spaceMedium,
                                                    DefaultDimen.spaceSmall,
                                                ),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: DefaultColor.primaryColor,
                                                ),
                                              ),
                                              Container(
                                                height: 100,
                                                width: MediaQuery.of(context).size.width * 0.60,
                                                margin: EdgeInsets.fromLTRB(
                                                    DefaultDimen.spaceSmall,
                                                    DefaultDimen.spaceSmall,
                                                    DefaultDimen.spaceMedium,
                                                    DefaultDimen.spaceSmall,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 30,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 30,
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 30,
                                                      width: 90,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                      ),
                                        );
                                    },
                                  ) :
                                  ListView.builder(
                                    itemCount: notifications.isEmpty ? 0 : notifications.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailService(notification: notifications[index],)
                                            )
                                          );
                                        },
                                        child: Container(
                                          height: 150,
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                margin: EdgeInsets.fromLTRB(
                                                    DefaultDimen.spaceSmall,
                                                    DefaultDimen.spaceSmall,
                                                    DefaultDimen.spaceMedium,
                                                    DefaultDimen.spaceSmall,
                                                ),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: DefaultColor.primaryColor,
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Container(
                                                    width : 250,
                                                    child: Text(
                                                        "${
                                                          notifications[index].notifTitle
                                                        }", style: TextStyle(
                                                      color: DefaultColor.textPrimary,
                                                      fontFamily: DefaultFont.PoppinsFont,
                                                      fontWeight: DefaultFontWeight.semiBold,
                                                      fontSize: DefaultDimen.textLarge,
                                                    ),
                                                      maxLines: 2,
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                  Container(
                                                    width : 300,
                                                    child: Text(
                                                      "${
                                                          notifications[index].notifOverview
                                                      }", style: TextStyle(
                                                      color: DefaultColor.textPrimary,
                                                      fontFamily: DefaultFont.PoppinsFont,
                                                      fontWeight: DefaultFontWeight.semiBold,
                                                      fontSize: DefaultDimen.textMedium,
                                                    ),
                                                      maxLines: 2,
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      "${notifications[index].date}",
                                                      style: TextStyle(
                                                      color: DefaultColor.textPrimary,
                                                      fontFamily: DefaultFont.PoppinsFont,
                                                      fontWeight: DefaultFontWeight.semiBold,
                                                      fontSize: DefaultDimen.textSmall,
                                                    ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ) : isOnProgress ?
                                  ListView.builder(
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey[300],
                                          highlightColor: Colors.grey[100],
                                          child: Container(
                                            height: 150,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 75,
                                                  width: 75,
                                                  margin: EdgeInsets.fromLTRB(
                                                    DefaultDimen.spaceSmall,
                                                    DefaultDimen.spaceSmall,
                                                    DefaultDimen.spaceMedium,
                                                    DefaultDimen.spaceSmall,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: DefaultColor.primaryColor,
                                                  ),
                                                ),
                                                Container(
                                                  height: 100,
                                                  width: MediaQuery.of(context).size.width * 0.60,
                                                  margin: EdgeInsets.fromLTRB(
                                                    DefaultDimen.spaceSmall,
                                                    DefaultDimen.spaceSmall,
                                                    DefaultDimen.spaceMedium,
                                                    DefaultDimen.spaceSmall,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        height: 30,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            color: Colors.grey
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 30,
                                                        width: 200,
                                                        decoration: BoxDecoration(
                                                            color: Colors.grey
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 30,
                                                        width: 90,
                                                        decoration: BoxDecoration(
                                                            color: Colors.grey
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                    },
                                  ) :
                                  ListView.builder(
                                    itemCount: historyBooking.isEmpty ? 0 : historyBooking.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 150,
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 75,
                                              width: 75,
                                              margin: EdgeInsets.fromLTRB(
                                                DefaultDimen.spaceSmall,
                                                DefaultDimen.spaceSmall,
                                                DefaultDimen.spaceMedium,
                                                DefaultDimen.spaceSmall,
                                              ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: DefaultColor.primaryColor,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  width : 250,
                                                  child: Text(
                                                    "${
                                                        historyBooking[index].doctorName
                                                    }", style: TextStyle(
                                                    color: DefaultColor.textPrimary,
                                                    fontFamily: DefaultFont.PoppinsFont,
                                                    fontWeight: DefaultFontWeight.semiBold,
                                                    fontSize: DefaultDimen.textLarge,
                                                  ),
                                                    maxLines: 2,
                                                    softWrap: true,
                                                  ),
                                                ),
                                                Container(
                                                  width : 300,
                                                  child: Text(
                                                    "${
                                                        historyBooking[index].specialist
                                                    }", style: TextStyle(
                                                    color: DefaultColor.textPrimary,
                                                    fontFamily: DefaultFont.PoppinsFont,
                                                    fontWeight: DefaultFontWeight.semiBold,
                                                    fontSize: DefaultDimen.textMedium,
                                                  ),
                                                    maxLines: 2,
                                                    softWrap: true,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  @override
  showHistoryBooking(List<DoctorModel> history) {
    setState(() {
      historyBooking = history;
    });
  }

  @override
  showNotification(List<NotificationModel> notification) {
     setState(() {
      notifications = notification;
    });
  }
}
