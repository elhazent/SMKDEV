import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smkdevapp/base/base-state.dart';
import 'package:smkdevapp/feature/main/about/about-page.dart';
import 'package:smkdevapp/feature/main/feedback/feedback-page.dart';
import 'package:smkdevapp/feature/main/main-presenter.dart';
import 'package:smkdevapp/feature/main/partner/partner-carrier-page.dart';
import 'package:smkdevapp/feature/main/profile/profile-page.dart';
import 'package:smkdevapp/feature/main/services/service-page.dart';

import '../../constants.dart';
import 'booking/booking-page.dart';
import 'home/home-page.dart';

class MainPage extends BaseStatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends BaseState<MainPage, MainPresenter>
    implements MainContract {
  int currentIndex = 0;
  int floatingIndex = 0;
  List<NavigationIconView> _navigationViews;
  bool openFloat = false;

  @override
  void initMvp() {
    super.initMvp();
    presenter = MainPresenter();
    presenter.setView(this);

  }

  @override
  Widget buildWidgetUI(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return new Center(
          child: _navigationViews[currentIndex].child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _navigationViews = <NavigationIconView>[
      NavigationIconView(
        child: HomePage(),
        icon: buildIconAsset(asset: DefaultImageLocation.iconHome),
        activeIcon: SvgPicture.asset(
          DefaultImageLocation.iconHome,
          width: 16,
          height: 16,
          color: DefaultColor.primaryColor,
        ),
        title: Text(
          "Home",
          style: TextStyle(
              color:
                  currentIndex == 0 ? DefaultColor.primaryColor : Colors.black),
        ),
      ),
      NavigationIconView(
        child: ServicePage(),
        icon: buildIconAsset(asset: DefaultImageLocation.iconLayanan),
        activeIcon: SvgPicture.asset(
          DefaultImageLocation.iconLayanan,
          width: 16,
          height: 16,
          color: DefaultColor.primaryColor,
        ),
        title: Text(
          "Layanan",
          style: TextStyle(
              color:
                  currentIndex == 1 ? DefaultColor.primaryColor : Colors.black),
        ),
      ),
      NavigationIconView(
        child: BookingPage(),
        icon: buildIconAsset(asset: DefaultImageLocation.iconCalendar),
        activeIcon: SvgPicture.asset(
          DefaultImageLocation.iconCalendar,
          width: 16,
          height: 16,
          color: DefaultColor.primaryColor,
        ),
        title: Text(
          "Booking",
          style: TextStyle(
              color:
                  currentIndex == 2 ? DefaultColor.primaryColor : Colors.black),
        ),
      ),
      NavigationIconView(
        child: Container(
          child: ProfilePage(),
        ),
        icon: Stack(
          children: <Widget>[
            new Icon(Icons.person_outline),
            new Positioned(
              right: 0,
              child: new Container(
                padding: EdgeInsets.all(1),
                decoration: new BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
                child: new Text(
                  '2',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
        activeIcon: SvgPicture.asset(
          DefaultImageLocation.iconUser,
          width: 16,
          height: 16,
          color: DefaultColor.primaryColor,
        ),
        title: Text(
          "Profile",
          style: TextStyle(
              color:
                  currentIndex == 3 ? DefaultColor.primaryColor : Colors.black),
        ),
      ),
      NavigationIconView(
        child:
        floatingIndex == 1 ? AboutPage() : PartnerCarrierPage(),
        icon: buildIconAsset(asset: DefaultImageLocation.iconMore),
        activeIcon: SvgPicture.asset(
          DefaultImageLocation.iconMore,
          width: 16,
          height: 16,
          color: DefaultColor.primaryColor,
        ),
        title: Container(
          child: Text(
            "More",
            style: TextStyle(
                color:
                currentIndex == 4 ? DefaultColor.primaryColor : Colors.black),
          ),
        ),
      ),
    ];
    GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');
    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      key: globalKey,
      selectedFontSize: 12,
      selectedItemColor: DefaultColor.primaryColor,
//      fixedColor: DefaultColor.buttonPrimary,
      unselectedLabelStyle: TextStyle(color: Colors.black),
      selectedLabelStyle: TextStyle(color: DefaultColor.primaryColor),
      items: _navigationViews
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          if (index == 4){
            print("INDEX 4");
            setState(() {
              openFloat = !openFloat;

            });
          } else {
            openFloat = false;
            this.currentIndex = index;
          }
        });
      },
    );

    return new WillPopScope(
        child: Scaffold(
            floatingActionButton: openFloat ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                new FloatingActionButton.extended(
                  icon: Container(
                    padding:EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      shape: BoxShape.circle
                    ),
                    child: SvgPicture.asset(
                      DefaultImageLocation.iconUser,
                      width: 16,
                      height: 16,
                      color: Colors.white,
                    ),
                  ),
                    label: Text(
                      "Tentang Kami"
                    ),
                    heroTag: 1,
                    onPressed: (){
                    setState(() {
                      floatingIndex = 1;
                      this.currentIndex = 4;
                      openFloat = false;
                    });
                    }
                    ),
                SizedBox(height: 10,),
                new FloatingActionButton.extended(
                    icon: Container(
                      padding:EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          shape: BoxShape.circle
                      ),
                      child: SvgPicture.asset(
                        DefaultImageLocation.iconBriefcase,
                        width: 16,
                        height: 16,
                        color: Colors.white,
                      ),
                    ),
                    label: Text(
                        "Partner & Career"
                    ),
                    heroTag: 2,
                    onPressed: (){
                      setState(() {
                        floatingIndex = 2;
                        this.currentIndex = 4;
                        openFloat = false;
                      });
                    }
                ),
                SizedBox(height: 10,),
                new FloatingActionButton.extended(
                    icon: Container(
                      padding:EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          shape: BoxShape.circle
                      ),
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 16,
                      )
                    ),
                    label: Text(
                        "Feedback"
                    ),
                    heroTag: 3,
                    onPressed: (){
                      push(FeedbackPage());
                      openFloat = false;
                    }
                ),
              ],
            ):SizedBox(),
            body: GestureDetector(
              onTap: (){
                setState(() {
                  openFloat = false;
                });
              },
                child: buildWidgetUI(context)),
            bottomNavigationBar: botNavBar),
        onWillPop: () async {
          bool keluar = false;
          await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text("Anda akan keluar"),
                    content: Text("Anda yakin untuk keluar?"),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text("Ya",
                            style: TextStyle(color: Colors.black38)),
                        onPressed: () {
                          pop();
                          if (Platform.isAndroid)
                            SystemChannels.platform
                                .invokeMethod('SystemNavigator.pop');
                        },
                      ),
                      new FlatButton(
                        child: new Text(
                          "Tidak",
                          style: TextStyle(color: DefaultColor.primaryColor),
                        ),
                        onPressed: () {
                          pop();
                          keluar = false;
                        },
                      ),
                    ],
                  ));
          return keluar;
        });
  }
}

class NavigationIconView {
  NavigationIconView({
    Widget child,
    Widget icon,
    Widget activeIcon,
    Widget title,
    Color color,
  })  : child = child,
        item = new BottomNavigationBarItem(
          icon: icon,
          activeIcon: activeIcon,
          title: title,
          backgroundColor: color,
        );

  final Widget child;
  final BottomNavigationBarItem item;
}

Widget buildIconAsset({
  @required String asset,
  double iconSize = 18,
}) {
  return Column(
    children: <Widget>[
      SvgPicture.asset(
        asset,
        color: Colors.grey,
        height: iconSize,
        width: iconSize,
//        color: DefaultColor.buttonPrimary,
      ),
      Container(height: 6)
    ],
  );
}
