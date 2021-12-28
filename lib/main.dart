import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smart_city_flutter/helper/authenticate.dart';
import 'package:smart_city_flutter/helper/helperfunctions.dart';
import 'package:smart_city_flutter/views/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {

  await dotenv.load(fileName: ".env");

  final HttpLink httpLink = HttpLink("http://10.56.11.224:8081/apis/graphql");

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
      theme: _buildSolidTheme(),
      // home: MyHomePage(),
      home: userLoggedIn != null 
          ? userLoggedIn ? const MyHomePage() : Authenticate()
          : Authenticate(),
    );
  }
}

ThemeData _buildSolidTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: _lightColor,
  );
}

ColorScheme _lightColor = const ColorScheme(
  primary: ColorOne, 
  background: ColorOne, 
  brightness: Brightness.light, 
  error: ColorOne, 
  onBackground: ColorOne, 
  onError: ColorOne, 
  onPrimary: Colors.white, 
  onSecondary: ColorFour, 
  onSurface: ColorTwo, 
  primaryVariant: ColorTwo, 
  secondary: ColorFive, 
  secondaryVariant: ColorFive, 
  surface: ColorTwo, 
);

const Color ColorFour = Color(0xFFFFCDB2);
const Color ColorTwo = Color(0xFFFFB4A2);
const Color ColorThree = Color(0xFFE5989B);
const Color ColorFive = Color(0xFFB5838D);
const Color ColorOne = Color(0xFF6D6875);

