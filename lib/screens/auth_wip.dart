// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/auth_screen.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isActive = false;
  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            _isActive = !_isActive;
          });
        },
        child: Stack(
          alignment: const Alignment(0, 0.75),
          children: [
            _isActive
                ? AuthCard()
                : Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      alignment: Alignment(0, 0.35),
                      height: 320,
                      width: mQuery.width * 0.75,
                      padding: const EdgeInsets.all(16.0),
                      child: const Text(
                        "Tap to Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                        ),
                      ),
                    ),
                  ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                          ),
                          height: _isActive
                              ? mQuery.height * 0.40
                              : mQuery.height * 0.60,
                          width: mQuery.width,
                        ),
                        SvgPicture.asset(
                          "assets/images/wave.svg",
                          height: mQuery.height * 0.12,
                          width: mQuery.width,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 5),
                      child: SvgPicture.asset(
                        height: mQuery.height * 0.25,
                        width: mQuery.width * 0.8,
                        "assets/images/auth1.svg",
                        fit: BoxFit.contain,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum AuthMode { signup, login }

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context).size;
    var _authMode = AuthMode.login;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8,
      child: Container(
        height: 320,
        width: mQuery.width * 0.75,
        padding: const EdgeInsets.all(24.0),
        child: Form(
          child: SingleChildScrollView(
            child: Container(
              height: 320,
              child: Column(
                children: [
                  _authMode == AuthMode.login
                      ? Text(
                          "LOGIN",
                          style: Theme.of(context).textTheme.headline5,
                        )
                      : Text(
                          "SIGNUP",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                  TextFormField(),
                  SizedBox(height: 12),
                  TextFormField(),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("SUBMIT"),
                  ),
                  Expanded(
                    child: Text("Register Now"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
