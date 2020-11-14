import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smkdevapp/base/base-state.dart';
import 'package:smkdevapp/constants.dart';
import 'package:smkdevapp/feature/main/detail/detail-service-page.dart';
import 'package:smkdevapp/feature/main/partner/partner-carrier-presenter.dart';
import 'package:smkdevapp/model/carrier-model.dart';
import 'package:smkdevapp/model/partner-model.dart';
import 'package:smkdevapp/widget/empty-state.dart';

class PartnerCarrierPage extends BaseStatefulWidget {
  @override
  _PartnerCarrierPageState createState() => _PartnerCarrierPageState();
}

class _PartnerCarrierPageState extends BaseState<PartnerCarrierPage, PartnerCarrierPresenter> implements PartnerCarrierContract {

  PartnerCarrierPresenter presenter;
  List<PartnerModel> partners = [];
  List<CarrierModel> carriers = [];
  List<dynamic> searchPartnerResult = [];
  List<dynamic> searchCarrierResult = [];
  FocusNode partnerFocus = FocusNode();
  FocusNode carrierFocus = FocusNode();
  bool focusedPartner = false;
  bool focusedCarrier = false;
  bool textChangedPartner = false;
  bool textChangedCarrier = false;
  TextEditingController partnerSearch = TextEditingController();
  TextEditingController carrierSearch = TextEditingController();

  @override
  void initMvp() {
    super.initMvp();
    presenter = PartnerCarrierPresenter();
    presenter.setView(this);
    presenter.getPartner();
    presenter.getCarrier();

    partnerFocus.addListener(() {
      handlePartnerFocus();
    });
    carrierFocus.addListener(() {
      handleCarrierFocus();
    });
  }
  @override
  void dispose() {
    partnerFocus.removeListener(() {handlePartnerFocus();});
    carrierFocus.removeListener(() {handleCarrierFocus();});
    partnerFocus.dispose();
    carrierFocus.dispose();
    super.dispose();
  }

  handlePartnerFocus(){
    if(partnerFocus.hasFocus != focusedPartner){
      setState(() {
        focusedPartner = partnerFocus.hasFocus;
      });
    }
  }

  handleCarrierFocus(){
    if(carrierFocus.hasFocus != focusedCarrier){
      setState(() {
        focusedCarrier = carrierFocus.hasFocus;
      });
    }
  }

  onSearchPartner(){
    for(int i=0; i < partners.length; i++){
      var item = partners[i];
      if (
      item.name.toLowerCase().contains(partnerSearch.text.toLowerCase()) ||
          item.description.toLowerCase().contains(partnerSearch.text.toLowerCase())
      ) {
        searchPartnerResult.clear();
        searchPartnerResult.add(item);
      }
    }
  }

  onSearchCarrier(){
    for(int i=0; i < carriers.length; i++){
      var item = carriers[i];
      if (
      item.titleJob.toLowerCase().contains(carrierSearch.text.toLowerCase()) ||
          item.description.toLowerCase().contains(carrierSearch.text.toLowerCase())
      ) {
        searchCarrierResult.clear();
        searchCarrierResult.add(item);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Partner & Carrier",
          style: TextStyle(
              fontFamily: DefaultFont.PoppinsFont,
              fontSize: 24,
              color: Colors.black
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(DefaultDimen.spaceLarge),
          child: Column(
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(DefaultDimen.spaceSmall, DefaultDimen.spaceSmall, 0, DefaultDimen.spaceSmall),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    focusedPartner ? GestureDetector(
                      child: Icon(Icons.arrow_back, size: DefaultDimen.textExtraLarge + 12,),
                      onTap: (){
                        setState(() {
                          focusedPartner = !partnerFocus.hasFocus;
                          partnerFocus.unfocus();
                          partnerSearch.text = '';
                          textChangedPartner = false;
                          searchPartnerResult.clear();
                        });
                      },
                    ) : Container(),
                    Container(
                      // margin: EdgeInsets.only(left: DefaultDimen.spaceTiny),
                      width: MediaQuery.of(context).size.width * 0.80,
                      padding: EdgeInsets.all(DefaultDimen.spaceSmall),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(DefaultDimen.radius*2)
                      ),
                      child: TextField(
                        focusNode: partnerFocus,
                        controller: partnerSearch,
                        cursorColor: DefaultColor.textPrimary,
                        onChanged: (value){
                          if(value.isNotEmpty){
                            onSearchPartner();
                            setState(() {
                              textChangedPartner = true;
                            });
                          }else{
                            setState(() {
                              textChangedPartner = false;
                            });
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top : 0),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Cari Partner",
                            suffixIcon: textChangedPartner ?
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  partnerSearch.text = '';
                                  textChangedPartner = false;
                                  searchPartnerResult.clear();
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
              searchPartnerResult.isEmpty ? SizedBox() :
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.width * 80,
                  child: ListView.builder(
                    itemCount: searchPartnerResult.isEmpty ? 0 : searchPartnerResult.length,
                    itemBuilder: (context, index){
                      return Container(
                        padding: EdgeInsets.all(DefaultDimen.spaceMidLarge),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailService(
                                      partnerSearchResult: searchPartnerResult[index],
                                    )
                                )
                            );
                          },
                          child: Text(
                            "${
                                searchPartnerResult[index].name != null ? searchPartnerResult[index].name : ""
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
                  "Partner",
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
                ) : partners.isEmpty ?
                EmptyItem() :
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: partners.isEmpty ? 0 : partners.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailService(partner: partners[index],)
                          )
                        );
                      },
                      child: Container(
                        width: 200,
                        margin: EdgeInsets.all(DefaultDimen.spaceSmall),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(DefaultDimen.radius*2),
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(partners[index].logo)
                            )
                        ),
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          alignment: Alignment.center,
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
                            "${partners[index].name}",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: DefaultFontWeight.semiBold,
                              fontSize: DefaultDimen.textLarge,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(DefaultDimen.spaceSmall, DefaultDimen.spaceSmall, 0, DefaultDimen.spaceSmall),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    focusedCarrier ? GestureDetector(
                      child: Icon(Icons.arrow_back, size: DefaultDimen.textExtraLarge + 12,),
                      onTap: (){
                        setState(() {
                          focusedCarrier = !carrierFocus.hasFocus;
                          carrierFocus.unfocus();
                          carrierSearch.text = '';
                          textChangedCarrier = false;
                          searchCarrierResult.clear();
                        });
                      },
                    ) : Container(),
                    Container(
                      // margin: EdgeInsets.only(left: DefaultDimen.spaceTiny),
                      width: MediaQuery.of(context).size.width * 0.80,
                      padding: EdgeInsets.all(DefaultDimen.spaceSmall),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(DefaultDimen.radius*2)
                      ),
                      child: TextField(
                        focusNode: carrierFocus,
                        controller: carrierSearch,
                        cursorColor: DefaultColor.textPrimary,
                        onChanged: (value){
                          if(value.isNotEmpty){
                            onSearchCarrier();
                            setState(() {
                              textChangedCarrier = true;
                            });
                          }else{
                            setState(() {
                              textChangedCarrier = false;
                            });
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top : 0),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Cari Lowongan kerja",
                            suffixIcon: textChangedCarrier ?
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  carrierSearch.text = '';
                                  textChangedCarrier = false;
                                  searchCarrierResult.clear();
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
              searchCarrierResult.isEmpty ? SizedBox() :
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.width * 80,
                  child: ListView.builder(
                    itemCount: searchCarrierResult.isEmpty ? 0 : searchCarrierResult.length,
                    itemBuilder: (context, index){
                      return Container(
                        padding: EdgeInsets.all(DefaultDimen.spaceMidLarge),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailService(
                                      carrierSearchResult: searchCarrierResult[index],
                                    )
                                )
                            );
                          },
                          child: Text(
                            "${
                                searchCarrierResult[index].titleJob != null ? searchCarrierResult[index].titleJob : ""
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
                  "Lowongan Kerja",
                  style: TextStyle(
                    fontFamily: DefaultFont.PoppinsFont,
                    fontWeight: DefaultFontWeight.bold,
                    fontSize: DefaultDimen.textLarge,
                    color: DefaultColor.textPrimary,
                  ),
                ),
              ),
              SizedBox(
                height: carriers.isEmpty ? (250*5).toDouble() : (250*carriers.length).toDouble(),
                child: isOnProgress ?
                ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.vertical,
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
                ) : carriers.isEmpty ?
                EmptyItem() :
                Column(
                  children: carriers.map((carriers) =>
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailService(carrier: carriers,)
                              )
                          );
                        },
                        child: (
                            Container(
                                margin: EdgeInsets.all(DefaultDimen.spaceSmall),
                                decoration: BoxDecoration(
                                  color: Colors.white,
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
                                              image: NetworkImage(carriers.image)
                                          )
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.all(DefaultDimen.spaceSmall),
                                            child: Text(
                                              "${carriers.tag}",
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
                                              "${carriers.date}",
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
                                          "${carriers.titleJob}",
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
                      )
                  ).toList(),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  showCarrier(List<CarrierModel> carrier) {
    setState(() {
      carriers = carrier;
    });
  }

  @override
  showPartner(List<PartnerModel> partner) {
    setState(() {
      partners = partner;
    });
  }
}
