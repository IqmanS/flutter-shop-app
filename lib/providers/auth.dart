// ignore_for_file: use_rethrow_when_possible, avoid_print, unused_field

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/model/http_exception.dart';

class Auth with ChangeNotifier {
  late String _token = "";
  late DateTime _expiry = DateTime(2021);
  late String _userId;

  bool get isAuth {
    return token != "";
  }

  String get token {
    if (_expiry != null && _expiry.isAfter(DateTime.now()) && _token != null) {
      return _token;
    }
    return "";
  }

  Future<void> _authenticate(email, password, String urlSeg) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSeg?key=AIzaSyDJU8PtdizIhCuaLf7njpuE2b2aiUJKoyc");

    try {
      final res = await http.post(
        url,
        body: json.encode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );
      final resData = json.decode(res.body);
      // print(resData);
      if (resData["error"] != null) {
        throw HttpException(resData["error"]["message"]);
      }
      _token = resData['idToken'];
      _userId = resData['localId'];
      _expiry = DateTime.now().add(
        Duration(
          seconds: int.parse(resData['expiresIn']),
        ),
      );
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }
}
