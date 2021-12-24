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

const GET_JOBS = """
query FindAllJobs {
  findAllJobs {
    id
    name
    jobType
    description
    minSalary
    designation
    qualifications
    requirements
    lastDate
    startDate
    benefits
    eligibility
  }
}
""";

const GET_RESTAURANTS = """
query FindAllRestaurants {
  findAllRestaurants {
    id
    name
    image
    description
    price
    rating
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
    return 
    // widget.categoryName == "Schools" ?
     Query(
        options: QueryOptions(
          document: widget.categoryName == "Schools" ? gql(GET_SCHOOLS) : widget.categoryName == "Colleges" ? gql(GET_COLLEGES) : widget.categoryName == "Universities" ? gql(GET_UNIVERSITIES) : widget.categoryName == "Jobs" ? gql(GET_JOBS) : widget.categoryName == "Restaurants" ? gql(GET_RESTAURANTS): null,
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
        final response = result.data?[ widget.categoryName == 'Schools' ? 'findAllSchools' : widget.categoryName == 'Colleges' ? 'findAllColleges' : widget.categoryName == 'Universities' ? 'findAllUniversities' : widget.categoryName == 'Jobs' ? 'findAllJobs' : widget.categoryName == 'Restaurants' ? 'findAllRestaurants' : null];
        // final colleges = result.data?['findAllColleges'];
        // final universities = result.data?['findAllUniversities'];
        // final jobs = result.data?['findAllJobs'];
        // final restaurants = result.data?['findAllRestaurants'];
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
                child: response.length > 0 ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                    // childAspectRatio: 0.90,
                    mainAxisExtent: 180.0,
                  ),
                  itemCount: response.length,
                  itemBuilder: (context, int index) {
                    var resp = response[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () { 
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ItemScreen(id: resp['id'],name: resp['name'], category: widget.categoryName,)));
                          },
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 12.0,
                            shadowColor: Colors.black38,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Container(
                              color: Color(0xC5B5838D),
                              padding: EdgeInsets.all(10.0),
                              width: 160,
                              height: 160,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  widget.categoryName == "Jobs" ?
                                  Column (
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(resp['name'], style: TextStyle(fontSize: 18, color: Color(0xFFf1f1f1)),),
                                      SizedBox(height: 8),
                                      Text(resp['jobType'], style: TextStyle(color: Color(0xFFe2e2e2))),
                                    ],
                                  ) :
                                  widget.categoryName == "Restaurants" ?
                                  Column (
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(resp['name'], style: TextStyle(fontSize: 18, color: Color(0xFFf1f1f1)),),
                                      SizedBox(height: 8),
                                      Text(resp['price'], style: TextStyle(color: Color(0xFFe2e2e2))),
                                    ],
                                  ) :
                                  Column (
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(resp['name'], style: TextStyle(fontSize: 18, color: Color(0xFFf1f1f1)),),
                                      SizedBox(height: 8),
                                      Text(resp['contactInfo'], style: TextStyle(color: Color(0xFFe2e2e2))),
                                      SizedBox(height: 4),
                                      Text(resp['address'], style: TextStyle(color: Color(0xFFe2e2e2))),
                                    ],
                                  ),
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
      });
  }
}
