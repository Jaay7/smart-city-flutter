import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_city_flutter/helper/authenticate.dart';

class Settings extends StatefulWidget {
  const Settings({ Key? key }) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings")
      ),
      body: Container(
        child: TextButton(child: Text("Logout"), onPressed: () async {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticate()));
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.clear();
        },),
      ),
    );
  }
}