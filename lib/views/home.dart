import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_city_flutter/helper/helperfunctions.dart';
import 'package:smart_city_flutter/views/add_item_screen.dart';
import 'package:smart_city_flutter/views/categories.dart';
import 'package:smart_city_flutter/views/settings.dart';


const searchQuery = """
query Query(\$schoolVal: String, \$jobsVal: String, \$collegesVal: String, \$universitiesVal: String, \$restaurantsVal: String, \$touristPlacesVal: String) {
  searchSchools(val: \$schoolVal) {
    id
    name
    address
    contactInfo
  }
  searchJobs(val: \$jobsVal) {
    id
    name
    jobType
    minSalary
  }
  searchColleges(val: \$collegesVal) {
    id
    name
    contactInfo
  }
  searchUniversities(val: \$universitiesVal) {
    id
    name
    contactInfo
  }
  searchRestaurants(val: \$restaurantsVal) {
    id
    name
    rating
    price
  }
  searchTouristPlaces(val: \$touristPlacesVal) {
    id
    city
    state
    country
    tourismName
  }
}
""";
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
  String _searchText = '';
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

  TextEditingController searchTextEditingController = TextEditingController();

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
        resizeToAvoidBottomInset: false,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Settings(),
                          ),
                        );
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
                      NavigationRailDestination(
                        icon: Icon(Icons.tour_outlined),
                        selectedIcon: Icon(Icons.tour_rounded, color: Colors.white),
                        label: Text('Tourism'),
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
                          child: Categories(categoryName: _selectedDestination == 1 ? 'Schools' : _selectedDestination == 2 ? 'Colleges' : _selectedDestination == 3 ?'Universities': _selectedDestination == 4 ? 'Jobs' : _selectedDestination == 5 ? 'Restaurants' : 'TouristPlaces',)
                        ) : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Welcome to Smart City', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black54)),
                              const SizedBox(height: 15,),
                              const Text('What would you like to do today?', style: TextStyle(fontSize: 16, color: Colors.black54)),
                              const SizedBox(height: 15,),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFFc8dde3),
                                ),
                                child: TextFormField(
                                  controller: searchTextEditingController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.search, color: Colors.black54),
                                    hintText: 'Search here...',
                                    hintStyle: TextStyle(color: Colors.black54),
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(color: Colors.black54),
                                  onChanged: (value) {
                                    setState(() {
                                      _searchText = value;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: _searchText == '' ?
                                Container(
                                  alignment: Alignment.center,
                                  height: MediaQuery.of(context).size.height * 0.5,
                                  child: Text("No items to show", style: TextStyle(fontSize: 16, color: Colors.black54)),
                                )
                                : Query(
                                  options: QueryOptions(
                                    document: gql(searchQuery),
                                    pollInterval: const Duration(milliseconds: 500),
                                    variables: {
                                      'schoolVal': _searchText,
                                      'jobsVal': _searchText,
                                      'collegesVal': _searchText,
                                      'universitiesVal': _searchText,
                                      'restaurantsVal': _searchText,
                                      'touristPlacesVal': _searchText,
                                    },
                                  ),
                                  builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
                                    if (result.hasException) {
                                      return Text(result.exception.toString());
                                    }
                                    if (result.isLoading) {
                                      return Center(child: CircularProgressIndicator());
                                    }
                                    final schools = result.data['searchSchools'];
                                    final jobs = result.data['searchJobs'];
                                    final colleges = result.data['searchColleges'];
                                    final universities = result.data['searchUniversities'];
                                    final restaurants = result.data['searchRestaurants'];
                                    final touristPlaces = result.data['searchTouristPlaces'];
                                    return Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Schools", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black54)),
                                          const SizedBox(height: 10,),
                                          for( var sch in schools ) Container(
                                            padding: const EdgeInsets.symmetric(vertical: 5),
                                            width: MediaQuery.of(context).size.width,
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(25),
                                                    color: Color(0xFFc8dde3),
                                                    image: DecorationImage(
                                                      image: NetworkImage('https://images.unsplash.com/photo-1497864149936-d3163f0c0f4b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                ),
                                                const SizedBox(width: 10,),
                                                Text(sch['name'], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),),
                                              ],
                                            )
                                          ),
                                          const SizedBox(height: 10,),
                                          Text("Colleges", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black54)),
                                          const SizedBox(height: 10,),
                                          for( var col in colleges ) Container(
                                            padding: const EdgeInsets.symmetric(vertical: 5),
                                            width: MediaQuery.of(context).size.width,
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(25),
                                                    color: Color(0xFFc8dde3),
                                                    image: DecorationImage(
                                                      image: NetworkImage('https://images.unsplash.com/photo-1497864149936-d3163f0c0f4b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                ),
                                                const SizedBox(width: 10,),
                                                Text(col['name'], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),),
                                              ],
                                            )
                                          ),
                                          const SizedBox(height: 10,),
                                          Text("Universities", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black54)),
                                          const SizedBox(height: 10,),
                                          for( var uni in universities ) Container(
                                            padding: const EdgeInsets.symmetric(vertical: 5),
                                            width: MediaQuery.of(context).size.width,
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(25),
                                                    color: Color(0xFFc8dde3),
                                                    image: DecorationImage(
                                                      image: NetworkImage('https://images.unsplash.com/photo-1497864149936-d3163f0c0f4b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                ),
                                                const SizedBox(width: 10,),
                                                Text(uni['name'], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),),
                                              ],
                                            )
                                          ),
                                          const SizedBox(height: 10,),
                                          Text("Jobs", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black54)),
                                          const SizedBox(height: 10,),
                                          for( var job in jobs ) Container(
                                            padding: const EdgeInsets.symmetric(vertical: 5),
                                            width: MediaQuery.of(context).size.width,
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(25),
                                                    color: Color(0xFFc8dde3),
                                                    image: DecorationImage(
                                                      image: NetworkImage('https://images.unsplash.com/photo-1497864149936-d3163f0c0f4b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                ),
                                                const SizedBox(width: 10,),
                                                Text(job['name'], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),),
                                              ],
                                            )
                                          ),
                                          const SizedBox(height: 10,),
                                          Text("Restaurants", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black54)),
                                          const SizedBox(height: 10,),
                                          for( var res in restaurants ) Container(
                                            padding: const EdgeInsets.symmetric(vertical: 5),
                                            width: MediaQuery.of(context).size.width,
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(25),
                                                    color: Color(0xFFc8dde3),
                                                    image: DecorationImage(
                                                      image: NetworkImage('https://images.unsplash.com/photo-1497864149936-d3163f0c0f4b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                ),
                                                const SizedBox(width: 10,),
                                                Text(res['name'], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),),
                                              ],
                                            )
                                          ),
                                          const SizedBox(height: 10,),
                                          Text("Tourist Places", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black54)),
                                          const SizedBox(height: 10,),
                                          for( var place in touristPlaces ) Container(
                                            padding: const EdgeInsets.symmetric(vertical: 5),
                                            width: MediaQuery.of(context).size.width,
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(25),
                                                    color: Color(0xFFc8dde3),
                                                    image: DecorationImage(
                                                      image: NetworkImage('https://images.unsplash.com/photo-1497864149936-d3163f0c0f4b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                ),
                                                const SizedBox(width: 10,),
                                                Text(place['tourismName'], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),),
                                              ],
                                            )
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                ),
                              )
                            ],
                          ),
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
