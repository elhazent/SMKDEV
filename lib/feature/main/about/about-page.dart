
import 'package:flutter/material.dart';
import 'package:smkdevapp/base/base-state.dart';
import 'package:smkdevapp/feature/main/about/about-presenter.dart';
import 'package:smkdevapp/model/about-model.dart';
import 'package:smkdevapp/model/office-model.dart';
import 'package:smkdevapp/widget/detail-image.dart';

import '../../../constants.dart';

class AboutPage extends BaseStatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends BaseState<AboutPage, AboutPresenter> implements AboutContract {
  AboutPresenter presenter;
  AboutModel abouts;
  List<OfficeModel> offices = [];

  @override
  void initMvp() {
    super.initMvp();
    presenter = AboutPresenter();
    presenter.getDetailAbout();
    presenter.getOffice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tentang Kami",
          style: TextStyle(
              fontFamily: DefaultFont.PoppinsFont,
              fontSize: 24,
              color: Colors.black
          ),
        ),
        backgroundColor: DefaultColor.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
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
                              builder: (context) => DetailImage()
                            )
                          );
                        },
                        child: Image.network("")
                      ),
                    )
                ),
              ),
            ],
          ),
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
