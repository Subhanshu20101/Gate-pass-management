import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/submitted_page.dart';
import 'package:flutter_application_1/utils/routes.dart';

class FormPage extends StatefulWidget {
  final String id;

  FormPage({Key? key,required this.id}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  var name = "";
  var enrollNo = "";
  var timeOut = "";
  var parentsPhone = "";
  var personalPhone = "";
  

  final nameController = TextEditingController();
  final enrollNoController = TextEditingController();
  final timeOutController = TextEditingController();
  final parentsPhoneController = TextEditingController();
  final personalPhoneController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    enrollNoController.dispose();
    timeOutController.dispose();
    parentsPhoneController.dispose();
    personalPhoneController.dispose();
    super.dispose();
  }

  clearText() {
    nameController.clear();
    enrollNoController.clear();
    timeOutController.clear();
    parentsPhoneController.clear();
    personalPhoneController.clear();
  }

  // Adding Data
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  Future<void> updateUser() {
    String status= "out";
    return students
        .doc(widget.id)
        .update({
          'name': name,
          'enrollNo': enrollNo,
          'timeOut': timeOut,
          'parentsPhone': parentsPhone,
          'personalPhone': personalPhone,
          'status': status
        },
        
        )
        .then((value) => print('User updated added'))
        .catchError((error) => print('Failed to Add user'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add your data"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Name: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Enrollment Number ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: enrollNoController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Enrollment Number';
                    } else if (value.length != 9) {
                      return 'Please Enter Valid Enrollment Number';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Time-Out ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: timeOutController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Time-Out';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Parents Phone Number ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: parentsPhoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Parents Phone Nubmer';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Personal Phone Number',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: personalPhoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Personal Phone Number';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            name = nameController.text;
                            enrollNo = enrollNoController.text;
                            timeOut = timeOutController.text;
                            parentsPhone = parentsPhoneController.text;
                            personalPhone = personalPhoneController.text;
                            updateUser();
                            clearText();
                          });
                        }
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => {clearText()},
                      child: Text(
                        'Clear Data',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
