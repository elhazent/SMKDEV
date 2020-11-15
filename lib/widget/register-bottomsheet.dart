import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:smkdevapp/base/base-state.dart';
import 'package:smkdevapp/feature/main/booking/bookingdetail/booking-detail-presenter.dart';
import 'package:smkdevapp/model/doctor-model.dart';

import '../constants.dart';

class RegisterBottomSheet extends BaseStatefulWidget {
  DoctorModel data;
  RegisterBottomSheet(this.data);
  @override
  _RegisterBottomSheetState createState() => _RegisterBottomSheetState();
}

class _RegisterBottomSheetState extends BaseState<RegisterBottomSheet,BookingDetailPresenter> implements BookingDetailContract {
  int rggender;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  void initMvp() {
    // TODO: implement initMvp
    super.initMvp();
    presenter = BookingDetailPresenter();
    presenter.setView(this);
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
        ),
        padding: MediaQuery.of(context).viewInsets,
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
                          controller: name,
                          keyboardType: TextInputType.name,
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
                          controller: phone,
                          keyboardType: TextInputType.phone,
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
                          keyboardType: TextInputType.emailAddress,
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
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
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
                      ),
                      SizedBox(width: 20,),
                      Flexible(
                        child: GestureDetector(
                          onTap: (){
                            final pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
                            if (name.text.isEmpty){
                              Flushbar(
                                flushbarPosition: FlushbarPosition.TOP,
                                message: "Nama harus diisi",
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ).show(context);
                            } else if (phone.text.isEmpty){
                              Flushbar(
                                flushbarPosition: FlushbarPosition.TOP,
                                message: "Nomor Handphone harus diisi",
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ).show(context);
                            } else {
                              presenter.postRegister(name.text, rggender , phone.text,widget.data);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                                color: DefaultColor.primaryColor,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                !isOnProgress?Text(
                                  "Daftar",
                                  style: TextStyle(
                                      fontFamily: DefaultFont.PoppinsFont,
                                      color: Colors.white,
                                      fontSize: 16
                                  ),
                                ):Container(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
