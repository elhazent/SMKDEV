import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smkdevapp/base/base-state.dart';
import 'package:smkdevapp/feature/main/detail/detail-service-page.dart';
import 'package:smkdevapp/feature/main/services/service-presenter.dart';
import 'package:smkdevapp/model/event-model.dart';
import 'package:smkdevapp/model/facility-model.dart';
import 'package:smkdevapp/model/promo-model.dart';
import 'package:smkdevapp/widget/empty-state.dart';

import '../../../constants.dart';

class ServicePage extends BaseStatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends BaseState<ServicePage, ServicePresenter> implements ServiceContract{

  List<FacilityModel> serviceFacility = [];
  List<EventModel> event = [];
  List<PromoModel> promo =[];
  List<dynamic> searchResult = [];
  FocusNode focusNode = FocusNode();
  bool focused = false;
  bool textChanged = false;
  TextEditingController querySearch = TextEditingController();
  @override
  void initMvp() {
    super.initMvp();
    presenter = ServicePresenter();
    presenter.setView(this);
    presenter.getServiceFacility();
    presenter.getPromo();
    presenter.getEvent();

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

  onSearchData(){
    for(int i=0; i < serviceFacility.length; i++){
      var item = serviceFacility[i];
      if (
      item.title.toLowerCase().contains(querySearch.text.toLowerCase()) ||
      item.title.toLowerCase().contains(querySearch.text.toLowerCase())
      ) {
        searchResult.clear();
        searchResult.add(item);
      }
    }
    for(int i=0; i < event.length; i++){
      var item = event[i];
      if (
      item.title.toLowerCase().contains(querySearch.text.toLowerCase()) ||
      item.description.toLowerCase().contains(querySearch.text.toLowerCase())
      ) {
        searchResult.clear();
        searchResult.add(item);
      }
    }
    for(int i=0; i < promo.length; i++){
      var item = promo[i];
      if (
      item.title.toLowerCase().contains(querySearch.text.toLowerCase()) ||
          item.description.toLowerCase().contains(querySearch.text.toLowerCase())
      ) {
        searchResult.clear();
        searchResult.add(item);
      }
    }
  }

  loadAllData(){
    presenter.getServiceFacility();
    presenter.getEvent();
    presenter.getPromo();
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
            margin: EdgeInsets.symmetric(horizontal: DefaultDimen.spaceLarge),
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.fromLTRB(DefaultDimen.spaceSmall, DefaultDimen.spaceSmall, 0, DefaultDimen.spaceSmall),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      focused ? GestureDetector(
                        child: Icon(Icons.arrow_back, size: DefaultDimen.textExtraLarge + 12,),
                        onTap: (){
                          setState(() {
                            focused = !focusNode.hasFocus;
                            focusNode.unfocus();
                            querySearch.text = '';
                            textChanged = false;
                            searchResult.clear();
                          });
                        },
                      ) : Container(),
                      Container(
                        // margin: EdgeInsets.only(left: DefaultDimen.spaceTiny),
                        width: MediaQuery.of(context).size.width * 0.85,
                        padding: EdgeInsets.all(DefaultDimen.spaceSmall),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(DefaultDimen.radius*2)
                        ),
                        child: TextField(
                          focusNode: focusNode,
                          controller: querySearch,
                          cursorColor: DefaultColor.textPrimary,
                          onChanged: (value){
                            if(value.isNotEmpty){
                              onSearchData();
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
                            hintText: "Cari",
                            suffixIcon: textChanged ?
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  querySearch.text = '';
                                  textChanged = false;
                                  searchResult.clear();
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
                searchResult.isEmpty ? SizedBox() :
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.width * 80,
                    child: ListView.builder(
                      itemCount: searchResult.isEmpty ? 0 : searchResult.length,
                      itemBuilder: (context, index){
                        return Container(
                          padding: EdgeInsets.all(DefaultDimen.spaceMidLarge),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailService(
                                        searchResult: searchResult[index],
                                      )
                                  )
                              );
                            },
                            child: Text(
                              "${
                                searchResult[index].title != null ? searchResult[index].title :
                                searchResult[index].title != null ? searchResult[index].title : ""
                              }",
                              style: TextStyle(
                                fontFamily: DefaultFont.PoppinsFont,
                                fontSize: DefaultDimen.textLarge,
                             ),
                            ),
                          ),
                        );
                      },
                    ),
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
                      fontWeight: DefaultFontWeight.bold,
                      fontSize: DefaultDimen.textLarge,
                      color: DefaultColor.textPrimary,
                    ),
                  ),
                ),
                SizedBox(
                  height: 265,
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
                  ) : serviceFacility.isEmpty ?
                  EmptyItem() :
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: serviceFacility.isEmpty ? 0 : serviceFacility.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailService(facility: serviceFacility[index],)
                            )
                          );
                        },
                        child: Container(
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
                              "${serviceFacility[index].title}",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: DefaultDimen.textMedium,
                                color: Colors.white,
                              ),
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
                      fontWeight: DefaultFontWeight.bold,
                      fontSize: DefaultDimen.textLarge,
                      color: DefaultColor.textPrimary,
                    ),
                  ),
                ),
                SizedBox(
                  height: 265,
                  child: isOnProgress ?
                  ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        direction: ShimmerDirection.ltr,
                        child: Card(
                          elevation: 1,
                          child: (
                              Container(
                                  width: MediaQuery.of(context).size.width * 0.80,
                                  margin: EdgeInsets.all(DefaultDimen.spaceSmall),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(DefaultDimen.radius *2),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(DefaultDimen.radius*2),
                                                topRight: Radius.circular(DefaultDimen.radius*2)),
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.all(DefaultDimen.spaceSmall),
                                          child: Text(
                                            "",
                                            style: TextStyle(
                                                fontFamily: DefaultFont.PoppinsFont,
                                                color: DefaultColor.primaryColor
                                            ),
                                          )
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                            bottom : DefaultDimen.spaceSmall,
                                            left: DefaultDimen.spaceSmall,
                                          ),
                                          child: Text(
                                            "",
                                            style: TextStyle(
                                                fontSize: DefaultDimen.textMedium,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: DefaultFont.PoppinsFont,
                                                color: DefaultColor.textPrimary
                                            ),
                                          )
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: DefaultDimen.spaceSmall
                                          ),
                                          child: Text(
                                            "",
                                            style: TextStyle(
                                                fontFamily: DefaultFont.PoppinsFont,
                                                color: DefaultColor.textPrimary
                                            ),
                                          )
                                      )
                                    ],
                                  )
                              )
                          ),
                        )
                      );
                    },
                  ) : event.isEmpty ?
                  EmptyItem() :
                  ListView.builder(
                    itemCount: event.isEmpty ? 0 : event.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailService(event: event[index],)
                            )
                          );
                        },
                        child: (
                            Container(
                              width: MediaQuery.of(context).size.width * 0.80,
                              margin: EdgeInsets.all(DefaultDimen.spaceSmall),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(DefaultDimen.radius *2),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(DefaultDimen.radius*2),
                                          topRight: Radius.circular(DefaultDimen.radius*2)),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(event[index].image)
                                      )
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(DefaultDimen.spaceSmall),
                                        child: Text(
                                          "${event[index].tag}",
                                          style: TextStyle(
                                              fontFamily: DefaultFont.PoppinsFont,
                                              color: DefaultColor.primaryColor
                                          ),
                                        )
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                              right: DefaultDimen.spaceSmall
                                          ),
                                          child: Text(
                                            "${event[index].date}",
                                            style: TextStyle(
                                                fontFamily: DefaultFont.PoppinsFont,
                                                color: DefaultColor.textPrimary
                                            ),
                                          )
                                      )
                                    ],
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                        bottom : DefaultDimen.spaceSmall,
                                        left: DefaultDimen.spaceSmall,
                                      ),
                                      child: Text(
                                        "${event[index].title}",
                                        style: TextStyle(
                                            fontSize: DefaultDimen.textMedium,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: DefaultFont.PoppinsFont,
                                            color: DefaultColor.textPrimary
                                        ),
                                      )
                                  ),
                                ],
                              )
                            )
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
                    "Promo",
                    style: TextStyle(
                      fontFamily: DefaultFont.PoppinsFont,
                      fontWeight: DefaultFontWeight.bold,
                      fontSize: DefaultDimen.textLarge,
                      color: DefaultColor.textPrimary,
                    ),
                  ),
                ),
                SizedBox(
                  height: 265,
                  child: isOnProgress ?
                  ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[100],
                          direction: ShimmerDirection.ltr,
                          child: Card(
                            elevation: 1,
                            child: (
                                Container(
                                    width: MediaQuery.of(context).size.width * 0.80,
                                    margin: EdgeInsets.all(DefaultDimen.spaceSmall),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(DefaultDimen.radius *2),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 150,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(DefaultDimen.radius*2),
                                                topRight: Radius.circular(DefaultDimen.radius*2)),
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.all(DefaultDimen.spaceSmall),
                                            child: Text(
                                              "",
                                              style: TextStyle(
                                                  fontFamily: DefaultFont.PoppinsFont,
                                                  color: DefaultColor.primaryColor
                                              ),
                                            )
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                              bottom : DefaultDimen.spaceSmall,
                                              left: DefaultDimen.spaceSmall,
                                            ),
                                            child: Text(
                                              "",
                                              style: TextStyle(
                                                  fontSize: DefaultDimen.textMedium,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: DefaultFont.PoppinsFont,
                                                  color: DefaultColor.textPrimary
                                              ),
                                            )
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: DefaultDimen.spaceSmall
                                            ),
                                            child: Text(
                                              "",
                                              style: TextStyle(
                                                  fontFamily: DefaultFont.PoppinsFont,
                                                  color: DefaultColor.textPrimary
                                              ),
                                            )
                                        )
                                      ],
                                    )
                                )
                            ),
                          )
                      );
                    },
                  ) : promo.isEmpty ?
                  EmptyItem() :
                  ListView.builder(
                    itemCount: promo.isEmpty ? 0 : promo.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailService(promo: promo[index],)
                            )
                          );
                        },
                        child: (
                            Container(
                                width: MediaQuery.of(context).size.width * 0.80,
                                margin: EdgeInsets.all(DefaultDimen.spaceSmall),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(DefaultDimen.radius *2),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(DefaultDimen.radius*2),
                                              topRight: Radius.circular(DefaultDimen.radius*2)),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(promo[index].image)
                                          )
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.all(DefaultDimen.spaceSmall),
                                            child: Text(
                                              "${promo[index].tag}",
                                              style: TextStyle(
                                                  fontFamily: DefaultFont.PoppinsFont,
                                                  color: DefaultColor.primaryColor
                                              ),
                                            )
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                right: DefaultDimen.spaceSmall
                                            ),
                                            child: Text(
                                              "${promo[index].date}",
                                              style: TextStyle(
                                                  fontFamily: DefaultFont.PoppinsFont,
                                                  color: DefaultColor.textPrimary
                                              ),
                                            )
                                        )
                                      ],
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                          bottom : DefaultDimen.spaceSmall,
                                          left: DefaultDimen.spaceSmall,
                                        ),
                                        child: Text(
                                          "${promo[index].title}",
                                          style: TextStyle(
                                              fontSize: DefaultDimen.textMedium,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: DefaultFont.PoppinsFont,
                                              color: DefaultColor.textPrimary
                                          ),
                                        )
                                    ),
                                  ],
                                )
                            )
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: DefaultDimen.spaceSmall,)
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

  @override
  showPromo(List<PromoModel> promo) {
    setState(() {
      this.promo = promo;
    });
  }
}
