import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_city_flutter/helper/helperfunctions.dart';
import 'package:smart_city_flutter/views/add_item_screen.dart';
import 'package:smart_city_flutter/views/categories.dart';
import 'package:smart_city_flutter/views/settings.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedDestination = 0;
  bool showMenu = false;
  String username = '';
  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    await HelperFunctions.getUserNameSharedPrefrences().then((value) {
      setState(() {
        username = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    var threshold = 100;

    final SimpleDialog dialog = SimpleDialog(
      elevation: 0,
      backgroundColor: Colors.white24,
      title: const Text(
        'Select Category to add',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      contentPadding: const EdgeInsets.all(16.0),
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.white30,
          width: 1,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      children: [
        Wrap(
          spacing: 10,
          children: [
            ActionChip(
              elevation: 3,
              backgroundColor: Color(0xFFc8dde3),
              labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              avatar: Icon(Icons.school, color: Color(0xFF82A3AC)),
              label: const Text('School'), 
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddItemScreen(categoryName: 'School',)));
              }
            ),
            ActionChip(
              elevation: 3,
              backgroundColor: Color(0xFFc8dde3),
              labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              avatar: Icon(Icons.house, color: Color(0xFF82A3AC)),
              label: const Text('College'), 
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddItemScreen(categoryName: 'College',)));
              }
            ),
            ActionChip(
              elevation: 3,
              backgroundColor: Color(0xFFc8dde3),
              labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              avatar: Icon(Icons.corporate_fare_outlined, color: Color(0xFF82A3AC)),
              label: const Text('University'), 
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddItemScreen(categoryName: 'University',)));
              }
            ),
            ActionChip(
              elevation: 3,
              backgroundColor: Color(0xFFc8dde3),
              labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              avatar: Icon(Icons.work, color: Color(0xFF82A3AC)),
              label: const Text('Job'), 
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddItemScreen(categoryName: 'Job',)));
              }
            ),
          ],
        ),
        
      ],
    );

    return SafeArea(
      child: Scaffold(
        body: Builder(
          builder: (context) {
            return Container(
              color: Color(0xFFB5838D),
              // height: MediaQuery.of(context).size.height,
              child: Row(
                // alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  NavigationRail(
                    backgroundColor: Color(0xFFB5838D),
                    minWidth: 55.0,
                    // extended: Styling.isLargeScreen(context),
                    trailing: IconButton(
                      onPressed: () {
                        // Navigator.pop(context);
                      }, 
                      icon: Icon(Icons.settings, color: Colors.white,),
                    ),
                    selectedIndex: _selectedDestination,
                    onDestinationSelected: (int index) {
                      setState(() {
                        _selectedDestination = index;
                      });
                    },
                    unselectedIconTheme: const IconThemeData(color: Color(0x90FFFFFF)),
                    labelType: NavigationRailLabelType.none,
                    selectedIconTheme: const IconThemeData(color: Colors.white),
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.home_outlined),
                        selectedIcon: Icon(Icons.home, color: Colors.white),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.school_outlined),
                        selectedIcon: Icon(Icons.school_rounded, color: Colors.white),
                        label: Text('School'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.class__outlined),
                        selectedIcon: Icon(Icons.class_, color: Colors.white),
                        label: Text('College'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.corporate_fare_outlined),
                        selectedIcon: Icon(Icons.corporate_fare_rounded, color: Colors.white),
                        label: Text('University'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.work_outline),
                        selectedIcon: Icon(Icons.work, color: Colors.white),
                        label: Text('Job'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.restaurant_rounded),
                        selectedIcon: Icon(Icons.restaurant_rounded, color: Colors.white),
                        label: Text('Restaurant'),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: _selectedDestination != 0 ? Container(
                          // color: Colors.amber,
                          child: Categories(categoryName: _selectedDestination == 1 ? 'Schools' : _selectedDestination == 2 ? 'Colleges' : _selectedDestination == 3 ?'Universities': _selectedDestination == 4 ? 'Jobs' : _selectedDestination == 5 ? 'Restaurants' : 'no',)
                        ) : Container(
                          child: Text('home goes here'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        ),
        floatingActionButton:
          FloatingActionButton.extended(
            foregroundColor: Colors.white,
            icon: const Icon(Icons.add), 
            label: const Text('Add'),
            backgroundColor: Color(0xFF6D6875),
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (context) => BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: dialog,
                )
              );
            }
          ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      ),
    );
  }
  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}
