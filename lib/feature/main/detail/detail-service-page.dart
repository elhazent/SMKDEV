
import 'package:flutter/material.dart';
import 'package:smkdevapp/constants.dart';
import 'package:smkdevapp/model/carrier-model.dart';
import 'package:smkdevapp/model/event-model.dart';
import 'package:smkdevapp/model/facility-model.dart';
import 'package:smkdevapp/model/partner-model.dart';
import 'package:smkdevapp/model/promo-model.dart';
import 'package:smkdevapp/widget/detail-image.dart';

class DetailService extends StatelessWidget {
  final FacilityModel facility;
  final EventModel event;
  final PromoModel promo;
  final CarrierModel carrier;
  final PartnerModel partner;
  final dynamic searchResult;
  final dynamic partnerSearchResult;
  final dynamic carrierSearchResult;

  DetailService({
    Key key,
    this.facility ,
    this.event,
    this.promo,
    this.partner,
    this.carrier,
    this.partnerSearchResult,
    this.carrierSearchResult,
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
          title: Text(
            "${
            facility != null ? facility.title :
            event != null ? event.title :
            promo != null ? promo.title :
            partner != null ? partner.name :
            carrier != null ? carrier.titleJob :
            searchResult != null ? searchResult.title :
            partnerSearchResult != null ? partnerSearchResult.name :
            carrierSearchResult != null ? carrierSearchResult.titleJob : "Detail Layanan"
            }",
            style: TextStyle(
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
                                            partner != null ? partner.logo :
                                            carrier != null ? carrier.image :
                                            searchResult != null ? searchResult.image :
                                            partnerSearchResult != null ? partnerSearchResult.logo :
                                            carrierSearchResult != null ? carrierSearchResult.image : ""
                                    )
                              )
                            );
                          },
                          child: Image.network(
                              facility != null ? facility.image :
                              event != null ? event.image :
                              promo != null ? promo.image :
                              partner != null ? partner.logo :
                              carrier != null ? carrier.image :
                              searchResult != null ? searchResult.image :
                              partnerSearchResult != null ? partnerSearchResult.logo :
                              carrierSearchResult != null ? carrierSearchResult.image : "",
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
                              partner != null ? partner.tag :
                              carrier != null ? carrier.tag :
                              searchResult != null ? searchResult.tag :
                              partnerSearchResult != null ? partnerSearchResult.tag :
                              carrierSearchResult != null ? carrierSearchResult.tag : ""
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
                            partner != null ? partner.name :
                            carrier != null ? carrier.titleJob :
                            searchResult != null ? searchResult.title :
                            partnerSearchResult != null ? partnerSearchResult.name :
                            carrierSearchResult != null ? carrierSearchResult.titleJob : ""
                        }",
                        style: TextStyle(
                          color: DefaultColor.textPrimary,
                          fontFamily: DefaultFont.PoppinsFont,
                          fontSize: DefaultDimen.textExtraLarge + 4,
                          fontWeight: DefaultFontWeight.bold
                        ),
                      ),Container(
                        margin: EdgeInsets.only(top: DefaultDimen.spaceSmall),
                        child: Text(
                          "${
                              event != null ? event.date :
                              promo != null ? promo.date :
                              carrier != null ? carrier.date :
                              carrierSearchResult != null ? carrierSearchResult.date : ""
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
                              partner != null ? partner.description :
                              carrier != null ? carrier.description :
                              searchResult != null ? searchResult.description :
                              partnerSearchResult != null ? partnerSearchResult.description :
                              carrierSearchResult != null ? carrierSearchResult.description : ""
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
