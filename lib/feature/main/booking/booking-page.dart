import 'package:flutter/material.dart';
import 'package:smkdevapp/base/base-state.dart';
import 'package:smkdevapp/constants.dart';
import 'package:smkdevapp/feature/main/booking/booking-presenter.dart';

import 'bookingdetail/booking-detail-page.dart';

class BookingPage extends BaseStatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends BaseState<BookingPage,BookingPresenter> implements BookingContract {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Booking",
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontFamily: DefaultFont.PoppinsFont
            ),
          ),
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: DefaultDimen.spaceLarge,vertical: 20),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context,position){
              return InkWell(
                onTap: (){
                  push(BookingDetailPage());
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(DefaultImageLocation.hospitalImage),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Column(
                          children: [
                            Text(
                              "Dokter ${position + 1}",
                              style: TextStyle(
                                  fontFamily: DefaultFont.PoppinsFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "Specialist",
                              style: TextStyle(
                                  fontFamily: DefaultFont.PoppinsFont,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
