import 'package:flutter/material.dart';
import 'package:smart_city_flutter/views/signin.dart';
import 'package:smart_city_flutter/views/signup.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_twitter/flutter_twitter.dart';
import 'package:smart_city_flutter/helper/helperfunctions.dart';
import 'package:smart_city_flutter/views/home.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const CREATE_USER = """
  mutation CreateUser( \$username: String!, \$userType: String!) {
    createUser(
      username: \$username,
      userType: \$userType
    ) {
        id
        username
        userType
      }
  }
""";

class LandingScreen extends StatefulWidget {
  const LandingScreen({ Key? key }) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

  String _twitterUsername = "";

  static final TwitterLogin twitterLogin = TwitterLogin(
    consumerKey: dotenv.env['TWITTER_CONSUMER_KEY'].toString(),
    consumerSecret: dotenv.env['TWITTER_CONSUMER_SECRET'].toString(),
  );

  _signInWithTwitter() async {
    final TwitterLoginResult result = await twitterLogin.authorize();
    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        final String token = result.session.token;
        final String secret = result.session.secret;
        final String username = result.session.username;
        setState(() {
          _twitterUsername = username;
        });
        HelperFunctions.saveUserNameSharedPrefrences(username);
        HelperFunctions.saveUserLoginTypeSharedPrefrences('twitter');
        print(username);
        print(token);
        print(secret);
        break;
      case TwitterLoginStatus.cancelledByUser:
        print('cancelledByUser');
        break;
      case TwitterLoginStatus.error:
        print(result.errorMessage);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color(0xFF4158D0),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFF4158D0),
                Color(0xFFC850C0),
                Color(0xFFFFCC70),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                // height: 200,
                width: MediaQuery.of(context).size.width -30,
                child: Image.asset('assets/images/city.png'),
              ),
              const SizedBox(height: 40),
              const Text('Smart City', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width -30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Center(
                    child: Text('Create an account', style: TextStyle(fontSize: 16),),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width -30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/google_logo.png",
                        height: 26,
                      ),
                      const SizedBox(width: 15),
                      const Text('Continue with Google', style: TextStyle(fontSize: 16, color: Colors.white),),
                    ]
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width -30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/facebook_logo.png",
                        height: 24,
                      ),
                      const SizedBox(width: 15),
                      const Text('Continue with Facebook', style: TextStyle(fontSize: 16, color: Colors.white),),
                    ]
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Mutation(
                options: MutationOptions(
                  document: gql(CREATE_USER),
                  onCompleted: (dynamic result) {
                    print(result);
                    Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => MyHomePage()));
                    HelperFunctions.saveUserLoggedInSharedPrefrences(true);
                    HelperFunctions.saveUserIdSharedPrefrences(result['CreateUser']['id']);
                  },
                  onError: (error) {
                    print(error);
                  },
                ), builder: (
                  RunMutation runMutation,
                  QueryResult result,
                ) {
                  return GestureDetector(
                    onTap: () async {
                      await _signInWithTwitter();
                      await runMutation({
                        'username': _twitterUsername,
                        'userType': 'twitter'
                      });
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width -30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/twitter_logo.png",
                            height: 28,
                          ),
                          const SizedBox(width: 15),
                          const Text('Continue with Twitter', style: TextStyle(fontSize: 16, color: Colors.white),),
                        ]
                      ),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                },
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width -30,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Center(
                    child: Text('Login', style: TextStyle(fontSize: 16, color: Colors.white),),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
