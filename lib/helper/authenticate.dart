import 'package:smart_city_flutter/views/landing_screen.dart';
import 'package:smart_city_flutter/views/signin.dart';
import 'package:smart_city_flutter/views/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  String currPage = 'Landing';
  void setSignIn() {
    setState(() {
      currPage = 'SignIn';
    });
  }

  void setSignUp() {
    setState(() {
      currPage = 'SignUp';
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (currPage) {
      case 'SignIn':
        return SignIn();
      case 'SignUp':
        return SignUp();
      default:
        return LandingScreen();
    }
  }
}
