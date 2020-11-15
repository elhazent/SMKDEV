import 'package:flutter/material.dart';

import 'base-repository.dart';

abstract class BaseContract{
  void showProgressBar();
  void dismissProgressBar();
  void showUploadProgress();
  void dismissUploadProgress();
  void showSnackBar(String message,{Color color = Colors.red});
  void push(Widget route);
  void pushReplacement(Widget route);
  void pop();
}

abstract class BasePresenter<T extends BaseContract>{
  @protected
  T view;

  BaseRepository repo = BaseRepository();
  @protected
  void setView(T view) {
    this.view = view;
  }

  setContext(BuildContext context) {
    repo.setContext(context);
  }


  void dispose();
}