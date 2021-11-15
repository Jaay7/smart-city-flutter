import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smart_city_flutter/helper/authenticate.dart';
import 'package:smart_city_flutter/helper/helperfunctions.dart';
import 'package:smart_city_flutter/views/home.dart';
import 'package:flutter/cupertino.dart';

void main() {
  final HttpLink httpLink = HttpLink("http://localhost:8081/apis/graphql");

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore())
    ),
  );

  var app = GraphQLProvider(client: client, child: const MyApp());

  runApp(app);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userLoggedIn = false;
  @override
  void initState() {
    getUserLoggedIn();
    super.initState();
  }

  getUserLoggedIn() async {
    await HelperFunctions.getUserLoggedInSharedPrefrences().then((value) {
      setState(() {
        userLoggedIn = value;
      });
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // home: MyHomePage(),
      home: userLoggedIn != null 
          ? userLoggedIn ? const MyHomePage() : Authenticate()
          : Authenticate(),
    );
  }
}

