import 'package:flutter/material.dart';
import 'package:smkdevapp/base/base-function.dart';
import 'package:smkdevapp/base/base-state.dart';
import 'package:smkdevapp/constants.dart';
import 'package:smkdevapp/feature/main/booking/bookingconfirm/booking-confirm-presenter.dart';
import 'package:smkdevapp/feature/main/booking/bookingsukses/booking-sukses-page.dart';
import 'package:smkdevapp/feature/main/booking/changepasiesn/change-pasiesn-page.dart';
import 'package:smkdevapp/model/doctor-model.dart';

class BookingConfirmPage extends BaseStatefulWidget {
  DoctorModel data;
  BookingConfirmPage(this.data);
  @override
  _BookingConfirmPageState createState() => _BookingConfirmPageState();
}

class _BookingConfirmPageState extends BaseState<BookingConfirmPage,BookingConfirmPresenter>implements BookingConfirmContract {

  String date = BaseFunction.milliToShortDate(DateTime.now().millisecondsSinceEpoch);
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Booking Confirm",
            style: TextStyle(
              fontFamily: DefaultFont.PoppinsFont,
              fontSize: 24,
              color: Colors.black
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: DefaultDimen.spaceLarge),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40 * (MediaQuery.of(context).size.width / 450),
                            child: CircleAvatar(
                              radius: 40 * (MediaQuery.of(context).size.width / 450),
                              backgroundImage: NetworkImage(widget.data.avatar),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width:300 * (MediaQuery.of(context).size.width / 450),
                                child: Text(
                                  widget.data.doctorName,
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
                                  widget.data.specialist,
                                  style: TextStyle(
                                    fontFamily: DefaultFont.PoppinsFont,
                                    fontSize: 14* (MediaQuery.of(context).size.width / 450)
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
                ),
                Divider(
                  thickness: 4,
                  color: Colors.grey.withOpacity(0.2),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: DefaultDimen.spaceLarge,vertical: 10),
                  child: Text(
                    "Booking Detail",
                    style: TextStyle(
                      fontFamily: DefaultFont.PoppinsFont,
                      fontWeight: FontWeight.bold,
                      color: DefaultColor.primaryColor,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: DefaultDimen.spaceLarge,vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Booking Untuk",
                            style: TextStyle(
                              fontFamily: DefaultFont.PoppinsFont,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              push(ChangePasiesnPage());
                            },
                            child: Text(
                              "Ganti Pasien",
                              style: TextStyle(
                                fontFamily: DefaultFont.PoppinsFont,
                                color: DefaultColor.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Nama : Bambang Santoso",
                        style: TextStyle(
                          fontFamily: DefaultFont.PoppinsFont,
                        ),
                      ),
                      Text(
                        "Jenis Kelamin : Laki Laki",
                        style: TextStyle(
                          fontFamily: DefaultFont.PoppinsFont,
                        ),
                      ),
                      Text(
                        "Status : Saya Sendiri",
                        style: TextStyle(
                          fontFamily: DefaultFont.PoppinsFont,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                  ),
                  padding: EdgeInsets.symmetric(horizontal: DefaultDimen.spaceLarge,vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Booking Tanggal",
                            style: TextStyle(
                              fontFamily: DefaultFont.PoppinsFont,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap:()async{
                              final DateTime picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (picked != null && picked != selectedDate)
                                setState(() {
                                  selectedDate = picked;
                                  date = BaseFunction.milliToShortDate(selectedDate.millisecondsSinceEpoch);
                                });
                            },
                            child: Row(
                              children: [
                                Text(
                                  date,
                                  style: TextStyle(
                                    fontFamily: DefaultFont.PoppinsFont,
                                    color: Colors.orange
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Icon(
                                  Icons.calendar_today,
                                  color: DefaultColor.primaryColor,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: DefaultDimen.spaceLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pesan",
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
                          maxLines: 5,
                          decoration: InputDecoration(
                              hintText: "Pesan",
                              border: InputBorder.none
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: DefaultDimen.spaceLarge,vertical: DefaultDimen.spaceLarge),
          child: GestureDetector(
            onTap: (){
              push(BookingSuksesPage());
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
                    "Konfirmasi",
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
      ),
    );
  }
}
