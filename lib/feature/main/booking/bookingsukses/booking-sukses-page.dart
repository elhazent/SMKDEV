import 'package:flutter/material.dart';
import 'package:smkdevapp/base/base-state.dart';
import 'package:smkdevapp/constants.dart';
import 'package:smkdevapp/feature/main/booking/bookingsukses/booking-sukses-presenter.dart';

class BookingSuksesPage extends BaseStatefulWidget {
  @override
  _BookingSuksesPageState createState() => _BookingSuksesPageState();
}

class _BookingSuksesPageState extends BaseState<BookingSuksesPage,BookingSuksesPresenter> implements BookingSuksesContract {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: DefaultDimen.spaceLarge),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: DefaultColor.primaryColor
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 20,),
              Text(
                "Booking Sukses!",
                style: TextStyle(
                  fontFamily: DefaultFont.PoppinsFont,
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 30,),
              Text(
                "Kode booking anda",
                style: TextStyle(
                    fontFamily: DefaultFont.PoppinsFont,
                    color: Colors.white,
                ),
              ),
              SizedBox(height: 20,),
              Text(
                "B123840",
                style: TextStyle(
                    fontFamily: DefaultFont.PoppinsFont,
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 20,),
              Text(
                "Custumer Service kami akan menghubungi anda untuk konfirmasi selanjutnya",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: DefaultFont.PoppinsFont,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 150,
          decoration: BoxDecoration(
            color: DefaultColor.primaryColor
          ),
          padding: EdgeInsets.symmetric(horizontal: DefaultDimen.spaceLarge,vertical: DefaultDimen.spaceLarge),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  push(BookingSuksesPage());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Konfirmasi",
                        style: TextStyle(
                            fontFamily: DefaultFont.PoppinsFont,
                            color: DefaultColor.primaryColor,
                            fontSize: 16
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Tidak, kembali ke home",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: DefaultFont.PoppinsFont,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
