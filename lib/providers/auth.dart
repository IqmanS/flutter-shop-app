// ignore_for_file: use_rethrow_when_possible, avoid_print, unused_field

import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/model/http_exception.dart';

enum TryingAutoLogin { sucess, failed, waiting }

class Auth with ChangeNotifier {
  String _token = "";
  DateTime _expiry = DateTime(2021);
  String _userId = "";
  bool _authStatus = false;
  Timer? _authTimer = null;

  bool get authStatus {
    return _authStatus;
  }

  void isAuth() {
    if (_expiry != DateTime(2021) &&
        _expiry.isAfter(DateTime.now()) &&
        _token != "") {
      _authStatus = true;
    } else {
      _authStatus = false;
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
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        "token": _token,
        "userId": _userId,
        "expiry": _expiry.toIso8601String()
      });
      prefs.setString("userData", userData);
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

  Future<void> logout() async {
    _token = "";
    _expiry = DateTime(2021);
    _userId = "";
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("userData");
    // pres.clear
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    isAuth();
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("userData")) {
      final extractedData = json.decode(prefs.getString("userData") as String);
      var extractedExpiryDate = DateTime.parse(extractedData["expiry"]);

      // extractedExpiryDate = extractedExpiryDate.subtract(Duration(days: 600));

      if (extractedExpiryDate.isAfter(DateTime.now())) {
        _token = extractedData["token"];
        _userId = extractedData["userId"];
        _expiry = extractedExpiryDate;
        // print(_token);
        // print(_userId);
        // print(_expiry);

        _autoLogout();
        _authStatus = true;
        notifyListeners();
        return true;
      }
    }

    _authStatus = false;
    return false;
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
