import 'package:carousel_widget/carousel_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smkdevapp/base/base-state.dart';
import 'package:smkdevapp/feature/main/about/about-page.dart';
import 'package:smkdevapp/feature/main/booking/bookingdetail/booking-detail-page.dart';
import 'package:smkdevapp/feature/main/detail/detail-service-page.dart';
import 'package:smkdevapp/model/doctor-model.dart';
import 'package:smkdevapp/model/event-model.dart';
import 'package:smkdevapp/model/service-model.dart';

import '../../../constants.dart';
import 'home-presenter.dart';

class HomePage extends BaseStatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage,HomePresenter> implements HomeContract {
  int _current = 0;
  GoogleMapController mapController;
  List<ServiceModel> dataService = [];
  List<EventModel> dataSlider = [];
  List<DoctorModel> dataDoctor = [];
  final Set<Marker> _markers = {};
  static final List<String> imgSlider = [
    DefaultImageLocation.contoh,
    DefaultImageLocation.contoh,
    DefaultImageLocation.contoh,
    DefaultImageLocation.contoh,
  ];

  @override
  void initMvp() {
    // TODO: implement initMvp
    super.initMvp();
    presenter = HomePresenter();
    presenter.setView(this);
    presenter.getService();
    presenter.getSlider();
    presenter.getDoctor();
    _markers.add(
      Marker(
        markerId: MarkerId("${DefaultKey.PondohIndahLat}, ${DefaultKey.PondohIndahLong}"),
        position: LatLng(DefaultKey.PondohIndahLat, DefaultKey.PondohIndahLong),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  @override
  fetchService(List<ServiceModel> dataService) {
    setState(() {
      this.dataService = dataService;
    });
  }

  @override
  fetchDoctor(List<DoctorModel> dataDoctor) {
    setState(() {
      this.dataDoctor = dataDoctor;
    });
  }

  @override
  fetchSlider(List<EventModel> dataSlider) {
    setState(() {
      this.dataSlider = dataSlider;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                isOnProgress?Shimmer.fromColors(
                    baseColor: Colors.grey.withOpacity(0.2),
                    highlightColor: Colors.grey.withOpacity(0.5),
                    period: Duration(milliseconds: 2100),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 350 * (MediaQuery.of(context).size.width / 450),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                    )
                ):Container(
                  height: 350 * (MediaQuery.of(context).size.width / 450),
                  decoration: BoxDecoration(
                  ),
                  child: Stack(
                    children: [
                      PageView(
                        onPageChanged: (index) {
                          setState((){
                            _current = index;
                          });
                        },
                        physics: BouncingScrollPhysics(),
                        children: dataSlider.map((e) {
                          return Stack(
                            children: [
                              Fragment(
                                child: Container(
                                  decoration: BoxDecoration(
                                  ),
                                  child: ClipRRect(
                                    child: Image.network(
                                      e.image,
                                      height: 350 * (MediaQuery.of(context).size.width / 450),
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 45,
                                left: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width:230,
                                      child: Text(
                                        e.title,
                                        style: TextStyle(
                                            color: DefaultColor.primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            fontFamily: DefaultFont.PoppinsFont
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width:300,
                                      child: Text(
                                        e.description,
                                        maxLines: 5,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: DefaultFont.PoppinsFont
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 10,
                                bottom: 20,
                                child: GestureDetector(
                                  onTap: (){
                                    push(DetailService(event: e,));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: DefaultColor.primaryColor
                                    ),
                                    child: Text(
                                      "Read",
                                      style: TextStyle(
                                          color:Colors.white,
                                          fontFamily: DefaultFont.PoppinsFont,
                                          fontSize: 10
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        }).toList(),
                      ),
                      Positioned(
                        bottom: 5,
                        left: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: dataSlider.asMap().map((key, value) {
                            return MapEntry(key, Container(
                              width: _current == key?16:8.0 * (MediaQuery.of(context).size.width / 450),
                              height: 8.0 * (MediaQuery.of(context).size.width / 450),
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: _current == key
                                    ? DefaultColor.primaryColor
                                    : Colors.white,
                              ),
                            ));
                          }).values.toList()
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: DefaultDimen.spaceLarge,vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Temui Kami",
                        style: TextStyle(
                          fontFamily: DefaultFont.PoppinsFont,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        height: 200,
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: GoogleMap(
                                onMapCreated: (GoogleMapController controller) {
                                  mapController = controller;
                                },
                                onCameraMove: (p) {
                                  print("P : $p");
                                },
                                onCameraIdle: () {
                                },
                                zoomControlsEnabled: false,
                                mapType: MapType.terrain,
                                mapToolbarEnabled: false,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(DefaultKey.PondohIndahLat , DefaultKey.PondohIndahLong),
                                  zoom: 16,
                                ),
                                minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                                // markers: _markers,
                              ),
                            ),
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black.withOpacity(0.1)
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 20,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        DefaultImageLocation.hospitalImage
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Container(
                                      width: 180,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "RS. PONDOK INDAH",
                                            style: TextStyle(
                                              fontFamily: DefaultFont.PoppinsFont,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          Text(
                                            "Jl. Margacinta No. 29, Buah Batu, Bandung",
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontFamily: DefaultFont.PoppinsFont,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      isOnProgress?Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.3),
                              highlightColor: Colors.grey.withOpacity(0.5),
                              period: Duration(milliseconds: 2100),
                              child: Container(
                                width: 150,
                                height: 20,
                                margin: EdgeInsets.only(right: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                              )
                          ),
                          SizedBox(height: 3,),
                          Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.3),
                              highlightColor: Colors.grey.withOpacity(0.5),
                              period: Duration(milliseconds: 2100),
                              child: Container(
                                width: 100,
                                height: 15,
                                margin: EdgeInsets.only(right: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                              )
                          ),
                          SizedBox(height: 3,),
                          Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.3),
                              highlightColor: Colors.grey.withOpacity(0.5),
                              period: Duration(milliseconds: 2100),
                              child: Container(
                                width: 180,
                                height: 15,
                                margin: EdgeInsets.only(right: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                              )
                          ),
                          SizedBox(height: 3,),
                          Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.3),
                              highlightColor: Colors.grey.withOpacity(0.5),
                              period: Duration(milliseconds: 2100),
                              child: Container(
                                width: 130,
                                height: 15,
                                margin: EdgeInsets.only(right: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                              )
                          ),
                          SizedBox(height: 10,)
                        ],
                      ):Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: dataService.map((e) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.officeName,
                                style: TextStyle(
                                  fontFamily: DefaultFont.PoppinsFont,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              e.address != ""?Container(
                                width: 300,
                                child: Text(
                                  e.address,
                                  style: TextStyle(
                                    fontFamily: DefaultFont.PoppinsFont,
                                  ),
                                ),
                              ):SizedBox(),
                              Text(
                                "Senin - Jumat : ${e.officeHourNormal}",
                                style: TextStyle(
                                  fontFamily: DefaultFont.PoppinsFont,
                                ),
                              ),
                              Text(
                                "Sabtu : ${e.officeHourWeekend}",
                                style: TextStyle(
                                  fontFamily: DefaultFont.PoppinsFont,
                                ),
                              ),
                              SizedBox(height: 10,)
                            ],
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: DefaultDimen.spaceLarge,vertical: 20),
                  decoration: BoxDecoration(
                    color: DefaultColor.primaryColor
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tentang Kami",
                            style: TextStyle(
                              fontFamily: DefaultFont.PoppinsFont,
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              push(AboutPage());
                            },
                            child: Text(
                              "Selengkapnya",
                              style: TextStyle(
                                fontFamily: DefaultFont.PoppinsFont,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "https://gitlab.com/Daffaal/data-json/-/raw/master/hospital.jpg",
                          width: MediaQuery.of(context).size.width,
                          height: 170,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 20,),
                      isOnProgress?Container(
                          height: 280,
                          child: ListView.builder(
                            itemCount: 3,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,position){
                              return Container(
                                margin: EdgeInsets.only(left: position == 0?0:10,top: 10,bottom: 10,right: 10),
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 9,
                                      offset: Offset(0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Shimmer.fromColors(
                                        baseColor: Colors.grey.withOpacity(0.3),
                                        highlightColor: Colors.grey.withOpacity(0.5),
                                        period: Duration(milliseconds: 2100),
                                        child: Container(
                                          width: 200,
                                          height: 165 * (MediaQuery.of(context).size.width / 450),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.white,
                                          ),
                                        )
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Shimmer.fromColors(
                                              baseColor: Colors.grey.withOpacity(0.3),
                                              highlightColor: Colors.grey.withOpacity(0.5),
                                              period: Duration(milliseconds: 2100),
                                              child: Container(
                                                width: 170,
                                                height: 20,
                                                margin: EdgeInsets.only(right: 15),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  color: Colors.white,
                                                ),
                                              )
                                          ),
                                          SizedBox(height: 10,),
                                          Shimmer.fromColors(
                                              baseColor: Colors.grey.withOpacity(0.3),
                                              highlightColor: Colors.grey.withOpacity(0.5),
                                              period: Duration(milliseconds: 2100),
                                              child: Container(
                                                width: 190,
                                                height: 20,
                                                margin: EdgeInsets.only(right: 15),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  color: Colors.white,
                                                ),
                                              )
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                      ):Container(
                          height: 280,
                          child: ListView.builder(
                            itemCount: dataDoctor.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,position){
                              return GestureDetector(
                                onTap: (){
                                  push(BookingDetailPage(dataDoctor[position]));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: position == 0?0:10,top: 10,bottom: 10,right: 10),
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 9,
                                        offset: Offset(0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: 165 * (MediaQuery.of(context).size.width / 450),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                                            color: Colors.grey
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                                          child: Image.network(
                                            dataDoctor[position].avatar,
                                            fit: BoxFit.cover,
                                            width: 200,
                                            height: 165 * (MediaQuery.of(context).size.width / 450),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                dataDoctor[position].doctorName,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontFamily: DefaultFont.PoppinsFont,
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                            Container(
                                              width: 170,
                                              child: Text(
                                                dataDoctor[position].specialist,
                                                maxLines:2,
                                                style: TextStyle(
                                                    fontFamily: DefaultFont.PoppinsFont,
                                                    fontSize: 12
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: DefaultDimen.spaceLarge,vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Berita Terbaru",
                        style: TextStyle(
                            fontFamily: DefaultFont.PoppinsFont,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                          height: 280,
                          child: ListView.builder(
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,position){
                              return Container(
                                margin: EdgeInsets.only(left: position == 0?0:10,top: 10,bottom: 10,right: 10),
                                width: 300,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 9,
                                      offset: Offset(0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 165 * (MediaQuery.of(context).size.width / 450),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                                          color: Colors.grey
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                                        child: Image.asset(
                                          DefaultImageLocation.hospitalImage,
                                          fit: BoxFit.cover,
                                          width: 300,
                                          height: 165 * (MediaQuery.of(context).size.width / 450),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              "Training Center",
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontFamily: DefaultFont.PoppinsFont,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Container(
                                            width: 270,
                                            child: Text(
                                              "Training Center bekerjasama dengan SMKDEV untuk ...",
                                              maxLines:2,
                                              style: TextStyle(
                                                  fontFamily: DefaultFont.PoppinsFont,
                                                  fontSize: 12
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: DefaultDimen.spaceLarge,vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kontak & Pengaduan",
                        style: TextStyle(
                            fontFamily: DefaultFont.PoppinsFont,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 20,),
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                DefaultImageLocation.iconMap,
                                width: 25 * (MediaQuery.of(context).size.width / 450),
                                height: 25 * (MediaQuery.of(context).size.width / 450),
                                color: Colors.grey,
                              ),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Rumah Sakit SMKDEV",
                                    style: TextStyle(
                                      fontFamily: DefaultFont.PoppinsFont,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                    "Jl. Margacinta No. 29",
                                    style: TextStyle(
                                        fontFamily: DefaultFont.PoppinsFont,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.mail_outline_outlined,
                                size: 25 * (MediaQuery.of(context).size.width / 450),
                                color: Colors.grey,
                              ),
                              SizedBox(width: 10,),
                              Text(
                                "info@smk.dev",
                                style: TextStyle(
                                    fontFamily: DefaultFont.PoppinsFont,
                                  fontSize: 16 * (MediaQuery.of(context).size.width / 450)
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    DefaultImageLocation.iconPhone,
                                    width: 25 * (MediaQuery.of(context).size.width / 450),
                                    height: 25 * (MediaQuery.of(context).size.width / 450),
                                    color: Colors.grey,
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    "+622 7000 0000",
                                    style: TextStyle(
                                        fontFamily: DefaultFont.PoppinsFont,
                                        fontSize: 16 * (MediaQuery.of(context).size.width / 450)
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width: 30,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    DefaultImageLocation.iconOffice,
                                    width: 25 * (MediaQuery.of(context).size.width / 450),
                                    height: 25 * (MediaQuery.of(context).size.width / 450),
                                    color: Colors.grey,
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    "+622 7000 0000",
                                    style: TextStyle(
                                        fontFamily: DefaultFont.PoppinsFont,
                                        fontSize: 16 * (MediaQuery.of(context).size.width / 450)
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }






}
