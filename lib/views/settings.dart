import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_city_flutter/helper/authenticate.dart';
import 'package:smart_city_flutter/helper/helperfunctions.dart';

class Settings extends StatefulWidget {
  const Settings({ Key? key }) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String username = "";
  @override
  void initState() {
    super.initState();
    getUsername();
  }

  getUsername() async {
    await HelperFunctions.getUserNameSharedPrefrences().then((value) {
      setState(() {
        username = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings")
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 12.0,
              shadowColor: Colors.black38,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              margin: EdgeInsets.only(top: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Profile", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.person, size: 16),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text("$username"),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ),
            ListTile(
              title: Text("Logout"),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticate()));
              },
            ),
            // TextButton(child: Text("Logout"), onPressed: () async {
            //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticate()));
            //   SharedPreferences prefs = await SharedPreferences.getInstance();
            //   await prefs.clear();
            // },),
          ],
        ),
      ),
    );
  }
}