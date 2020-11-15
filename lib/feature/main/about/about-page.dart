
import 'package:flutter/material.dart';
import 'package:smkdevapp/base/base-state.dart';
import 'package:smkdevapp/feature/main/about/about-presenter.dart';
import 'package:smkdevapp/model/about-model.dart';
import 'package:smkdevapp/model/office-model.dart';
import 'package:smkdevapp/widget/detail-image.dart';
import 'package:smkdevapp/widget/empty-state.dart';

import '../../../constants.dart';

class AboutPage extends BaseStatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends BaseState<AboutPage, AboutPresenter> implements AboutContract {
  AboutModel abouts;
  List<OfficeModel> offices = [];

  @override
  void initMvp() {
    super.initMvp();
    presenter = AboutPresenter();
    presenter.setView(this);
    presenter.getDetailAbout();
    presenter.getOffice();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Tentang Kami",
            style: TextStyle(
                fontFamily: DefaultFont.PoppinsFont,
                fontSize: 24,
                color: Colors.black
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: isOnProgress ? Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: DefaultDimen.spaceLarge),
            height: MediaQuery.of(context).size.height * 0.80,
            child: Container(
                height: 30,
                width: 30,
                child: CircularProgressIndicator()
            ),
          ) : abouts != null ?
          Container(
            child: Column(
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
                                builder: (context) => DetailImage(
                                  url: abouts.image,
                                )
                              )
                            );
                          },
                          child: Image.network(abouts.image,
                          fit: BoxFit.cover,
                          )
                        ),
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(DefaultDimen.spaceLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(vertical: DefaultDimen.spaceLarge),
                          child : Text(
                            "Sekilas tentang RS SMKDEV",
                            style: TextStyle(
                                fontWeight: DefaultFontWeight.bold,
                                fontFamily: DefaultFont.PoppinsFont,
                                fontSize: DefaultDimen.textLarge,
                                color: DefaultColor.primaryColor
                            ),
                          )
                      ),
                      Container(
                          margin: EdgeInsets.only(bottom: DefaultDimen.spaceLarge),
                          child : Text(
                            "${abouts.about}",
                            style: TextStyle(
                                fontWeight: DefaultFontWeight.regular,
                                fontFamily: DefaultFont.PoppinsFont,
                                fontSize: DefaultDimen.textMedium
                            ),
                          )
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  DefaultImageLocation.findMe,
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: DefaultDimen.spaceLarge),
                    child : Text(
                      "Temui Kami",
                      style: TextStyle(
                          fontWeight: DefaultFontWeight.bold,
                          fontFamily: DefaultFont.PoppinsFont,
                          fontSize: DefaultDimen.textLarge,
                          color: DefaultColor.textPrimary
                      ),
                    )
                ),
                Column(
                  children: offices.map((office) =>
                      Container(
                        height: 80,
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(bottom: DefaultDimen.spaceSmall),
                                child : Text(
                                  "${office.officeName}",
                                  style: TextStyle(
                                      fontWeight: DefaultFontWeight.semiBold,
                                      fontFamily: DefaultFont.PoppinsFont,
                                      fontSize: DefaultDimen.textMedium,
                                      color: DefaultColor.textPrimary
                                  ),
                                )
                            ),
                            Container(
                                child : Text(
                                  "${office.address}",
                                  style: TextStyle(
                                      fontWeight: DefaultFontWeight.regular,
                                      fontFamily: DefaultFont.PoppinsFont,
                                      fontSize: DefaultDimen.textMedium,
                                      color: DefaultColor.textPrimary
                                  ),
                                )
                            )
                          ],
                        ),
                      )
                  ).toList(),
                ),
                Image.asset(
                  DefaultImageLocation.emergency,
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: DefaultDimen.spaceLarge),
                    child : Text(
                      "Layanan Darurat",
                      style: TextStyle(
                          fontWeight: DefaultFontWeight.bold,
                          fontFamily: DefaultFont.PoppinsFont,
                          fontSize: DefaultDimen.textLarge,
                          color: DefaultColor.textPrimary
                      ),
                    )
                ),
                Column(
                  children: abouts.emergencyService.map((emergency) =>
                      Container(
                        height: 100,
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(bottom: DefaultDimen.spaceSmall, top: DefaultDimen.spaceSmall),
                                child : Text(
                                  "${emergency.serviceName}",
                                  style: TextStyle(
                                      fontWeight: DefaultFontWeight.semiBold,
                                      fontFamily: DefaultFont.PoppinsFont,
                                      fontSize: DefaultDimen.textMedium,
                                      color: DefaultColor.textPrimary
                                  ),
                                )
                            ),
                            emergency.openAt != null ?
                            Container(
                                child : Text(
                                  "${emergency.openAt}",
                                  style: TextStyle(
                                      fontWeight: DefaultFontWeight.regular,
                                      fontFamily: DefaultFont.PoppinsFont,
                                      fontSize: DefaultDimen.textMedium,
                                      color: DefaultColor.textPrimary
                                  ),
                                )
                            ) : emergency.contact != null ?
                            Container(
                              child: Column(
                                children: emergency.contact.map((contact) =>
                                    Column(
                                      children: [
                                        Text(
                                          "${contact.wa}",
                                          style: TextStyle(
                                          fontWeight: DefaultFontWeight.regular,
                                          fontFamily: DefaultFont.PoppinsFont,
                                          fontSize: DefaultDimen.textMedium,
                                          color: DefaultColor.textPrimary
                                          ),
                                        ),
                                        Text(
                                          "${contact.office}",
                                          style: TextStyle(
                                              fontWeight: DefaultFontWeight.regular,
                                              fontFamily: DefaultFont.PoppinsFont,
                                              fontSize: DefaultDimen.textMedium,
                                              color: DefaultColor.textPrimary
                                          ),
                                        )
                                      ],
                                    )
                                ).toList(),
                              ),
                            ) :
                            Container(
                              child: Text(
                                "${emergency.noPhone}",
                                style: TextStyle(
                                    fontWeight: DefaultFontWeight.regular,
                                    fontFamily: DefaultFont.PoppinsFont,
                                    fontSize: DefaultDimen.textMedium,
                                    color: DefaultColor.textPrimary
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                  ).toList(),
                ),
                Image.asset(
                  DefaultImageLocation.operationalTime,
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: DefaultDimen.spaceLarge),
                    child : Text(
                      "Waktu Operasional",
                      style: TextStyle(
                          fontWeight: DefaultFontWeight.bold,
                          fontFamily: DefaultFont.PoppinsFont,
                          fontSize: DefaultDimen.textLarge,
                          color: DefaultColor.textPrimary
                      ),
                    )
                ),
                Column(
                  children: offices.map((office) =>
                      Container(
                        height: 100,
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(bottom: DefaultDimen.spaceSmall),
                                child : Text(
                                  "${office.officeName}",
                                  style: TextStyle(
                                      fontWeight: DefaultFontWeight.semiBold,
                                      fontFamily: DefaultFont.PoppinsFont,
                                      fontSize: DefaultDimen.textMedium,
                                      color: DefaultColor.textPrimary
                                  ),
                                )
                            ),
                            Container(
                                child : Text(
                                  "Senin - Kamis : ${office.officeHourNormal}",
                                  style: TextStyle(
                                      fontWeight: DefaultFontWeight.regular,
                                      fontFamily: DefaultFont.PoppinsFont,
                                      fontSize: DefaultDimen.textMedium,
                                      color: DefaultColor.textPrimary
                                  ),
                                )
                            ),
                            Container(
                                child : Text(
                                  "Sabtu : ${office.officeHourWeekend}",
                                  style: TextStyle(
                                      fontWeight: DefaultFontWeight.regular,
                                      fontFamily: DefaultFont.PoppinsFont,
                                      fontSize: DefaultDimen.textMedium,
                                      color: DefaultColor.textPrimary
                                  ),
                                )
                            ),
                          ],
                        ),
                      )
                  ).toList(),
                )
              ],
            ),
          ) : Center(child: EmptyItem(),)
        ),
      ),
    );
  }

  @override
  showDetailAbout(AboutModel about) {
    setState(() {
      abouts = about;
    });
  }

  @override
  showOffice(List<OfficeModel> office) {
    setState(() {
      offices = office;
    });
  }
}
