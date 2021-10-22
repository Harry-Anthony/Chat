import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:myfirstapp/models/user.dart';

class API {
  static final instance = API();
  Future<dynamic> register(
    username,
    email,
    password
  ) async {
      final completer = Completer<dynamic>();
      FormData formData = FormData.fromMap({
        "username": username,
        "email": email,
        "password": password
      });
      try {
        var response = Dio().post('https://',data: formData);
        print(response);
        completer.complete(response);
      }on DioError catch(e) {
        print(e.response);
        completer.complete(e.response);
      }
      return completer.future;
  }

  Future<User> login(
    email,password
  ) async {
    FormData formData = FormData.fromMap(
      {
        "email": email,
        "password":  password
      }
    );
    var response = await Dio().post('',data: formData);
    User user = User.fromJSON(response, "");
    return user;
  }
}