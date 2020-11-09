
import 'package:flutter/material.dart';
import 'package:smkdevapp/constants.dart';
import 'package:smkdevapp/model/event-model.dart';
import 'package:smkdevapp/model/facility-model.dart';
import 'package:smkdevapp/model/promo-model.dart';
import 'package:smkdevapp/widget/detail-image.dart';

class DetailService extends StatelessWidget {
  final FacilityModel facility;
  final EventModel event;
  final PromoModel promo;
  final dynamic searchResult;
  DetailService({
    Key key,
    this.facility ,
    this.event,
    this.promo,
    this.searchResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back,
              color: DefaultColor.textPrimary,
            ),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          title: Text("${
          facility != null ? facility.title :
              event != null ? event.title :
                  promo != null ? promo.title :
                      searchResult != null ? searchResult.title :
                      "Detail Layanan"
          }", style: TextStyle(
            color: DefaultColor.textPrimary,
            fontFamily: DefaultFont.PoppinsFont,
            fontSize: 24
          ),),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Hero(
                      tag: "imageHero",
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailImage(
                                        url: facility != null ? facility.image :
                                        event != null ? event.image :
                                          promo != null ? promo.image :
                                            searchResult != null ? searchResult.image : ""
                                    )
                              )
                            );
                          },
                          child: Image.network(
                              facility != null ? facility.image :
                              event != null ? event.image :
                                promo != null ? promo.image :
                                  searchResult != null ? searchResult.image : "",
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(DefaultDimen.spaceExtraLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${
                              facility != null ? facility.tag :
                                  event != null ? event.tag :
                                      promo != null ? promo.tag:
                                          searchResult != null ? searchResult.tag : ""
                          }",
                          style: TextStyle(
                            color: DefaultColor.primaryColor,
                            fontFamily: DefaultFont.PoppinsFont,
                            fontSize: DefaultDimen.textLarge,
                          ),
                      ),
                      Text(
                        "${
                            facility != null ? facility.title :
                                event != null ? event.title :
                                    promo != null ? promo.title :
                                        searchResult != null ? searchResult.title : ""
                        }",
                        style: TextStyle(
                          color: DefaultColor.textPrimary,
                          fontFamily: DefaultFont.PoppinsFont,
                          fontSize: DefaultDimen.textExtraLarge + 4,
                          fontWeight: FontWeight.w500
                        ),
                      ),Container(
                        margin: EdgeInsets.only(top: DefaultDimen.spaceSmall),
                        child: Text(
                          "${
                              event != null ? event.date :
                              promo != null ? promo.date : ""
                          }",
                          style: TextStyle(
                              color: Colors.grey.withOpacity(0.8),
                              fontFamily: DefaultFont.PoppinsFont,
                              fontSize: DefaultDimen.textMedium,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: DefaultDimen.spaceLarge),
                        child: Text(
                          "${
                              facility != null ? facility.description :
                                  event != null ? event.description :
                                      promo != null ? promo.description :
                                          searchResult != null ? searchResult.description : ""
                          }",
                          style: TextStyle(
                            color: DefaultColor.textPrimary,
                            fontFamily: DefaultFont.PoppinsFont,
                            fontSize: DefaultDimen.textLarge,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
