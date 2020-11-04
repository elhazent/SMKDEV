import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'base-function.dart';
import 'package:http/http.dart' as http;

import 'base-response.dart';

enum RequestType { post, get, delete, put }

class BaseRepository{

  static const baseURL = "http://jarvar.spacecode.my.id/hrservice";

  BuildContext context;
  setContext(BuildContext context) {
    this.context = context;
  }

  Future<String> getToken() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(DefaultKey.AccessToken);
  }


  Future<dynamic> fetch(String path, RequestType type,{dynamic body, Map<String, String> header, String token, String module = "",bool printLog = true}) async {
    var url = baseURL + "/" + module + "/" + path;
    print(url);
    if (body != null && printLog) BaseFunction.printWrapped('body: $body');
    var tokens = await getToken();
    Map<String, String> headers;
    headers = {'content-type': "application/json"};
    headers.addAll({'Authorization': 'Bearer ${tokens != null ? tokens : "nothing"}'});
    if (header != null) headers.addAll(header);
    var request = type == RequestType.get
        ? http.get(url, headers: headers)
        : type == RequestType.post
        ? http.post(url, headers: headers, body: (json.encode(body)))
        : type == RequestType.put
        ? http.put(url, headers: headers, body: (json.encode(body)))
        : http.delete(url, headers: headers);

    return request.then((http.Response response) async {
      final jsonBody = response.body;
      final statusCode = response.statusCode;
      if (printLog) BaseFunction.printWrapped('respBody: ${response.body}');
      if (response.body.toString().contains("Unauthorized access") ||
          response.body.toString().contains('Invalid token') ||
          response.statusCode == 401) {
        SharedPreferences.getInstance().then((pref) {
          pref.remove(DefaultKey.AccessToken);
        });
        showFlushbar("Sesi habis. Silakan login kembali",Colors.red);
        await Future.delayed(Duration(seconds: 2));
//        Navigator.of(context).pushAndRemoveUntil(
//            MaterialPageRoute(builder: (context) => LoginPage()),
//                (Route<dynamic> route) => false);
        throw new Exception("sesi invalid");
      }

      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new Exception("$statusCode body: ${jsonBody != null ? jsonBody : "null"}");
      }

      final jsonMap = json.decode(jsonBody);
      final baseResponse = new BaseResponse.fromJson(jsonMap);


      if (!baseResponse.success) {
        if (printLog) print(baseResponse.message);
        if (baseResponse.message.toLowerCase().contains('terjadi kesalahan'))
          baseResponse.message = null;
        showFlushbar(
            'Terjadi kesalahan: ${baseResponse.data ?? baseResponse.message ?? "Silakan coba lagi"}',Colors.red);
        throw new Exception('${baseResponse.data != null ? baseResponse.data : baseResponse.message}');
      }
      return baseResponse.data;
    });
  }

  showFlushbar(String message,Color color) {
    context != null ? Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      message: message,
      backgroundColor: color,
      duration: Duration(seconds: 2),
    ).show(context) : print('flushbar not printed');
  }
}