import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smkdevapp/base/base-state.dart';
import 'package:smkdevapp/feature/main/booking/bookingconfirm/booking-confirm-page.dart';
import 'package:smkdevapp/feature/main/booking/bookingdetail/booking-detail-presenter.dart';

import '../../../../constants.dart';

class BookingDetailPage extends BaseStatefulWidget {
  @override
  _BookingDetailPageState createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends BaseState<BookingDetailPage,BookingDetailPresenter> implements BookingDetailContract {
  int rggender;
  bool registered = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: DefaultDimen.spaceLarge,vertical: DefaultDimen.spaceLarge),
        child: GestureDetector(
          onTap: (){
            if (registered){
              push(BookingConfirmPage());
            } else {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                  ),
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext bc){
                    return Container(
                      decoration: BoxDecoration(
                      ),
                      child: new Wrap(
                        children: <Widget>[
                          Container(
                            margin:EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    height: 5,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.3)
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Container(
                                  child: Text(
                                    "Maaf, anda belum terdaftar dalam aplikasi. Harap daftar terlebih dahulu untuk dapat membooking jadwal dengan dokter yang bersangkutan",
                                    style: TextStyle(
                                        fontFamily: DefaultFont.PoppinsFont
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nama",
                                      style: TextStyle(
                                          fontFamily: DefaultFont.PoppinsFont,
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.withOpacity(0.5)),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 16),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            hintText: "Nama",
                                            border: InputBorder.none
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Jenis Kelamin",
                                      style: TextStyle(
                                          fontFamily: DefaultFont.PoppinsFont,
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: <Widget>[
                                            Radio(
                                              groupValue: rggender,
                                              activeColor: DefaultColor.secondaryColor,
                                              onChanged: (value){
                                                setState(() {
                                                  rggender = value;
                                                  print("QA 1 : $value");
                                                });
                                              },
                                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              value: 1,
                                            ),
                                            Text(
                                              "Laki Laki",
                                              style: TextStyle(
                                                fontFamily: DefaultFont.PoppinsFont,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 20,),
                                        Row(
                                          children: <Widget>[
                                            Radio(
                                              groupValue: rggender,
                                              activeColor: DefaultColor.secondaryColor,
                                              onChanged: (value){
                                                setState(() {
                                                  rggender = value;
                                                  print("QA 1 : $value");
                                                });
                                              },
                                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              value: 0,
                                            ),
                                            Text(
                                              "Perempuan",
                                              style: TextStyle(
                                                fontFamily: DefaultFont.PoppinsFont,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "No Handphone",
                                      style: TextStyle(
                                          fontFamily: DefaultFont.PoppinsFont,
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.withOpacity(0.5)),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 16),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            hintText: "No Handphone",
                                            border: InputBorder.none
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Email",
                                      style: TextStyle(
                                          fontFamily: DefaultFont.PoppinsFont,
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.withOpacity(0.5)),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 16),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            hintText: "Email",
                                            border: InputBorder.none
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 15),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Batal",
                                              style: TextStyle(
                                                  fontFamily: DefaultFont.PoppinsFont,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 15),
                                        decoration: BoxDecoration(
                                            color: DefaultColor.primaryColor,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Daftar",
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
                                  ],
                                ),
                                SizedBox(height: 20,),

                              ],
                            ),
                          ),
                        ],
                      ),
                    );
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
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey
                  ),
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
                    "Dokter 1",
                    style: TextStyle(
                      fontFamily: DefaultFont.PoppinsFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      SvgPicture.asset(
                        DefaultImageLocation.iconStetoskop
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "Umum",
                        style: TextStyle(
                          fontFamily: DefaultFont.PoppinsFont,
                          color: Colors.grey
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Senin",
                            style: TextStyle(
                              fontFamily: DefaultFont.PoppinsFont,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "08.00-14.00 WIB",
                                style: TextStyle(
                                  fontFamily: DefaultFont.PoppinsFont,
                                ),
                              ),
                              Text(
                                "RS SMKDEV",
                                style: TextStyle(
                                  fontFamily: DefaultFont.PoppinsFont,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Senin",
                            style: TextStyle(
                              fontFamily: DefaultFont.PoppinsFont,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "08.00-14.00 WIB",
                                style: TextStyle(
                                  fontFamily: DefaultFont.PoppinsFont,
                                ),
                              ),
                              Text(
                                "RS SMKDEV",
                                style: TextStyle(
                                  fontFamily: DefaultFont.PoppinsFont,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Senin",
                            style: TextStyle(
                              fontFamily: DefaultFont.PoppinsFont,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "08.00-14.00 WIB",
                                style: TextStyle(
                                  fontFamily: DefaultFont.PoppinsFont,
                                ),
                              ),
                              Text(
                                "RS SMKDEV",
                                style: TextStyle(
                                  fontFamily: DefaultFont.PoppinsFont,
                                ),
                              ),
                            ],
                          ),
                        ],
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
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
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
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
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
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
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
