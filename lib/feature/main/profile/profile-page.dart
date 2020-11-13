import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smkdevapp/base/base-state.dart';
import 'package:smkdevapp/constants.dart';
import 'package:smkdevapp/feature/main/booking/bookingconfirm/booking-confirm-page.dart';
import 'package:smkdevapp/feature/main/detail/detail-notification-page.dart';
import 'package:smkdevapp/feature/main/profile/profile-presenter.dart';
import 'package:smkdevapp/model/doctor-model.dart';
import 'package:smkdevapp/model/notification-model.dart';
import 'package:smkdevapp/widget/detail-image.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfilePage extends BaseStatefulWidget {
  final File imgFile;
  ProfilePage({Key key, this.imgFile}) : super(key: key);

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
  String defaultImage = "https://gitlab.com/Daffaal/data-json/-/raw/master/avatar.png";
  String profilePath;
  String image;
  bool selectedTabNotification = true;
  bool selectedTabHistory = false;
  Image _image;


  onMaxScroll(){
    print(scrollController.position.pixels);
  }


  Future pickFromGallery() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((pickedImage) {
      if(pickedImage != null){
        setState(() {
          imageFile = pickedImage;
          _image = Image(image: FileImage(pickedImage));
          print("PATH : $imageFile");
        });
      } else {
        Fluttertoast.showToast(
            msg: "No image selected",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM
        );
      }
    });
  }

  Future pickFromCamera() async {
    await ImagePicker.pickImage(source: ImageSource.camera).then((pickedImage) {
      if (pickedImage != null) {
        setState(() {
          imageFile = pickedImage;
          _image = Image(image: FileImage(pickedImage));
          print("PATH : $imageFile");
        });
      } else {
        Fluttertoast.showToast(
            msg: "No image selected",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM
        );
      }
    });
  }

  getImageFilePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var imagePath = prefs.getString("profile");
    print("SF GET : $imagePath");
    setState(() {
      profilePath = imagePath;
    });
    if (profilePath != null) {
      presenter.getProfilePicture(profilePath);
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
    if (widget.imgFile != null) {
      presenter.uploadProfilePicture(widget.imgFile);
    }
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
              color: DefaultColor.primaryColor.withOpacity(0.3),
            ),
            SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 180),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(DefaultDimen.radius*10),
                        topRight: Radius.circular(DefaultDimen.radius*10),
                      )
                    ),
                    child: Container(
                      alignment: Alignment.topCenter,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: DefaultDimen.spaceExtraLarge),
                      child: Column(
                        children: [
                          Container(
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
                                       selectedTabNotification = true;
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
                                      selectedTabHistory = true;
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
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: DefaultDimen.spaceLarge),
                            height: isOnProgress ? (160 * 5).toDouble() : 160 * (selectedTabNotification ? notifications.length : historyBooking.length).toDouble(),
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
                            Column(
                              children: notifications.map((notifications) =>
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailNotification(notification: notifications,)
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
                                            padding: EdgeInsets.all(DefaultDimen.spaceLarge),
                                            margin: EdgeInsets.fromLTRB(
                                              DefaultDimen.spaceSmall,
                                              DefaultDimen.spaceSmall,
                                              DefaultDimen.spaceMedium,
                                              DefaultDimen.spaceSmall,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color(0xff2962FF).withOpacity(0.1),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(notifications.badge, scale: 0.90)
                                                  )
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width : MediaQuery.of(context).size.width * 0.45,
                                                child: Text(
                                                  "${
                                                      notifications.notifTitle
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
                                                width : MediaQuery.of(context).size.width * 0.45,
                                                child: Text(
                                                  "${
                                                      notifications.notifOverview
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
                                                  "${notifications.date}",
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
                                  )
                              ).toList(),
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: historyBooking.map((historyBooking) =>
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BookingConfirmPage()
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
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(historyBooking.avatar)
                                                )
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width : MediaQuery.of(context).size.width * 0.45,
                                                child: Text(
                                                  "${
                                                      historyBooking.doctorName
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
                                                width : MediaQuery.of(context).size.width * 0.45,
                                                child: Text(
                                                  "${
                                                      historyBooking.specialist
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
                                    ),
                                  )
                              ).toList(),
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                  Positioned(
                    top: 120,
                    right: 0,
                    left: 0,
                    child:
                      Container(
                      alignment: Alignment.topCenter,
                      margin:EdgeInsets.only(top : 0.1),
                      child: GestureDetector(
                          onTap: (){
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (ctx) {
                                return
                                MyDialog(imgUrl: uploadedUrl.isNotEmpty ? uploadedUrl : defaultImage,);
                              }
                            );
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            padding : EdgeInsets.all(DefaultDimen.spaceExtraLarge),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(DefaultDimen.spaceMedium)
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(uploadedUrl.isNotEmpty ? uploadedUrl : defaultImage)
                                )
                            ),
                            child: isOnProgress ? CircularProgressIndicator() : SizedBox(),
                          )
                      ),
                    ),
                  ),
                ],
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

  @override
  uploadProfileImage(String url) {
    setState(() {
      uploadedUrl = url;
    });
  }

  @override
  getProfileImage(String url) {
    setState(() {
      uploadedUrl = url;
    });
  }
}
class MyDialog extends StatefulWidget {
  final String imgUrl;

  MyDialog({Key key, this.imgUrl}) : super(key: key);

  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {

  File imagePath;
  Image image;

  Future pickFromGallery() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((pickedImage) {
      setState(() {
        if(pickedImage != null){
          imagePath = pickedImage;
          image = Image(image: FileImage(pickedImage));
        } else {
          Fluttertoast.showToast(
              msg: "No image selected",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM
          );
        }
      });
    });
  }

  Future pickFromCamera() async {
    await ImagePicker.pickImage(source: ImageSource.camera).then((pickedImage) {
      if (pickedImage != null) {
        setState(() {
          imagePath = pickedImage;
          image = Image(image: FileImage(pickedImage));
        });
      } else {
        Fluttertoast.showToast(
            msg: "No image selected",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.80,
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  child: image != null ? image :
                    Image.network(widget.imgUrl),
                  height: 300,
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder : (context) => DetailImage(url: widget.imgUrl)
                    )
                  );
                },
              ),
              GestureDetector(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: DefaultDimen.spaceLarge),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.camera_alt),
                        SizedBox(width: DefaultDimen.spaceSmall),
                        Text(
                            'Take a picture',
                          style: TextStyle(
                            fontWeight: DefaultFontWeight.semiBold,
                            fontSize: DefaultDimen.textMedium,
                            fontFamily: DefaultFont.PoppinsFont
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () async {
                    await pickFromCamera();
                    setState(() {});
                  }),
              GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(bottom: DefaultDimen.spaceLarge),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.image),
                        SizedBox(width: 5),
                        Text(
                          'Choose from gallery',
                          style: TextStyle(
                              fontWeight: DefaultFontWeight.semiBold,
                              fontSize: DefaultDimen.textMedium,
                              fontFamily: DefaultFont.PoppinsFont
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () async {
                    await pickFromGallery();
                    setState(() {});
                  }),
              GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.70,
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: EdgeInsets.all(DefaultDimen.spaceSmall),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(DefaultDimen.radius * 2),
                      color: DefaultColor.primaryColor
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                          fontWeight: DefaultFontWeight.semiBold,
                          fontSize: DefaultDimen.textMedium,
                          fontFamily: DefaultFont.PoppinsFont,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(imgFile: imagePath)
                    )
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.all(DefaultDimen.spaceSmall),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
