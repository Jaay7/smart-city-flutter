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

const addJobMutation = """
mutation Mutation(\$name: String!, \$jobType: String!, \$description: [String], \$minSalary: String!, \$designation: String!, \$qualifications: String!, \$requirements: [String],\$lastDate: String!, \$startDate: String!,  \$benefits: [String], \$eligibility: [String]) {
  addJob(
    name: \$name, 
    jobType: \$jobType, 
    description: \$description, 
    minSalary: \$minSalary, 
    designation: \$designation, 
    qualifications: \$qualifications, 
    requirements: \$requirements, 
    lastDate: \$lastDate, 
    startDate: \$startDate, 
    benefits: \$benefits, 
    eligibility: \$eligibility
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

  TextEditingController schoolNameTextEditingController = TextEditingController();
  TextEditingController schoolDescriptionTextEditingController = TextEditingController();
  TextEditingController schoolContactTextEditingController = TextEditingController();
  TextEditingController schoolAddressTextEditingController = TextEditingController();
  TextEditingController schoolStandardTextEditingController = TextEditingController();
  TextEditingController schoolBoardTextEditingController = TextEditingController();

  TextEditingController collegeNameTextEditingController = TextEditingController();
  TextEditingController collegeDescriptionTextEditingController = TextEditingController();
  TextEditingController collegeContactTextEditingController = TextEditingController();
  TextEditingController collegeAddressTextEditingController = TextEditingController();
  TextEditingController collegeCourseTextEditingController = TextEditingController();

  TextEditingController universityNameTextEditingController = TextEditingController();
  TextEditingController universityDescriptionTextEditingController = TextEditingController();
  TextEditingController universityContactTextEditingController = TextEditingController();
  TextEditingController universityAddressTextEditingController = TextEditingController();
  TextEditingController universityBranchTextEditingController = TextEditingController();

  TextEditingController jobNameTextEditingController = TextEditingController();
  TextEditingController jobTypeTextEditingController = TextEditingController();
  TextEditingController jobDescriptionTextEditingController = TextEditingController();
  TextEditingController jobMinSalaryTextEditingController = TextEditingController();
  TextEditingController jobDesignationTextEditingController = TextEditingController();
  TextEditingController jobQualificationsTextEditingController = TextEditingController();
  TextEditingController jobRequirementsTextEditingController = TextEditingController();
  TextEditingController jobLastDateTextEditingController = TextEditingController();
  TextEditingController jobStartDateTextEditingController = TextEditingController();
  TextEditingController jobBenefitsTextEditingController = TextEditingController();
  TextEditingController jobEligibilityTextEditingController = TextEditingController();

  List<String> schoolDescriptionList = [];
  List<String> schoolStandardList = [];

  List<String> collegeDescriptionList = [];
  List<String> collegeCourseList = [];

  List<String> universityDescriptionList = [];
  List<String> universityBranchList = [];

  List<String> jobDescriptionList = [];
  List<String> jobRequirementsList = [];
  List<String> jobBenefitsList = [];
  List<String> jobEligibilityList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new ${widget.categoryName}'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 60.0),
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
                          controller: schoolNameTextEditingController,
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
                        for(var desc in schoolDescriptionList) ActionChip(
                          label: Text("$desc"), 
                          avatar: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              schoolDescriptionList.remove(desc);
                            });
                          }
                        ),
                        Wrap(
                          alignment: WrapAlignment.end,
                          children: [
                            TextFormField(
                              controller: schoolDescriptionTextEditingController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(6.0),
                                hintText: 'Description',
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 14),
                              child: ElevatedButton.icon(
                                icon: Icon(Icons.add),
                                label: Text("Add"),
                                onPressed: () {
                                  if (schoolDescriptionTextEditingController.text.isNotEmpty) {
                                    setState(() {
                                      schoolDescriptionList.add(schoolDescriptionTextEditingController.text);
                                      schoolDescriptionTextEditingController.text = '';
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
                              ),
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
                          controller: schoolContactTextEditingController,
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
                          controller: schoolAddressTextEditingController,
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
                        for(var std in schoolStandardList) ActionChip(
                          label: Text("$std"), 
                          avatar: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              schoolDescriptionList.remove(std);
                            });
                          }
                        ),
                        Wrap(
                          alignment: WrapAlignment.end,
                          children: [
                            TextFormField(
                              controller: schoolStandardTextEditingController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(6.0),
                                hintText: 'Standard',
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 14),
                              child: ElevatedButton.icon(
                                icon: Icon(Icons.add),
                                label: Text("Add"),
                                onPressed: () {
                                  if (schoolStandardTextEditingController.text.isNotEmpty) {
                                    setState(() {
                                      schoolStandardList.add(schoolStandardTextEditingController.text);
                                      schoolStandardTextEditingController.text = '';
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
                              ),
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
                          controller: schoolBoardTextEditingController,
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
                          Text("Name of the College", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                          TextFormField(
                            controller: collegeNameTextEditingController,
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
                          Text("Description of the College", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                          for(var desc in collegeDescriptionList) ActionChip(
                            label: Text("$desc"), 
                            avatar: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                collegeDescriptionList.remove(desc);
                              });
                            }
                          ),
                          Wrap(
                            alignment: WrapAlignment.end,
                            children: [
                              TextFormField(
                                controller: collegeDescriptionTextEditingController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(6.0),
                                  hintText: 'Description',
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 14),
                                child: ElevatedButton.icon(
                                  icon: Icon(Icons.add),
                                  label: Text("Add"),
                                  onPressed: () {
                                    if (collegeDescriptionTextEditingController.text.isNotEmpty) {
                                      setState(() {
                                        collegeDescriptionList.add(collegeDescriptionTextEditingController.text);
                                        collegeDescriptionTextEditingController.text = '';
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
                                ),
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
                          Text("Contact number of the College", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                          TextFormField(
                            controller: collegeContactTextEditingController,
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
                    // height: 110,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Courses in the College", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        for(var cou in collegeCourseList) ActionChip(
                          label: Text("$cou"), 
                          avatar: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              collegeCourseList.remove(cou);
                            });
                          }
                        ),
                        Wrap(
                          alignment: WrapAlignment.end,
                          children: [
                            TextFormField(
                              controller: collegeCourseTextEditingController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(6.0),
                                hintText: 'Enter name of the Course',
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 14),
                              child: ElevatedButton.icon(
                                icon: Icon(Icons.add),
                                label: Text("Add"),
                                onPressed: () {
                                  if (collegeCourseTextEditingController.text.isNotEmpty) {
                                    setState(() {
                                      collegeCourseList.add(collegeCourseTextEditingController.text);
                                      collegeCourseTextEditingController.text = '';
                                    });
                                  } else {
                                    final snackBar = SnackBar(
                                      backgroundColor: Color(0xFF464646),
                                      duration: Duration(seconds: 1),
                                      behavior: SnackBarBehavior.floating,
                                      content: Text('Cannot add empty course'),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                },
                              ),
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
                        Text("Address of the College", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        TextFormField(
                          controller: collegeAddressTextEditingController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(6.0),
                            hintText: 'Address',
                          ),
                        ),
                      ],
                    ),
                  )
                ),

                ]
              ) 
            : widget.categoryName == 'University' ? 
              Column(
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
                          Text("Name of the University", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                          TextFormField(
                            controller: universityNameTextEditingController,
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
                          Text("Description of the University", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                          for(var desc in universityDescriptionList) ActionChip(
                            label: Text("$desc"), 
                            avatar: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                universityDescriptionList.remove(desc);
                              });
                            }
                          ),
                          Wrap(
                            alignment: WrapAlignment.end,
                            children: [
                              TextFormField(
                                controller: universityDescriptionTextEditingController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(6.0),
                                  hintText: 'Description',
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 14),
                                child: ElevatedButton.icon(
                                  icon: Icon(Icons.add),
                                  label: Text("Add"),
                                  onPressed: () {
                                    if (universityDescriptionTextEditingController.text.isNotEmpty) {
                                      setState(() {
                                        universityDescriptionList.add(universityDescriptionTextEditingController.text);
                                        universityDescriptionTextEditingController.text = '';
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
                                ),
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
                          Text("Contact number of the University", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                          TextFormField(
                            controller: universityContactTextEditingController,
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
                    // height: 110,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Branches in the University", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        for(var branch in universityBranchList) ActionChip(
                          label: Text("$branch"), 
                          avatar: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              universityBranchList.remove(branch);
                            });
                          }
                        ),
                        Wrap(
                          alignment: WrapAlignment.end,
                          children: [
                            TextFormField(
                              controller: universityBranchTextEditingController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(6.0),
                                hintText: 'Enter name of the branch',
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 14),
                              child: ElevatedButton.icon(
                                icon: Icon(Icons.add),
                                label: Text("Add"),
                                onPressed: () {
                                  if (universityBranchTextEditingController.text.isNotEmpty) {
                                    setState(() {
                                      universityBranchList.add(universityBranchTextEditingController.text);
                                      universityBranchTextEditingController.text = '';
                                    });
                                  } else {
                                    final snackBar = SnackBar(
                                      backgroundColor: Color(0xFF464646),
                                      duration: Duration(seconds: 1),
                                      behavior: SnackBarBehavior.floating,
                                      content: Text('Cannot add empty course'),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                },
                              ),
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
                        Text("Address of the University", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        TextFormField(
                          controller: universityAddressTextEditingController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(6.0),
                            hintText: 'Address',
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ]
            ) :
            widget.categoryName == 'Job' ?
            Column(
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
                        Text("Name of the Job", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        TextFormField(
                          controller: jobNameTextEditingController,
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
                    height: 110,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Type of the Job", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        TextFormField(
                          controller: jobTypeTextEditingController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(6.0),
                            hintText: 'Job type',
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
                        Text("Description of the Job", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        for(var desc in jobDescriptionList) ActionChip(
                          label: Text("$desc"), 
                          avatar: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              jobDescriptionList.remove(desc);
                            });
                          }
                        ),
                        Wrap(
                          alignment: WrapAlignment.end,
                          children: [
                            TextFormField(
                              controller: jobDescriptionTextEditingController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(6.0),
                                hintText: 'Description',
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 14),
                              child: ElevatedButton.icon(
                                icon: Icon(Icons.add),
                                label: Text("Add"),
                                onPressed: () {
                                  if (jobDescriptionTextEditingController.text.isNotEmpty) {
                                    setState(() {
                                      jobDescriptionList.add(jobDescriptionTextEditingController.text);
                                      jobDescriptionTextEditingController.text = '';
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
                              ),
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
                        Text("Minimum Salary", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        TextFormField(
                          controller: jobMinSalaryTextEditingController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(6.0),
                            hintText: 'Salary',
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
                        Text("Enter the Job Designation", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        TextFormField(
                          controller: jobDesignationTextEditingController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(6.0),
                            hintText: 'Designation',
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
                        Text("Required Qualifications for the job", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        TextFormField(
                          controller: jobQualificationsTextEditingController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(6.0),
                            hintText: 'Experience',
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
                        Text("Requirements for the Job", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        for(var req in jobRequirementsList) ActionChip(
                          label: Text("$req"), 
                          avatar: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              jobRequirementsList.remove(req);
                            });
                          }
                        ),
                        Wrap(
                          alignment: WrapAlignment.end,
                          children: [
                            TextFormField(
                              controller: jobRequirementsTextEditingController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(6.0),
                                hintText: 'Requirements',
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 14),
                              child: ElevatedButton.icon(
                                icon: Icon(Icons.add),
                                label: Text("Add"),
                                onPressed: () {
                                  if (jobRequirementsTextEditingController.text.isNotEmpty) {
                                    setState(() {
                                      jobRequirementsList.add(jobRequirementsTextEditingController.text);
                                      jobRequirementsTextEditingController.text = '';
                                    });
                                  } else {
                                    final snackBar = SnackBar(
                                      backgroundColor: Color(0xFF464646),
                                      duration: Duration(seconds: 1),
                                      behavior: SnackBarBehavior.floating,
                                      content: Text('Cannot add empty text'),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                },
                              ),
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
                        Text("Enter the Last date to apply", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        TextFormField(
                          controller: jobLastDateTextEditingController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(6.0),
                            hintText: 'Last date',
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
                        Text("Enter the Start date to apply", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        TextFormField(
                          controller: jobStartDateTextEditingController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(6.0),
                            hintText: 'Start date',
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
                        Text("Benefits for the Job", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        for(var ben in jobBenefitsList) ActionChip(
                          label: Text("$ben"), 
                          avatar: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              jobBenefitsList.remove(ben);
                            });
                          }
                        ),
                        Wrap(
                          alignment: WrapAlignment.end,
                          children: [
                            TextFormField(
                              controller: jobBenefitsTextEditingController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(6.0),
                                hintText: 'Benefits',
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 14),
                              child: ElevatedButton.icon(
                                icon: Icon(Icons.add),
                                label: Text("Add"),
                                onPressed: () {
                                  if (jobBenefitsTextEditingController.text.isNotEmpty) {
                                    setState(() {
                                      jobBenefitsList.add(jobBenefitsTextEditingController.text);
                                      jobBenefitsTextEditingController.text = '';
                                    });
                                  } else {
                                    final snackBar = SnackBar(
                                      backgroundColor: Color(0xFF464646),
                                      duration: Duration(seconds: 1),
                                      behavior: SnackBarBehavior.floating,
                                      content: Text('Cannot add empty text'),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                },
                              ),
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
                    // height: 110,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Eligibility for the Job", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        for(var eli in jobEligibilityList) ActionChip(
                          label: Text("$eli"), 
                          avatar: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              jobEligibilityList.remove(eli);
                            });
                          }
                        ),
                        Wrap(
                          alignment: WrapAlignment.end,
                          children: [
                            TextFormField(
                              controller: jobEligibilityTextEditingController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(6.0),
                                hintText: 'Benefits',
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 14),
                              child: ElevatedButton.icon(
                                icon: Icon(Icons.add),
                                label: Text("Add"),
                                onPressed: () {
                                  if (jobEligibilityTextEditingController.text.isNotEmpty) {
                                    setState(() {
                                      jobEligibilityList.add(jobEligibilityTextEditingController.text);
                                      jobEligibilityTextEditingController.text = '';
                                    });
                                  } else {
                                    final snackBar = SnackBar(
                                      backgroundColor: Color(0xFF464646),
                                      duration: Duration(seconds: 1),
                                      behavior: SnackBarBehavior.floating,
                                      content: Text('Cannot add empty text'),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ),
              ],
            ) : Center(
              child: Text("No Data"),
            ),
          ),
        ),
      ),
      floatingActionButton: Mutation(
        options: MutationOptions(
          document: widget.categoryName == 'School' ? gql(addSchoolMutation) : widget.categoryName == 'College' ? gql(addCollegeMutation) : widget.categoryName == 'University' ? gql(addUniversityMutation) : widget.categoryName == 'Job' ? gql(addJobMutation) : null,
          onCompleted: (dynamic result) {
            print(result);
            final snackBar = SnackBar(
              backgroundColor: Color(0xFF464646),
              duration: Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
              content: Text('Successfully added new ${widget.categoryName}'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pop(context);
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
              if (schoolNameTextEditingController.text.isNotEmpty && schoolDescriptionList.isNotEmpty && schoolContactTextEditingController.text.isNotEmpty && schoolAddressTextEditingController.text.isNotEmpty && schoolStandardList.isNotEmpty && schoolBoardTextEditingController.text.isNotEmpty) {
                runMutation({
                  'name': schoolNameTextEditingController.text,
                  'description': schoolDescriptionList,
                  'contactInfo': schoolContactTextEditingController.text,
                  'address': schoolAddressTextEditingController.text,
                  'standard': schoolStandardList,
                  'board': schoolBoardTextEditingController.text,
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
            } else if (widget.categoryName == 'College') {
              if (collegeNameTextEditingController.text.isNotEmpty && collegeDescriptionList.isNotEmpty && collegeContactTextEditingController.text.isNotEmpty && collegeCourseList.isNotEmpty && collegeAddressTextEditingController.text.isNotEmpty) {
                runMutation({
                  'name': collegeNameTextEditingController.text,
                  'description': collegeDescriptionList,
                  'contactInfo': collegeContactTextEditingController.text,
                  'address': collegeAddressTextEditingController.text,
                  'course': collegeCourseList,
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
            } else if (widget.categoryName == 'University') {
              if (universityNameTextEditingController.text.isNotEmpty && universityDescriptionList.isNotEmpty && universityContactTextEditingController.text.isNotEmpty && universityBranchList.isNotEmpty && universityAddressTextEditingController.text.isNotEmpty) {
                runMutation({
                  'name': universityNameTextEditingController.text,
                  'description': universityDescriptionList,
                  'contactInfo': universityContactTextEditingController.text,
                  'address': universityAddressTextEditingController.text,
                  'branch': universityBranchList,
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
            } else if (widget.categoryName == 'Job') {
              if (jobNameTextEditingController.text.isNotEmpty && jobTypeTextEditingController.text.isNotEmpty && jobDescriptionList.isNotEmpty && jobMinSalaryTextEditingController.text.isNotEmpty && jobDesignationTextEditingController.text.isNotEmpty && jobQualificationsTextEditingController.text.isNotEmpty && jobRequirementsList.isNotEmpty && jobLastDateTextEditingController.text.isNotEmpty && jobStartDateTextEditingController.text.isNotEmpty) {
                runMutation({
                  'name': jobNameTextEditingController.text,
                  'jobType': jobTypeTextEditingController.text,
                  'description': jobDescriptionList,
                  'minSalary': jobMinSalaryTextEditingController.text,
                  'designation': jobDesignationTextEditingController.text,
                  'qualifications': jobQualificationsTextEditingController.text,
                  'requirements': jobRequirementsList,
                  'lastDate': jobLastDateTextEditingController.text,
                  'startDate': jobStartDateTextEditingController.text,
                  'benefits': jobBenefitsList,
                  'eligibility': jobEligibilityList,
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