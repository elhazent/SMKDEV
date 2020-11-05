import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smkdevapp/base/base-state.dart';
import 'package:smkdevapp/feature/main/services/service-presenter.dart';
import 'package:smkdevapp/model/event-model.dart';
import 'package:smkdevapp/model/facility_model.dart';

import '../../../constants.dart';

class ServicePage extends BaseStatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends BaseState<ServicePage, ServicePresenter> implements ServiceContract{

  List<FacilityModel> serviceFacility = [];
  List<EventModel> event = [];
  FocusNode focusNode = FocusNode();
  bool focused = false;
  bool textChanged = false;
  TextEditingController controller = TextEditingController();
  @override
  void initMvp() {
    super.initMvp();
    presenter = ServicePresenter();
    presenter.setView(this);
    presenter.getServiceFacility();
    focusNode.addListener(() {
      handleFocusChange();
    });
  }
  @override
  void dispose() {
    focusNode.removeListener(() {handleFocusChange();});
    focusNode.dispose();
    super.dispose();
  }

  handleFocusChange(){
    if(focusNode.hasFocus != focused){
      setState(() {
        focused = focusNode.hasFocus;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Layanan",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                color: Colors.black
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(DefaultDimen.spaceSmall),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      focused ? GestureDetector(
                        child: Icon(Icons.arrow_back),
                        onTap: (){
                          setState(() {
                            focused = !focusNode.hasFocus;
                            focusNode.unfocus();
                            controller.text = '';
                            textChanged = false;
                          });
                        },
                      ) : Container(),
                      Container(
                        margin: EdgeInsets.only(left: DefaultDimen.spaceTiny),
                        width: MediaQuery.of(context).size.width * 0.90,
                        padding: EdgeInsets.all(DefaultDimen.spaceSmall),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(DefaultDimen.radius*2)
                        ),
                        child: TextField(
                          focusNode: focusNode,
                          controller: controller,
                          cursorColor: DefaultColor.textPrimary,
                          onChanged: (value){
                            if(value.isNotEmpty){
                              setState(() {
                                textChanged = true;
                              });
                            }else{
                              setState(() {
                                textChanged = false;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top : 0),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Cari...",
                            suffixIcon: textChanged ?
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  controller.text = '';
                                  textChanged = false;
                                });
                              },
                              child: Icon(Icons.close),
                            ) : SizedBox(),
                            suffixStyle: TextStyle(
                              color: DefaultColor.textPrimary,
                            )
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: DefaultDimen.spaceSmall,
                      top: DefaultDimen.spaceSmall,
                      bottom: DefaultDimen.spaceSmall
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Fasilitas & Layanan",
                    style: TextStyle(
                      fontFamily: DefaultFont.PoppinsFont,
                      fontWeight: FontWeight.w500,
                      fontSize: DefaultDimen.textLarge,
                      color: DefaultColor.textPrimary,
                    ),
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: isOnProgress ?
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        direction: ShimmerDirection.ltr,
                        child: Container(
                          height: 230,
                          width: 200,
                          margin: EdgeInsets.all(DefaultDimen.spaceSmall),
                          
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: 230,
                            width: 200,
                            padding: EdgeInsets.all(DefaultDimen.spaceSmall),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.all(Radius.circular(DefaultDimen.radius*2))
                            ),
                          ),
                        ),
                      );
                    },
                  ) :
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: serviceFacility.isEmpty ? 0 : serviceFacility.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 200,
                        margin: EdgeInsets.all(DefaultDimen.spaceSmall),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(DefaultDimen.radius*2),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(serviceFacility[index].image)
                            )
                        ),
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 60,
                          width: 200,
                          padding: EdgeInsets.all(DefaultDimen.spaceTiny),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(DefaultDimen.radius *2),
                                  bottomRight:Radius.circular(DefaultDimen.radius*2))
                          ),
                          child: Text(
                            "${serviceFacility[index].facilityName}",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: DefaultDimen.textMedium,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: DefaultDimen.spaceSmall,
                      top: DefaultDimen.spaceSmall,
                      bottom: DefaultDimen.spaceSmall
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Event",
                    style: TextStyle(
                      fontFamily: DefaultFont.PoppinsFont,
                      fontWeight: FontWeight.w500,
                      fontSize: DefaultDimen.textLarge,
                      color: DefaultColor.textPrimary,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  showServiceFacility(List<FacilityModel> serviceFacility) {
    setState(() {
      this.serviceFacility = serviceFacility;
    });
  }

  @override
  showEvent(List<EventModel> event) {
    setState(() {
      this.event = event;
    });
  }
}
