import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smart_city_flutter/helper/helperfunctions.dart';

const GET_USER_PROFILE = """
query Query(\$userId: String) {
  user(id: \$userId) {
    id
    firstName
    lastName
    username
    email
  }
}
""";

class Profile extends StatefulWidget {
  const Profile({ Key? key }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String userId = "";
  String username = "";
  int _selectedDestination = 0;
  
  @override
  void initState() {
    super.initState();
    getUserId();
    getUsername();
  }

  getUserId() async {
    await HelperFunctions.getUserIdSharedPrefrences().then((value) {
      setState(() {
        userId = value;
      });
    });
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
        primary: true,
        title: Text("$username's Profile"),
        backgroundColor: const Color(0xFFB5838D),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Query(
          options: QueryOptions(
            document: gql(GET_USER_PROFILE),
            pollInterval: const Duration(seconds: 1),
            variables: {
              'userId': userId,
            },
          ),
          builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }
        
            if (result.isLoading) {
              return const Center(heightFactor: 13.0, child: CircularProgressIndicator(),);
            }
        
            return Container(
              color: const Color(0x44E5989B),
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage("https://picsum.photos/200/300"),
                  ),
                  const SizedBox(height: 20),
                  //generate a list for user data
                  Text(result.data['user']['firstName'] + " " + result.data['user']['lastName'], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10),
                  Text(result.data['user']['email'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFF727272)),),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Image.asset(
                            "assets/images/google_logo.png",
                            height: 28,
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      GestureDetector(
                        onTap: () {
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Image.asset(
                            "assets/images/facebook_logo.png",
                            height: 25,
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      GestureDetector(
                        onTap: () {
                        },
                        child: Container(
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     ElevatedButton(
                  //       onPressed: () {
                          
                  //       },
                  //       // color: const Color(0xFFD1ACA5),
                  //       child: const Text("Edit Profile", style: TextStyle(color: Colors.white),),
                  //     ),
                  //     const SizedBox(width: 10),
                  //     OutlinedButton(
                  //       onPressed: () {
                          
                  //       },
                  //       // color: const Color(0xFFD1ACA5),
                  //       child: const Text("Change Password",),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDestination = 0;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: _selectedDestination == 1 ? Color(0xFFFFFFFF) : Color(0xFF6D6875),
                          ),
                          child: Center(child: Text("About", style: TextStyle(color: _selectedDestination == 0 ? Color(0xFFFFFFFF) : Color(0xFF6D6875)),)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDestination = 1;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: _selectedDestination == 0 ? Color(0xFFFFFFFF) : Color(0xFF6D6875),
                          ),
                          child: Center(child: Text("Favourites", style: TextStyle(color: _selectedDestination == 1 ? Color(0xFFFFFFFF) : Color(0xFF6D6875)),)),
                        ),
                      )
                    ]
                  ),
                  _selectedDestination == 0 ? 
                  Expanded(
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
                            color: Color(0xE5B5838D),
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Username", style: TextStyle(fontSize: 14, color: Color(0xFFe2e2e2), fontWeight: FontWeight.w400),),
                                    SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text("${result.data['user']['username']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFFf1f1f1))),
                                    ),
                                  ],
                                ),
                                // TextButton.icon(
                                //   onPressed: () {},
                                //   icon: const Icon(Icons.edit),
                                //   label: Text("Edit")
                                // )
                              ],
                            ),
                          )
                        ),
                        Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 12.0,
                          shadowColor: Colors.black38,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          margin: EdgeInsets.only(top: 15),
                          child: Container(
                            color: Color(0xE5B5838D),
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("First Name", style: TextStyle(fontSize: 14, color: Color(0xFFe2e2e2), fontWeight: FontWeight.w400),),
                                    SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text("${result.data['user']['firstName']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFFf1f1f1))),
                                    ),
                                  ],
                                ),
                                TextButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit),
                                  label: Text("Edit")
                                )
                              ],
                            ),
                          )
                        ),
                        Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 12.0,
                          shadowColor: Colors.black38,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          margin: EdgeInsets.only(top: 15),
                          child: Container(
                            color: Color(0xE5B5838D),
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Last Name", style: TextStyle(fontSize: 14, color: Color(0xFFe2e2e2), fontWeight: FontWeight.w400),),
                                    SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text("${result.data['user']['lastName']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFFf1f1f1))),
                                    ),
                                  ],
                                ),
                                TextButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit),
                                  label: Text("Edit")
                                )
                              ],
                            ),
                          )
                        ),
                        Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 12.0,
                          shadowColor: Colors.black38,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          margin: EdgeInsets.only(top: 15),
                          child: Container(
                            color: Color(0xE5B5838D),
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Email", style: TextStyle(fontSize: 14, color: Color(0xFFe2e2e2), fontWeight: FontWeight.w400),),
                                    SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text("${result.data['user']['email']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFFf1f1f1))),
                                    ),
                                  ],
                                ),
                                // TextButton.icon(
                                //   onPressed: () {},
                                //   icon: const Icon(Icons.edit),
                                //   label: Text("Edit")
                                // )
                              ],
                            ),
                          )
                        ),
                      ],
                    ),
                  ) : 
                  Container(
                
                  )
                ],
              )
            );
          },
        ),
      ),
    );
  }
}