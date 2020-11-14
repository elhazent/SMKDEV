import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../constants.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Feedback",
          style: TextStyle(
              fontFamily: DefaultFont.PoppinsFont,
              fontSize: 24,
              color: Colors.black
          ),
        ),
        leading: GestureDetector(
          child: Icon(
            Icons.close,
            color: DefaultColor.textPrimary,
          ),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: WebView(
        initialUrl: DefaultKey.feedBackUrl,
      ),
    );
  }
}
