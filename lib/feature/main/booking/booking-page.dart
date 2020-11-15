import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smkdevapp/base/base-state.dart';
import 'package:smkdevapp/constants.dart';
import 'package:smkdevapp/feature/main/booking/booking-presenter.dart';
import 'package:smkdevapp/model/doctor-model.dart';

import 'bookingdetail/booking-detail-page.dart';

class BookingPage extends BaseStatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends BaseState<BookingPage,BookingPresenter> implements BookingContract {

  List<DoctorModel> dataDoctor = [];

  @override
  fetchDoctor(List<DoctorModel> dataDoctor) {
    setState(() {
      this.dataDoctor = dataDoctor;
    });
  }

  @override
  void initMvp() {
    // TODO: implement initMvp
    super.initMvp();
    presenter = BookingPresenter();
    presenter.setView(this);
    presenter.getDoctor();
  }
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
        body: isOnProgress?Container(
          padding: EdgeInsets.symmetric(horizontal: DefaultDimen.spaceLarge,vertical: 20),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context,position){
              return InkWell(
                onTap: (){
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.3),
                            highlightColor: Colors.grey.withOpacity(0.5),
                            period: Duration(milliseconds: 2100),
                            child: Container(
                              width: 60,
                              height: 60,
                              margin: EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                              ),
                            )
                        ),
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                                baseColor: Colors.grey.withOpacity(0.3),
                                highlightColor: Colors.grey.withOpacity(0.5),
                                period: Duration(milliseconds: 2100),
                                child: Container(
                                  width: 150,
                                  height: 20,
                                  margin: EdgeInsets.only(right: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                )
                            ),
                            SizedBox(height: 10,),
                            Shimmer.fromColors(
                                baseColor: Colors.grey.withOpacity(0.3),
                                highlightColor: Colors.grey.withOpacity(0.5),
                                period: Duration(milliseconds: 2100),
                                child: Container(
                                  width: 180,
                                  height: 15,
                                  margin: EdgeInsets.only(right: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                )
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
        ):Container(
          padding: EdgeInsets.symmetric(horizontal: DefaultDimen.spaceLarge,vertical: 20),
          child: ListView.builder(
            itemCount: dataDoctor.length,
            itemBuilder: (context,position){
              return InkWell(
                onTap: (){
                  push(BookingDetailPage(dataDoctor[position]));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40 * (MediaQuery.of(context).size.width / 450),
                          child: CircleAvatar(
                            radius: 40 * (MediaQuery.of(context).size.width / 450),
                            backgroundImage: NetworkImage(dataDoctor[position].avatar),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 300 * (MediaQuery.of(context).size.width / 450),
                              child: Text(
                                dataDoctor[position].doctorName,
                                style: TextStyle(
                                  fontFamily: DefaultFont.PoppinsFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18 * (MediaQuery.of(context).size.width / 450),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              width: 300 * (MediaQuery.of(context).size.width / 450),
                              child: Text(
                                dataDoctor[position].specialist,
                                style: TextStyle(
                                  fontFamily: DefaultFont.PoppinsFont,
                                  fontSize: 14 * (MediaQuery.of(context).size.width / 450)
                                ),
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
