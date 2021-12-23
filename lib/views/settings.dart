import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_twitter/flutter_twitter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_city_flutter/helper/authenticate.dart';
import 'package:smart_city_flutter/helper/helperfunctions.dart';
import 'package:smart_city_flutter/views/profile.dart';

class Settings extends StatefulWidget {
  const Settings({ Key? key }) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  static final TwitterLogin twitterLogin = TwitterLogin(
    consumerKey: dotenv.env['TWITTER_CONSUMER_KEY'].toString(),
    consumerSecret: dotenv.env['TWITTER_CONSUMER_SECRET'].toString(),
  );
  
  String username = "";
  String userLoginType = '';
  @override
  void initState() {
    super.initState();
    getUsername();
    getUserLoginType();
  }

  getUsername() async {
    await HelperFunctions.getUserNameSharedPrefrences().then((value) {
      setState(() {
        username = value;
      });
    });
  }

  getUserLoginType() async {
    await HelperFunctions.getUserLoginTypeSharedPrefrences().then((value) {
      setState(() {
        userLoginType = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Color(0xFFB5838D),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
              },
              child: Card(
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
            ),
            ListTile(
              title: Text("Logout"),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                if ( userLoginType == 'twitter' ) {
                  await twitterLogin.logOut();
                }
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