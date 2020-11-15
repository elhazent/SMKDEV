import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smkdevapp/model/notification-model.dart';
import 'package:smkdevapp/widget/detail-image.dart';

import '../../../constants.dart';

class DetailNotification extends StatelessWidget {
  final NotificationModel notification;

  DetailNotification({Key key, this.notification}) : super(key: key);

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
            "${notification.notifTitle}",
            style: TextStyle(
                color: DefaultColor.textPrimary,
                fontFamily: DefaultFont.PoppinsFont,
                fontSize: 24
            ),
          ),
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
                                        DetailImage(url: notification != null ? notification.image : "")
                                )
                            );
                          },
                          child: Image.network(notification != null ? notification.image : "",
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(DefaultDimen.spaceLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${notification != null ? notification.tag: ""}",
                        style: TextStyle(
                          color: DefaultColor.primaryColor,
                          fontFamily: DefaultFont.PoppinsFont,
                          fontSize: DefaultDimen.textLarge,
                        ),
                      ),
                      Text(
                        "${notification != null ? notification.notifTitle: ""}",
                        style: TextStyle(
                            color: DefaultColor.textPrimary,
                            fontFamily: DefaultFont.PoppinsFont,
                            fontSize: DefaultDimen.textExtraLarge + 4,
                            fontWeight: DefaultFontWeight.semiBold
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: DefaultDimen.spaceSmall),
                        child: Text(
                          "${notification != null ? notification.date :""}",
                          style: TextStyle(
                            color: Colors.grey.withOpacity(0.8),
                            fontFamily: DefaultFont.PoppinsFont,
                            fontSize: DefaultDimen.textMedium,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: DefaultDimen.spaceLarge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${notification.time}",
                              style: TextStyle(
                                fontWeight: DefaultFontWeight.bold,
                                fontSize: DefaultDimen.textExtraLarge + 12,
                                color: DefaultColor.primaryColor,
                                fontFamily: DefaultFont.PoppinsFont
                              ),
                            ),
                            Container(
                              height: 100,
                              width: 1,
                              color: Colors.grey,
                              margin: EdgeInsets.symmetric(horizontal: DefaultDimen.spaceSmall),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        DefaultImageLocation.iconMap,
                                        height: 16,
                                        width: 16,
                                      ),
                                      Container(
                                        width: 200,
                                        margin: EdgeInsets.only(left: DefaultDimen.spaceSmall),
                                        child: Text(
                                          "${notification.place[0].name}",
                                          softWrap: true,
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: DefaultDimen.textLarge,
                                            fontWeight: DefaultFontWeight.semiBold,
                                            fontFamily: DefaultFont.PoppinsFont
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: DefaultDimen.spaceSmall),
                                    child: Text(
                                      "${notification.place[0].address}",
                                      style: TextStyle(
                                        fontSize: DefaultDimen.textMedium,
                                        fontFamily: DefaultFont.PoppinsFont
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: DefaultDimen.spaceLarge),
                        child: Text(
                          "${notification != null ? notification.notifContent: ""}",
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
