// ignore_for_file: use_rethrow_when_possible, avoid_print, unused_field

import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/model/http_exception.dart';

class Auth with ChangeNotifier {
  String _token = "";
  DateTime _expiry = DateTime(2021);
  String _userId = "";
  bool _auth = false;
  Timer? _authTimer = null;

  bool get authStatus {
    return _auth;
  }

  void isAuth() {
    if (_expiry != DateTime(2021) &&
        _expiry.isAfter(DateTime.now()) &&
        _token != "") {
      _auth = true;
    } else {
      _auth = false;
    }
  }

  String get token {
    if (_expiry != DateTime(2021) &&
        _expiry.isAfter(DateTime.now()) &&
        _token != "") {
      return _token;
    }
    return "";
  }

  String get userId {
    return _userId;
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
      isAuth();
      notifyListeners();
      _autoLogout();
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

  void logout() {
    _token = "";
    _expiry = DateTime(2021);
    _userId = "";
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    isAuth();
    notifyListeners();
  }

  void _autoLogin() {}

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiry.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(
      Duration(seconds: timeToExpiry),
      logout,
    );
  }
}
