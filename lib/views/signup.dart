import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smart_city_flutter/helper/helperfunctions.dart';
import 'package:smart_city_flutter/views/home.dart';
import 'package:smart_city_flutter/widgets/widget.dart';
import 'package:flutter/cupertino.dart';

const CREATE_USER = """
  mutation CreateUser(\$firstName: String!, \$lastName: String!, \$username: String!, \$email: String!, \$password: String!) {
    createUser(
      firstName: \$firstName
      lastName: \$lastName
      username: \$username,
      email: \$email,
      password: \$password,
    ) {
        id
        firstName
        lastName
        username
        email
      }
  }
""";

class SignUp extends StatefulWidget {
  final Function toogle;
  SignUp(this.toogle);

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: isLoading ? Container(
        child: const Center(child: CircularProgressIndicator()),
      ): SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            "Create an account in our Smart City",
                            style: TextStyle(color: Colors.green, fontSize: 22),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        decoration: textFieldBoxDecoration(),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: firstNameTextEditingController,
                          style: simpleTextStyle(),
                          autofocus: true,
                          decoration: textFieldInputDecoration("First Name"),
                        ),
                      ),
                      Container(
                        decoration: textFieldBoxDecoration(),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: lastNameTextEditingController,
                          style: simpleTextStyle(),
                          decoration: textFieldInputDecoration("Last Name"),
                        ),
                      ),
                      Container(
                        decoration: textFieldBoxDecoration(),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: usernameTextEditingController,
                          style: simpleTextStyle(),
                          decoration: textFieldInputDecoration("Username"),
                        ),
                      ),
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
                        margin: const EdgeInsets.symmetric(vertical: 5),
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
                      Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => MyHomePage()));
                      HelperFunctions.saveUserLoggedInSharedPrefrences(true);
                      HelperFunctions.saveUserEmailSharedPrefrences(emailTextEditingController.text);
                    }
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
                      }),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.green[700],
                          // color: Color(0xff007EF4),
                          // gradient: LinearGradient(colors: [
                          //   const Color(0xff007EF4),
                          //   const Color(0xff2A75BC)
                          // ]),
                          borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
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
                        "Already have an account? ",
                        style: mediumTextStyle(),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.toogle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "SignIn",
                            style: TextStyle(
                              color: Colors.green[400],
                              fontSize: 17,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ),
          ),
        )
      ),
    );
  }

}
