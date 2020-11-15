import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'base-presenter.dart';

abstract class BaseStatefulWidget extends StatefulWidget{
  BaseStatefulWidget({Key key}) : super(key: key);
}

abstract class BaseState<T extends BaseStatefulWidget,R extends BasePresenter> extends State<T>implements BaseContract{
  R presenter;
  bool isOnProgress = false;
  bool isOnUpload = false;
  GlobalKey<ScaffoldState> keyScaffold = new GlobalKey<ScaffoldState>();
  bool resizeToAvoidBottomPadding = false;


  @override
  void dispose() {
    super.dispose();
    presenter?.dispose();
  }

  @override
  void initState() {
    super.initState();
    print("PAGE : " + T.toString());
    initMvp();
    presenter?.setContext(context);
  }

  @protected
  void initMvp() {
  }

  Widget buildWidgetAppBar(BuildContext context) {
    return null;
  }

  @protected
  Widget buildWidgetUI(BuildContext context) {
  }


  @override
  void showProgressBar() {
    setState(() {
      isOnProgress = true;
    });
  }

  @override
  void showUploadProgress() {
    setState(() {
      isOnUpload = true;
    });
  }

  @override
  void dismissProgressBar() {
    if(!mounted) return;
    setState(() {
      isOnProgress = false;
    });
  }

  @override
  void dismissUploadProgress() {
    if(!mounted) return;
    setState(() {
      isOnUpload = false;
    });
  }

  @override
  void showSnackBar(String message, {Color color = Colors.red}) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      message: message,
      backgroundColor: color == Colors.red ? color : DefaultColor.primaryColor,
      duration: Duration(seconds: 3),
    ).show(context);
  }

  @override
  void push(Widget route) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return route;
    }));
  }

  @override
  void pushReplacement(Widget route) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
      return route;
    }));
  }

  @override
  void pop() {
    Navigator.of(context).pop();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: resizeToAvoidBottomPadding,
      appBar: buildWidgetAppBar(context),
      backgroundColor: DefaultColor.background,
      body: buildWidgetUI(context),
      key: keyScaffold,
    );
  }
}