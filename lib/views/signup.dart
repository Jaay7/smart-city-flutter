import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smart_city_flutter/helper/helperfunctions.dart';
import 'package:smart_city_flutter/views/home.dart';
import 'package:smart_city_flutter/views/signin.dart';
import 'package:smart_city_flutter/widgets/widget.dart';
import 'package:flutter/cupertino.dart';

const CREATE_USER = """
  mutation CreateUser(\$firstName: String, \$lastName: String, \$username: String!, \$email: String, \$password: String, \$role: String, \$userType: String!) {
    createUser(
      firstName: \$firstName
      lastName: \$lastName
      username: \$username,
      email: \$email,
      password: \$password,
      role: \$role,
      userType: \$userType
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

class SignUp extends StatefulWidget {

  // GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  TextEditingController firstNameTextEditingController = TextEditingController();
  TextEditingController lastNameTextEditingController = TextEditingController();
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Sign Up"),
      // ),
      body: isLoading ? Container(
        child: const Center(child: CircularProgressIndicator()),
      ): Container(
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topRight,
            //   end: Alignment.bottomLeft,
            //   colors: [
            //     Color(0xFFE5989B),
            //     Color(0xFF723d46),
            //   ],
            // ),
          ),  
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [ 
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFFE5989B),
                    Color(0xFF723d46),
                  ],
                ),
              ),
              child: Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 150),
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Sign up here,",
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 26),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              // height: MediaQuery.of(context).size.height * 0.7,
              child: Container(
                color: Colors.red,
                child: CustomPaint(
                  painter: CustomContainerShapeBorder(
                    height: MediaQuery.of(context).size.height * 0.72,
                    width: MediaQuery.of(context).size.width,
                    radius: 50.0,
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 500),
              height: showMenu == false ? MediaQuery.of(context).size.height * 0.875 : MediaQuery.of(context).size.height * 0.65,
              width: MediaQuery.of(context).size.width,
              child: Container(
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black45,
                  //     offset: Offset(
                  //       5.0,
                  //       5.0,
                  //     ),
                  //     blurRadius: 10.0,
                  //     spreadRadius: 2.5,
                  //   ), //BoxShadow
                  //   BoxShadow(
                  //     color: Colors.white,
                  //     offset: Offset(0.0, 0.0),
                  //     blurRadius: 0.0,
                  //     spreadRadius: 0.0,
                  //   ), //BoxShadow
                  // ],
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(25.0),
                    //   topRight: Radius.circular(25.0)
                    // ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        child: Column(
                        children: [
                          Container(
                            decoration: textFieldBoxDecoration(),
                            margin: const EdgeInsets.only(bottom: 10, top: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: firstNameTextEditingController,
                              style: simpleTextStyle(),
                              decoration: textFieldInputDecoration("First Name"),
                            ),
                          ),
                          Container(
                            decoration: textFieldBoxDecoration(),
                            margin: const EdgeInsets.only(bottom: 10, top: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: lastNameTextEditingController,
                              style: simpleTextStyle(),
                              decoration: textFieldInputDecoration("Last Name"),
                            ),
                          ),
                          Container(
                            decoration: textFieldBoxDecoration(),
                            margin: const EdgeInsets.only(bottom: 10, top: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: usernameTextEditingController,
                              style: simpleTextStyle(),
                              decoration: textFieldInputDecoration("Username"),
                            ),
                          ),
                          Container(
                            decoration: textFieldBoxDecoration(),
                            margin: const EdgeInsets.only(bottom: 10, top: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: emailTextEditingController,
                              style: simpleTextStyle(),
                              decoration: textFieldInputDecoration("Email"),
                            ),
                          ),
                          Container(
                            decoration: textFieldBoxDecoration(),
                            margin: const EdgeInsets.only(bottom: 10, top: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              obscureText: true,
                              controller: passwordTextEditingController,
                              style: simpleTextStyle(),
                              decoration: textFieldInputDecoration("Password"),
                            ),
                          ),
                        ],
                      ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Mutation(options: MutationOptions(
                        document: gql(CREATE_USER),
                        onCompleted: (dynamic result) {
                          print(result);
                          HelperFunctions.saveUserLoggedInSharedPrefrences(true);
                          HelperFunctions.saveUserNameSharedPrefrences(result['CreateUser']['username']);
                          HelperFunctions.saveUserIdSharedPrefrences(result['CreateUser']['id']);
                          HelperFunctions.saveUserLoginTypeSharedPrefrences('anonymous');
                          Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => MyHomePage()));
                        },
                        onError: (error) {
                          print(error);
                        },
                      ), builder: (
                        RunMutation runMutation,
                        QueryResult result,
                      ) {
                        return GestureDetector(
                          onTap: () => runMutation({
                            'firstName': firstNameTextEditingController.text,
                            'lastName': lastNameTextEditingController.text,
                            'username': usernameTextEditingController.text,
                            'email': emailTextEditingController.text,
                            'password': passwordTextEditingController.text,
                            'role': 'user',
                            'userType': 'anonymous'
                          }),
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: Color(0xFF6D6875),
                              // color: Color(0xff007EF4),
                              // gradient: LinearGradient(colors: [
                              //   const Color(0xff007EF4),
                              //   const Color(0xff2A75BC)
                              // ]),
                              borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          )
                        );
                      }),
                      SizedBox(
                        height: 20
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(color: Color(0xFF323232), fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: const Text(
                                "SignIn",
                                style: TextStyle(
                                  color: Color(0xFFB5838D),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

}


class CustomContainerShapeBorder extends CustomPainter {
      final double height;
      final double width;
      final Color fillColor;
      final double radius;
    
      CustomContainerShapeBorder({
        this.height: 400.0,
        this.width: 300.0,
        this.fillColor: Colors.white,
        this.radius: 50.0,
      });
      @override
      void paint(Canvas canvas, Size size) {
        Path path = new Path();
        path.moveTo(0.0, -radius);
        path.lineTo(0.0, -(height - radius));
        path.conicTo(0.0, -height, radius, -height, 1);
        path.lineTo(width - radius, -height);
        path.conicTo(width, -height, width, -(height + radius), 1);
        path.lineTo(width, -(height - radius));
        path.lineTo(width, -radius);
    
        path.conicTo(width, 0.0, width - radius, 0.0, 1);
        path.lineTo(radius, 0.0);
        path.conicTo(0.0, 0.0, 0.0, -radius, 1);
        path.close();
        canvas.drawPath(path, Paint()..color = fillColor);
      }
    
      @override
      bool shouldRepaint(CustomPainter oldDelegate) {
        return true;
      }
    }