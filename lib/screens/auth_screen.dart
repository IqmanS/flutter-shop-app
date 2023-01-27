// ignore_for_file: library_private_types_in_public_api, body_might_complete_normally_nullable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/model/http_exception.dart';
import 'package:shop_app/providers/auth.dart';

enum AuthMode { signup, login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: deviceSize.height,
          width: deviceSize.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.9),
                              Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.5),
                              Colors.transparent
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      height: deviceSize.height * 0.45,
                      width: deviceSize.width,
                      margin: const EdgeInsets.only(bottom: 25.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 48.0),
                    ),
                    Container(
                      height: deviceSize.height * 0.40,
                      width: deviceSize.width,
                      margin: const EdgeInsets.only(bottom: 25.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 48.0),
                      child: SvgPicture.asset(
                        "assets/images/login (2).svg",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: deviceSize.width > 600 ? 2 : 1,
                child: const AuthCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  var _isLoading = false;
  final _passwordController = TextEditingController();
  //  final AnimationController _controller = AnimationController(vsync:, );
  // Animation<Opacity> _opacityAnimation = Tween(begin: Opacity(opacity: 0.0),end: Opacity(opacity: 1.0)).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

  @override
  void initState() {
    super.initState();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.login) {
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'].toString(),
          _authData['password'].toString(),
        );
      } else {
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'].toString(),
          _authData['password'].toString(),
        );
      }
    } catch (err) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Close"))
            ],
            icon: const Icon(Icons.error),
            title: const Text("Something went wrong"),
            content: Text(err.toString()),
          );
        },
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: AnimatedContainer(
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 400),
        height: _authMode == AuthMode.signup ? 320 : 260,
        // height: _heightAnimation!.value.height,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                // if (_authMode == AuthMode.signup)
                AnimatedContainer(
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 300),
                  height: _authMode == AuthMode.signup ? 60 : 0,
                  child: TextFormField(
                    enabled: _authMode == AuthMode.signup,
                    decoration:
                        const InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                          }
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submit,
                    child:
                        Text(_authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP'),
                  ),
                ElevatedButton(
                  onPressed: _switchAuthMode,
                  child: Text(
                      '${_authMode == AuthMode.login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
