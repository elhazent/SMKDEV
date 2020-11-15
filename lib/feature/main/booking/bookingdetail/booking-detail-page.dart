import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smkdevapp/base/base-state.dart';
import 'package:smkdevapp/feature/main/booking/bookingconfirm/booking-confirm-page.dart';
import 'package:smkdevapp/feature/main/booking/bookingdetail/booking-detail-presenter.dart';
import 'package:smkdevapp/model/doctor-model.dart';
import 'package:smkdevapp/widget/register-bottomsheet.dart';

import '../../../../constants.dart';

class BookingDetailPage extends BaseStatefulWidget {
  DoctorModel data;
  BookingDetailPage(this.data);
  @override
  _BookingDetailPageState createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends BaseState<BookingDetailPage,BookingDetailPresenter> implements BookingDetailContract {
  bool registered = false;

  SharedPreferences _prefs;
  String name;

  @override
  void initMvp() {
    // TODO: implement initMvp
    super.initMvp();
    getDataAccount();
  }

  getDataAccount()async{
    _prefs = await SharedPreferences.getInstance();
    name = _prefs.getString(DefaultKey.Name);
    if (name != null){
      setState(() {
        registered = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: DefaultDimen.spaceLarge,vertical: DefaultDimen.spaceLarge),
        child: GestureDetector(
          onTap: (){
            if (registered){
              push(BookingConfirmPage(widget.data));
            } else {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                  ),
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext bc){
                    return RegisterBottomSheet(widget.data);
                  }
              );
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: DefaultColor.primaryColor,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Buat Janji",
                  style: TextStyle(
                    fontFamily: DefaultFont.PoppinsFont,
                    color: Colors.white,
                    fontSize: 16
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 280,
                decoration: BoxDecoration(
                  color: Colors.grey
                ),
                child: Image.network(
                  widget.data.avatar,
                  fit: BoxFit.cover,
                  height: 280,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 200),
              padding: EdgeInsets.symmetric(horizontal: DefaultDimen.spaceLarge,vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.doctorName,
                    style: TextStyle(
                      fontFamily: DefaultFont.PoppinsFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        DefaultImageLocation.iconStetoskop
                      ),
                      SizedBox(width: 10,),
                      Container(
                        width: MediaQuery.of(context).size.width - 60,
                        child: Text(
                          widget.data.specialist,
                          style: TextStyle(
                            fontFamily: DefaultFont.PoppinsFont,
                            color: Colors.grey
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jadwal",
                        style: TextStyle(
                          fontFamily: DefaultFont.PoppinsFont,
                          fontWeight: FontWeight.bold,
                          color: DefaultColor.primaryColor,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Column(
                        children: widget.data.doctorSchedule.map((e) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.day,
                                style: TextStyle(
                                  fontFamily: DefaultFont.PoppinsFont,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e.hour,
                                    style: TextStyle(
                                      fontFamily: DefaultFont.PoppinsFont,
                                    ),
                                  ),
                                  Text(
                                    e.place,
                                    style: TextStyle(
                                      fontFamily: DefaultFont.PoppinsFont,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Biografi",
                        style: TextStyle(
                          fontFamily: DefaultFont.PoppinsFont,
                          fontWeight: FontWeight.bold,
                          color: DefaultColor.primaryColor,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        widget.data.bio,
                        style: TextStyle(
                          fontFamily: DefaultFont.PoppinsFont,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kredensial",
                        style: TextStyle(
                          fontFamily: DefaultFont.PoppinsFont,
                          fontWeight: FontWeight.bold,
                          color: DefaultColor.primaryColor,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        widget.data.credential,
                        style: TextStyle(
                          fontFamily: DefaultFont.PoppinsFont,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Afliansi Akademik",
                        style: TextStyle(
                          fontFamily: DefaultFont.PoppinsFont,
                          fontWeight: FontWeight.bold,
                          color: DefaultColor.primaryColor,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        widget.data.academicAffiliation,
                        style: TextStyle(
                          fontFamily: DefaultFont.PoppinsFont,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: InkWell(
              onTap: (){
                pop();
              },
              child: Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
