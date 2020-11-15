import 'package:flutter/material.dart';
import 'package:smkdevapp/base/base-state.dart';
import 'package:smkdevapp/feature/main/booking/changepasiesn/change-pasiesn-presenter.dart';
import 'package:smkdevapp/widget/pasien-bottomsheet.dart';

import '../../../../constants.dart';

class ChangePasiesnPage extends BaseStatefulWidget {
  @override
  _ChangePasiesnPageState createState() => _ChangePasiesnPageState();
}

class _ChangePasiesnPageState extends BaseState<ChangePasiesnPage,ChangePasiesnPresenter> implements ChangePasiesnContract {
  List<bool> pasiensnCheck = [];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Ganti Pasien",
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
        body: Container(
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context,position){
              pasiensnCheck.add(false);
              return InkWell(
                onTap: (){
                  setState(() {
                    setState(() {
                      this.pasiensnCheck[position] = !pasiensnCheck[position];
                    });
                  });
                },
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                          pasiensnCheck[position]?Icon(
                            Icons.check_circle,
                            color: DefaultColor.primaryColor,
                          ):Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    position == 3?GestureDetector(
                      onTap: (){
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                            ),
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext bc){
                              return PasientBottomSheet();
                            }
                        );
                      },
                      child: Center(
                        child: Text(
                          "Tambah Baru",
                          style: TextStyle(
                            fontFamily: DefaultFont.PoppinsFont,
                            color: DefaultColor.primaryColor
                          ),
                        ),
                      ),
                    ):SizedBox()
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
