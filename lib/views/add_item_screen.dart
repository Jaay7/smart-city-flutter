import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smart_city_flutter/widgets/widget.dart';

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
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new ${widget.categoryName}'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: EdgeInsets.all(8.0),
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
              ],
            ),
          ),
        ),
      )
    );
  }
}