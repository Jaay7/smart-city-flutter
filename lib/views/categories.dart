import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smart_city_flutter/views/item_screen.dart';
import 'package:animations/animations.dart';
import 'package:provider/provider.dart';

const GET_SCHOOLS = """
query FindAllSchools{
    findAllSchools {
        id
        name
        description
        contactInfo
        address
        standard
        board
    }
}
""";

const GET_COLLEGES = """
query FindAllColleges {
    findAllColleges {
        id
        name
        description
        contactInfo
        address
        course
    }
}
""";

const GET_UNIVERSITIES = """
query FindAllUniversities {
    findAllUniversities {
        id
        name
        description
        contactInfo
        address
        branch
    }
}
""";

class Categories extends StatefulWidget {
  final String categoryName;

  const Categories({Key? key, required this.categoryName}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return widget.categoryName == "Schools" ? Query(
        options: QueryOptions(
          document: gql(GET_SCHOOLS),
          pollInterval: Duration(seconds: 1),
        ), 
        builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }
        if (result.isLoading) {
          return Center(
            heightFactor: 13.0, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Loading"),
                ),
              ],
            ),
          );
        }
        final schools = result.data?['findAllSchools'];
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Padding(padding: EdgeInsets.all(10.0)),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(bottom: 15, top: 10),
              child: Text("${widget.categoryName}", style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500))
            ),
            Expanded(
              child: SizedBox(
                child: schools.length > 0 ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                    // childAspectRatio: 0.90,
                    mainAxisExtent: 180.0,
                  ),
                  itemCount: schools.length,
                  itemBuilder: (context, int index) {
                    var school = schools[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () { 
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ItemScreen(id: school['id'],name: school['name'], category: 'School')));
                          },
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 12.0,
                            shadowColor: Colors.black38,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              width: 160,
                              height: 160,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(school['name'], style: TextStyle(fontSize: 18, color: Color(0xFF636363)),),
                                  SizedBox(height: 8),
                                  Text(school['contactInfo'], style: TextStyle(color: Color(0xFF727272))),
                                  SizedBox(height: 4),
                                  Text(school['address'], style: TextStyle(color: Color(0xFF727272))),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                ) : Center(
                  child: Text("No ${widget.categoryName} found!"),
                ),
              )
            )
          ],
        );
      }) : 
      // colleges
      widget.categoryName == "Colleges" ? Query(
        options: QueryOptions(
          document: gql(GET_COLLEGES),
          pollInterval: Duration(seconds: 1),
        ), 
        builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }
        if (result.isLoading) {
          return Center(
            heightFactor: 13.0, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Loading"),
                ),
              ],
            ),
          );
        }
        final colleges = result.data?['findAllColleges'];
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Padding(padding: EdgeInsets.all(10.0)),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(bottom: 15, top: 10),
              child: Text("${widget.categoryName}", style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500))
            ),
            Expanded(
              child: SizedBox(
                child: colleges.length > 0 ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                    // childAspectRatio: 0.80,
                    mainAxisExtent: 180.0,
                  ),
                  itemCount: colleges.length,
                  itemBuilder: (context, int index) {
                    var college = colleges[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () { 
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ItemScreen(id: college['id'],name: college['name'], category: 'College')));
                          },
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 12.0,
                            shadowColor: Colors.black38,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              width: 160,
                              height: 160,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(college['name'], style: TextStyle(fontSize: 18, color: Color(0xFF636363)),),
                                  SizedBox(height: 8),
                                  Text(college['contactInfo'], style: TextStyle(color: Color(0xFF727272))),
                                  SizedBox(height: 4),
                                  Text(college['address'], style: TextStyle(color: Color(0xFF727272))),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                ): Center(
                  child: Text("No ${widget.categoryName} found!"),
                ),
              )
            )
          ],
        );
      }) : 
      // universities
      widget.categoryName == "Universities" ? Query(
        options: QueryOptions(
          document: gql(GET_UNIVERSITIES),
          pollInterval: const Duration(milliseconds: 500),
        ), 
        builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }
        if (result.isLoading) {
          return Center(
            heightFactor: 13.0, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Loading"),
                ),
              ],
            ),
          );
        }
        final universities = result.data?['findAllUniversities'];
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Padding(padding: EdgeInsets.all(10.0)),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(bottom: 15, top: 10),
              child: Text("${widget.categoryName}", style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500))
            ),
            Expanded(
              child: SizedBox(
                child: universities.length > 0 ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                    // childAspectRatio: 0.80,
                    mainAxisExtent: 180.0,
                  ),
                  itemCount: universities.length,
                  itemBuilder: (context, int index) {
                    var university = universities[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () { 
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ItemScreen(id: university['id'],name: university['name'], category: 'University')));
                          },
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 12.0,
                            shadowColor: Colors.black38,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              width: 160,
                              height: 160,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(university['name'], style: TextStyle(fontSize: 18, color: Color(0xFF636363)),),
                                  SizedBox(height: 8),
                                  Text(university['contactInfo'], style: TextStyle(color: Color(0xFF727272))),
                                  SizedBox(height: 8),
                                  Text(university['address'], style: TextStyle(color: Color(0xFF727272))),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                ): Center(
                  child: Text("No ${widget.categoryName} found!"),
                ),
              )
            )
          ],
        );
      }) : Text("Cannot retrive the Data");
  }
}
