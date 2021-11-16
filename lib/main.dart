import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smart_city_flutter/helper/authenticate.dart';
import 'package:smart_city_flutter/helper/helperfunctions.dart';
import 'package:smart_city_flutter/views/home.dart';
import 'package:flutter/cupertino.dart';

void main() {
  final HttpLink httpLink = HttpLink("http://192.168.1.125:8081/apis/graphql");
  // final HttpLink httpLink = HttpLink("http://localhost:8081/apis/graphql");

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
  primary: ClamShell, 
  background: ClamShell, 
  brightness: Brightness.light, 
  error: ClamShell, 
  onBackground: ClamShell, 
  onError: ClamShell, 
  onPrimary: Colors.white, 
  onSecondary: Opal, 
  onSurface: PearlBush, 
  primaryVariant: PearlBush, 
  secondary: Ziggurat, 
  secondaryVariant: Opal, 
  surface: PearlBush, 
);

const Color ClamShell = Color(0xFFD1ACA5);
const Color PearlBush = Color(0xFFE2CFC9);
const Color JetStream = Color(0xFFBFD8D2);
const Color Opal = Color(0xFFA9C7C5);
const Color Ziggurat = Color(0xFF82A3AC);

