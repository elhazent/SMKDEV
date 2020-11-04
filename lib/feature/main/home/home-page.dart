import 'package:carousel_widget/carousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:smkdevapp/base/base-state.dart';

import '../../../constants.dart';
import 'home-presenter.dart';

class HomePage extends BaseStatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage,HomePresenter> implements HomeContract {
  int _current = 0;
  static final List<String> imgSlider = [
    DefaultImageLocation.contoh,
    DefaultImageLocation.contoh,
    DefaultImageLocation.contoh,
    DefaultImageLocation.contoh,
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                height: 250 * (MediaQuery.of(context).size.width / 450),
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
                      children: [
                        Fragment(
                          child: Container(
                            decoration: BoxDecoration(
                            ),
                            child: ClipRRect(
                              child: Image.asset(
                                imgSlider.elementAt(0),
                                fit: BoxFit.contain,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                        ),
                        Fragment(
                          child: Container(
                            decoration: BoxDecoration(
                            ),
                            child: ClipRRect(
                              child: Image.asset(
                                imgSlider.elementAt(1),
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                        ),
                        Fragment(
                          child: Container(
                            decoration: BoxDecoration(
                            ),
                            child: ClipRRect(
                              child: Image.asset(
                                imgSlider.elementAt(2),
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                        ),
                        Fragment(
                          child: Container(
                            decoration: BoxDecoration(
                            ),
                            child: ClipRRect(
                              child: Image.asset(
                                imgSlider.elementAt(3),
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 5,
                      left: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: _current == 0?16:8.0 * (MediaQuery.of(context).size.width / 450),
                            height: 8.0 * (MediaQuery.of(context).size.width / 450),
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: _current == 0
                                  ? DefaultColor.primaryColor
                                  : Colors.white,
                            ),
                          ),
                          Container(
                            width: _current == 1?16:8.0 * (MediaQuery.of(context).size.width / 450),
                            height: 8.0 * (MediaQuery.of(context).size.width / 450),
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: _current == 1
                                  ? DefaultColor.primaryColor
                                  : Colors.white,
                            ),
                          ),
                          Container(
                            width: _current == 2?16:8.0 * (MediaQuery.of(context).size.width / 450),
                            height: 8.0 * (MediaQuery.of(context).size.width / 450),
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: _current == 2
                                  ? DefaultColor.primaryColor
                                  : Colors.white,
                            ),
                          ),
                          Container(
                            width: _current == 3?16:8.0 * (MediaQuery.of(context).size.width / 450),
                            height: 8.0 * (MediaQuery.of(context).size.width / 450),
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: _current == 3
                                  ? DefaultColor.primaryColor
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),topLeft: Radius.circular(15)),
                            color: Colors.black.withOpacity(0.3)
                        ),
                        child: Text(
                          "Lihat Semua",
                          style: TextStyle(
                              color:Colors.white
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
