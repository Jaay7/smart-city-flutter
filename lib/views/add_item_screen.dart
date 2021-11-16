import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smart_city_flutter/widgets/widget.dart';

const addSchoolMutation = """
  mutation addSchool(\$name: String!, \$description: [String], \$contactInfo: String!, \$address: String!, \$standard: [String], \$board: String!) {
    addSchool(
      name: \$name,
      description: \$description,
      contactInfo: \$contactInfo,
      address: \$address,
      standard: \$standard,
      board: \$board
    )
  }
""";

const addCollegeMutation = """
  mutation addCollege(\$name: String!, \$description: [String], \$contactInfo: String!, \$address: String!, \$course: [String]) {
    addCollege(
      name: \$name,
      description: \$description,
      contactInfo: \$contactInfo,
      address: \$address,
      course: \$course
    )
  }
""";

const addUniversityMutation = """
  mutation addUniversity(\$name: String!, \$description: [String], \$contactInfo: String!, \$address: String!, \$branch: [String]) {
    addUniversity(
      name: \$name,
      description: \$description,
      contactInfo: \$contactInfo,
      address: \$address,
      branch: \$branch
    )
  }
""";

class AddItemScreen extends StatefulWidget {
  final String categoryName;

  const AddItemScreen({ Key? key, required this.categoryName }) : super(key: key);

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController = TextEditingController();
  TextEditingController contactTextEditingController = TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();
  TextEditingController standardTextEditingController = TextEditingController();
  TextEditingController boardTextEditingController = TextEditingController();

  List<String> descriptionList = [];
  List<String> standardList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new ${widget.categoryName}'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: widget.categoryName == 'School' ? Column(
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
                    height: 110,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name of the School", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        TextFormField(
                          controller: nameTextEditingController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(6.0),
                            hintText: 'Name',
                          ),
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
                  margin: EdgeInsets.only(top: 15),
                  child: Container(
                    // height: 110,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Description of the School", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        for(var desc in descriptionList) ActionChip(
                          label: Text("$desc"), 
                          avatar: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              descriptionList.remove(desc);
                            });
                          }
                        ),
                        Wrap(
                          alignment: WrapAlignment.end,
                          children: [
                            TextFormField(
                              controller: descriptionTextEditingController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(6.0),
                                hintText: 'Description',
                              ),
                            ),
                            ElevatedButton.icon(
                              icon: Icon(Icons.add),
                              label: Text("Add"),
                              onPressed: () {
                                if (descriptionTextEditingController.text.isNotEmpty) {
                                  setState(() {
                                    descriptionList.add(descriptionTextEditingController.text);
                                    descriptionTextEditingController.text = '';
                                  });
                                } else {
                                  final snackBar = SnackBar(
                                    backgroundColor: Color(0xFF464646),
                                    duration: Duration(seconds: 1),
                                    behavior: SnackBarBehavior.floating,
                                    content: Text('Cannot add empty description'),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                              },
                            )
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
                  margin: EdgeInsets.only(top: 15),
                  child: Container(
                    height: 110,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Contact number of the School", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        TextFormField(
                          controller: contactTextEditingController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(6.0),
                            hintText: 'Contact',
                          ),
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
                  margin: EdgeInsets.only(top: 15),
                  child: Container(
                    height: 110,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Address of the School", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        TextFormField(
                          controller: addressTextEditingController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(6.0),
                            hintText: 'Address',
                          ),
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
                  margin: EdgeInsets.only(top: 15),
                  child: Container(
                    // height: 110,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Standards in the School", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        for(var std in standardList) ActionChip(
                          label: Text("$std"), 
                          avatar: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              descriptionList.remove(std);
                            });
                          }
                        ),
                        Wrap(
                          alignment: WrapAlignment.end,
                          children: [
                            TextFormField(
                              controller: standardTextEditingController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(6.0),
                                hintText: 'Standard',
                              ),
                            ),
                            ElevatedButton.icon(
                              icon: Icon(Icons.add),
                              label: Text("Add"),
                              onPressed: () {
                                if (standardTextEditingController.text.isNotEmpty) {
                                  setState(() {
                                    standardList.add(standardTextEditingController.text);
                                    standardTextEditingController.text = '';
                                  });
                                } else {
                                  final snackBar = SnackBar(
                                    backgroundColor: Color(0xFF464646),
                                    duration: Duration(seconds: 1),
                                    behavior: SnackBarBehavior.floating,
                                    content: Text('Cannot add empty standard'),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                              },
                            )
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
                  margin: EdgeInsets.only(top: 15),
                  child: Container(
                    height: 110,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Board of the School", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        TextFormField(
                          controller: boardTextEditingController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(6.0),
                            hintText: 'Board',
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ],
            ) 
            : widget.categoryName == 'College' ?
              Column(

              ) 
            : widget.categoryName == 'University' ? Column(

            ) : Center(
              child: Text("No Data"),
            ),
          ),
        ),
      ),
      floatingActionButton: Mutation(
        options: MutationOptions(
          document: widget.categoryName == 'School' ? gql(addSchoolMutation) : widget.categoryName == 'College' ? gql(addCollegeMutation) : widget.categoryName == 'University' ? gql(addUniversityMutation) : null,
          onCompleted: (dynamic result) {
            print(result);
            final snackBar = SnackBar(
              backgroundColor: Color(0xFF464646),
              duration: Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
              content: Text('Successfully added new ${widget.categoryName}'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            // Navigator.pop(context);
          },
        ), builder: (
          RunMutation runMutation,
          QueryResult result,
        )
        {
          return FloatingActionButton.extended(
          // backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          onPressed: () {
            if (widget.categoryName == 'School') {
              if (nameTextEditingController.text.isNotEmpty && descriptionList.isNotEmpty && contactTextEditingController.text.isNotEmpty && addressTextEditingController.text.isNotEmpty && standardList.isNotEmpty && boardTextEditingController.text.isNotEmpty) {
                runMutation({
                  'name': nameTextEditingController.text,
                  'description': descriptionList,
                  'contact': contactTextEditingController.text,
                  'address': addressTextEditingController.text,
                  'standard': standardList,
                  'board': boardTextEditingController.text,
                });
              }
              else {
                final snackBar = SnackBar(
                  backgroundColor: Color(0xFF464646),
                  duration: Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                  content: Text('Please fill all the details'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }
          },
          icon: Icon(Icons.bookmark_border),
          label: Text('Save'),
        );
        },
      ),
    );
  }
}