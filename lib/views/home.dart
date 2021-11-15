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
  String email = '';
  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    await HelperFunctions.getUserNameSharedPrefrences().then((value) {
      setState(() {
        email = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    var threshold = 100;

    final SimpleDialog dialog = SimpleDialog(
      elevation: 10,
      title: Text(
        'Select Category to add',
        style: textTheme.headline6,
      ),
      contentPadding: const EdgeInsets.all(16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      children: [
        Wrap(
          spacing: 10,
          children: [
            ActionChip(
              elevation: 3,
              backgroundColor: Colors.green.shade100,
              labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              avatar: Icon(Icons.school, color: Colors.green.shade900),
              label: const Text('School'), 
              onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddItemScreen(categoryName: 'School',)));
              }
            ),
            ActionChip(
              elevation: 3,
              backgroundColor: Colors.green.shade100,
              labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              avatar: Icon(Icons.house, color: Colors.green.shade900),
              label: const Text('College'), 
              onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddItemScreen(categoryName: 'College',)));
              }
            ),
            ActionChip(
              elevation: 3,
              backgroundColor: Colors.green.shade100,
              labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              avatar: Icon(Icons.work, color: Colors.green.shade900),
              label: const Text('University'), 
              onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddItemScreen(categoryName: 'University',)));
              }
            ),
          ],
        ),
        
      ],
    );

    return Scaffold(
      appBar: AppBar(
        primary: true,
        title: Text("Smart City"),
        toolbarHeight: 60.0,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
          setState(() {
            showMenu = !showMenu;
          });
        }, icon: Icon(Icons.menu)),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings, 
            ), onPressed: () { 
              Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
            },
          )
        ],
      ),
      body: Builder(
        builder: (context) {
          return Container(
            color: Colors.green,
            // height: MediaQuery.of(context).size.height,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column( children: [
                  Container(
                    height: 200,
                    child: ListTileTheme(
                      selectedColor: Colors.white,
                      textColor: Color(0x80FFFFFF),
                      iconColor: Color(0x80FFFFFF),
                      child: ListView(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.school),
                            title: Text('Schools'),
                            selected: _selectedDestination == 0,
                            onTap: () => selectDestination(0),
                          ),
                          ListTile(
                            leading: Icon(Icons.house),
                            title: Text('Colleges'),
                            selected: _selectedDestination == 1,
                            onTap: () => selectDestination(1),
                          ),
                          ListTile(
                            leading: Icon(Icons.work),
                            title: Text('Universities'),
                            selected: _selectedDestination == 2,
                            onTap: () => selectDestination(2),
                          ),
                        ],
                      ),
                    ),
                  )
                ],),
                AnimatedPositioned(
                  curve: Curves.fastOutSlowIn,
                  duration: const Duration(milliseconds: 500),
                  height: showMenu == false ? MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top-100.0 : MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top-280.0,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    // alignment: Alignment(0.0, -1.0),
                    // height: showMenu == false ? MediaQuery.of(context).size.height-60 : MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top-240,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.5,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        // color: Colors.amber,
                        child: Categories(categoryName: _selectedDestination == 0 ? 'Schools' : _selectedDestination == 1 ? 'Colleges' : 'Universities',)
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: Row(
      //     children: [
      //       IconButton(icon: Icon(Icons.menu), onPressed: () {}),
      //       Spacer(),
      //       IconButton(icon: Icon(Icons.search), onPressed: () {}),
      //       IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
      //     ],
      //   ),
      // ),
      floatingActionButton:
        FloatingActionButton(
          child: Icon(Icons.add), 
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (context) => new BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: dialog,
              )
            );
            // showModalBottomSheet(
            //   enableDrag: true,
            //   context: context, 
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.only(
            //       topLeft: Radius.circular(25.0),
            //       topRight: Radius.circular(25.0)),
            //     ),
            //   builder: (context) {
            //     return Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Container(
            //         height: MediaQuery.of(context).size.height,
            //         child: Text("Search")),
            //     );
            //   }
            // );
          }
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
    );
  }
  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3 + 60,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Item 1'),
              // selected: _selectedDestination == 0,
              // onTap: () => selectDestination(0),
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Item 2'),
              // selected: _selectedDestination == 1,
              // onTap: () => selectDestination(1),
            ),
            ListTile(
              leading: Icon(Icons.label),
              title: Text('Item 3'),
              // selected: _selectedDestination == 2,
              // onTap: () => selectDestination(2),
            ),
        ],
      ),
    );
  }
}