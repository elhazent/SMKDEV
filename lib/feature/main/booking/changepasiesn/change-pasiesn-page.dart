import 'package:flutter/material.dart';
import 'package:smkdevapp/base/base-state.dart';
import 'package:smkdevapp/feature/main/booking/changepasiesn/change-pasiesn-presenter.dart';

import '../../../../constants.dart';

class ChangePasiesnPage extends BaseStatefulWidget {
  @override
  _ChangePasiesnPageState createState() => _ChangePasiesnPageState();
}

class _ChangePasiesnPageState extends BaseState<ChangePasiesnPage,ChangePasiesnPresenter> implements ChangePasiesnContract {
  List<bool> pasiensnCheck = [];
  int rggender;


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
                                                "Tambah Info Pasien",
                                                style: TextStyle(
                                                    fontFamily: DefaultFont.PoppinsFont,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: DefaultColor.primaryColor
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
                                                  "Status",
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
                                                        hintText: "Status",
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
                                ),
                              );
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
