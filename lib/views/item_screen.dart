import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const GET_UNIVERSITY = """
query University(\$id: String!) {
    university(id: \$id) {
        id
        name
        description
        contactInfo
        address
        branch
    }
}
""";

const GET_SCHOOL = """
query School(\$id: String!) {
    school(id: \$id) {
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

const GET_COLLEGE = """
query College(\$id: String!) {
    college(id: \$id) {
        id
        name
        description
        contactInfo
        address
        course
    }
}
""";

class ItemScreen extends StatefulWidget {
  final String name;
  final String category;
  final String id;
  const ItemScreen({ Key? key, required this.name,required this.id, required this.category }) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${widget.name}"),
        ),
        body: SingleChildScrollView(
            child: widget.category == 'School' ? Query(
            options: QueryOptions(
            document: gql(GET_SCHOOL),
            pollInterval: const Duration(milliseconds: 500),
            variables: {
              "id": widget.id 
            }
          ), 
          builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }
            if (result.isLoading) {
              return Center(heightFactor: 13.0, child: CircularProgressIndicator(),);
            }
            final school = result.data['school'];
            return Padding(
              padding: const EdgeInsets.all(16.0),
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
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Contact Info", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                          Spacer(),
                          Row(
                            children: [
                              Icon(Icons.phone, size: 16),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(school['contactInfo']),
                              ),
                            ],
                          ),
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
                    margin: EdgeInsets.only(top: 25),
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Address", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                          Spacer(),
                          Row(
                            children: [
                              Icon(Icons.store, size: 16),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(school['address']),
                              ),
                            ],
                          ),
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
                    margin: EdgeInsets.only(top: 25),
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,),),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for(var desc in school['description']) Row(
                              children: [
                                Icon(Icons.circle, size: 6),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text("$desc"),
                                ),
                              ],
                            )
                          ],
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
                    margin: EdgeInsets.only(top: 25),
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Standard", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,),),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for(var stand in school['standard']) Row(
                              children: [
                                Icon(Icons.circle, size: 6),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text("$stand"),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    )
                  ),
                ],
              ),
            );
          }
        ) :
// college
        widget.category == 'College' ? Query(
            options: QueryOptions(
            document: gql(GET_COLLEGE),
            pollInterval: const Duration(milliseconds: 500),
            variables: {
              "id": widget.id 
            }
          ), 
          builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }
            if (result.isLoading) {
              return Center(heightFactor: 13.0, child: CircularProgressIndicator(),);
            }
            final college = result.data['college'];
            return Padding(
              padding: const EdgeInsets.all(16.0),
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
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Contact Info", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                          Spacer(),
                          Row(
                            children: [
                              Icon(Icons.phone, size: 16),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(college['contactInfo']),
                              ),
                            ],
                          ),
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
                    margin: EdgeInsets.only(top: 25),
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Address", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                          Spacer(),
                          Row(
                            children: [
                              Icon(Icons.store, size: 16),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(college['address']),
                              ),
                            ],
                          ),
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
                    margin: EdgeInsets.only(top: 25),
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,),),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for(var desc in college['description']) Row(
                              children: [
                                Icon(Icons.circle, size: 6),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text("$desc"),
                                ),
                              ],
                            )
                          ],
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
                    margin: EdgeInsets.only(top: 25),
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Courses", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,),),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for(var course in college['course']) Row(
                              children: [
                                Icon(Icons.circle, size: 6),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text("$course"),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    )
                  ),
                ],
              ),
            );
          }
        ) :
// university
        widget.category == 'University' ? Query(
            options: QueryOptions(
            document: gql(GET_UNIVERSITY),
            pollInterval: const Duration(milliseconds: 500),
            variables: {
              "id": widget.id 
            }
          ), 
          builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }
            if (result.isLoading) {
              return Center(heightFactor: 13.0, child: CircularProgressIndicator(),);
            }
            final university = result.data['university'];
            return Padding(
              padding: const EdgeInsets.all(16.0),
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
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Contact Info", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                          Spacer(),
                          Row(
                            children: [
                              Icon(Icons.phone, size: 16),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(university['contactInfo']),
                              ),
                            ],
                          ),
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
                    margin: EdgeInsets.only(top: 25),
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Address", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                          Spacer(),
                          Row(
                            children: [
                              Icon(Icons.store, size: 16),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(university['address']),
                              ),
                            ],
                          ),
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
                    margin: EdgeInsets.only(top: 25),
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,),),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for(var desc in university['description']) Row(
                              children: [
                                Icon(Icons.circle, size: 6),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text("$desc"),
                                ),
                              ],
                            )
                          ],
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
                    margin: EdgeInsets.only(top: 25),
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Branches", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,),),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for(var branch in university['branch']) Row(
                              children: [
                                Icon(Icons.circle, size: 6),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text("$branch"),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    )
                  ),
                ],
              ),
            );
          }
        ) : 
        Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              Text("No data"),
            ],
          )
        ),
        )
      ),
    );
  }
}