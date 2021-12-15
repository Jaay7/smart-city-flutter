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
    return Scaffold(
      appBar: AppBar(
        primary: true,
        // title: Text("${widget.name}"),
        backgroundColor: const Color(0xD9D1ACA5),
        elevation: 0,
      ),
      body: widget.category == 'School' ? Query(
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
        return const Center(heightFactor: 13.0, child: CircularProgressIndicator(),);
      }
      final school = result.data['school'];
      return Container(
        height: MediaQuery.of(context).size.height,
        color: Color(0x60E2CFC9),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.26,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0)
                ),
                color: Color(0xD1D1ACA5),
              ),
              child: Text(school['name'], style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black54),),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.18,
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(
                          0.0,
                          0.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.5,
                      ), //BoxShadow
                    ],
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width - 40,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Contact Info", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                SizedBox(height: 10.0,),
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
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Address", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                SizedBox(height: 10.0,),
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
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,),),
                                SizedBox(height: 10.0,),
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
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Standard", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,),),
                                SizedBox(height: 10.0,),
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
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Board", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                SizedBox(height: 10.0,),
                                Row(
                                  children: [
                                    Icon(Icons.school, size: 16),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(school['board']),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),
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
      return Container(
        height: MediaQuery.of(context).size.height,
        color: Color(0x60E2CFC9),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.26,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0)
                ),
                color: Color(0xD1D1ACA5),
              ),
              child: Text(college['name'], style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black54),),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.18,
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(
                          0.0,
                          0.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.5,
                      ), //BoxShadow
                    ],
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width - 40,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Contact Info", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                SizedBox(height: 10.0,),
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
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Address", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                SizedBox(height: 10.0,),
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
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,),),
                                SizedBox(height: 10.0,),
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
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Courses", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,),),
                                SizedBox(height: 10.0,),
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
                          ),
                        ],
                      ),
                    ),
                  )
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
      return Container(
        height: MediaQuery.of(context).size.height,
        color: Color(0x60E2CFC9),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.26,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0)
                ),
                color: Color(0xD1D1ACA5),
              ),
              child: Text(university['name'], style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black54),),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.18,
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(
                          0.0,
                          0.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.5,
                      ), //BoxShadow
                    ],
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width - 40,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Contact Info", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                SizedBox(height: 10.0,),
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
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Address", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                SizedBox(height: 10.0,),
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
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,),),
                                SizedBox(height: 10.0,),
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
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Branches", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,),),
                                SizedBox(height: 10.0,),
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
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
              ),
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
      floatingActionButton: FloatingActionButton.extended(
        // backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () {
          // Respond to button press
        },
        icon: Icon(Icons.favorite_outline),
        label: Text('Favourite'),
      ),
    );
  }
}