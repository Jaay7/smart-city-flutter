import 'package:smart_city_flutter/views/signin.dart';
import 'package:smart_city_flutter/views/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = false;
  void toogleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toogleView);
    } else {
      return SignUp(toogleView);
    }
  }
}
