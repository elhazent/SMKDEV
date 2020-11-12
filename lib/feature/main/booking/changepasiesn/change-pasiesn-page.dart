import 'package:flutter/material.dart';
import 'package:smkdevapp/base/base-state.dart';
import 'package:smkdevapp/feature/main/booking/changepasiesn/change-pasiesn-presenter.dart';

import '../../../../constants.dart';

class ChangePasiesnPage extends BaseStatefulWidget {
  @override
  _ChangePasiesnPageState createState() => _ChangePasiesnPageState();
}

class _ChangePasiesnPageState extends BaseState<ChangePasiesnPage,ChangePasiesnPresenter> implements ChangePasiesnContract {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Ganti Pasien",
            style: TextStyle(
                fontFamily: DefaultFont.PoppinsFont,
                fontSize: 24,
                color: Colors.black
            ),
          ),
          iconTheme: IconThemeData(
              color: Colors.black
          ),
        ),
      ),
    );
  }
}
