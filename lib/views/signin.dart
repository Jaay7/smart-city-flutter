import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smart_city_flutter/helper/helperfunctions.dart';
import 'package:smart_city_flutter/views/home.dart';
import 'package:smart_city_flutter/views/signup.dart';
import 'package:smart_city_flutter/widgets/widget.dart';
import 'package:flutter/cupertino.dart';

const LOGIN_USER = """
  mutation loginUser(\$email: String!, \$password: String!) {
    loginUser(
      email: \$email,
      password: \$password,
    ) {
        id
        firstName
        lastName
        username
        email
        role
        userType
      }
  }
""";

class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  
  bool isLoading = false;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Sign In")),
      body: isLoading ? Container(
        child: const Center(child: CircularProgressIndicator()),
      ): SingleChildScrollView(
        child: Center(
          child: Container(
            color: Color(0xFF6D6875),
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Login here,",
                          style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 26),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: textFieldBoxDecoration(),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: emailTextEditingController,
                          style: simpleTextStyle(),
                          decoration: textFieldInputDecoration("Email"),
                        ),
                      ),
                      Container(
                        decoration: textFieldBoxDecoration(),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordTextEditingController,
                          style: simpleTextStyle(),
                          decoration: textFieldInputDecoration("Password"),
                        ),
                      ),
                    ],
                  )
                ),
                SizedBox(
                  height: 20,
                ),
                Mutation(options: MutationOptions(
                  document: gql(LOGIN_USER),
                  onCompleted: (dynamic result) {
                    print(result);
                    Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => MyHomePage()));
                    HelperFunctions.saveUserLoggedInSharedPrefrences(true);
                    HelperFunctions.saveUserLoginTypeSharedPrefrences('anonymous');
                    HelperFunctions.saveUserNameSharedPrefrences(result['loginUser']['username']);
                    HelperFunctions.saveUserIdSharedPrefrences(result['loginUser']['id']);
                  }
                ), builder: (
                  RunMutation runMutation,
                  QueryResult result,
                ) {
                  return GestureDetector(
                    onTap: () => runMutation({
                      'email': emailTextEditingController.text,
                      'password': passwordTextEditingController.text,
                    }),
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Color(0xFFB5838D),
                        // color: Color(0xff007EF4),
                        borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )
                  );
                }),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Color(0xFFe2e2e2), fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Register here",
                          style: TextStyle(
                            color: Color(0xFFE5989B),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Divider(
                  height: 30,
                  thickness: 1.3,
                  color: Colors.black12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Text(
                      "Continue with ",
                      style: TextStyle(color: Color(0xFFe2e2e2), fontSize: 16),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        // signInWithGoogle();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: textFieldBoxDecoration(),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Image.asset(
                          "assets/images/google_logo.png",
                          height: 28,
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        // signInWithFacebook();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: textFieldBoxDecoration(),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Image.asset(
                          "assets/images/facebook_logo.png",
                          height: 25,
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        // _signInWithTwitter();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: textFieldBoxDecoration(),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Image.asset(
                          "assets/images/twitter_logo.png",
                          height: 40,
                        ),
                      ),
                    ),
                    Spacer(),
                    
                  ],
                ),
              ],
            ),
          )
        ),
      )
    );
  }

}

