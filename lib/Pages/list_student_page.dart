import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_fbfirestore_crud/pages/update_student_page.dart';

class ListStudentPage extends StatefulWidget {
  ListStudentPage({Key? key}) : super(key: key);

  @override
  _ListStudentPageState createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('students').snapshots();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final timeInController = TextEditingController();
  var timeIn = "";

  Future<void> updateTime(id) {
    return students
        .doc(id)
        .set(
          {
            'timeIn': timeIn,
          },
          SetOptions(merge: true),
        )
        .then((value) => print('User updated added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  Future<void> updateStatus(id) {
    return students
        .doc(id)
        .update(
          {
            'status': "in",
          },
        )
        .then((value) => print('User updated added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }
  Future<void> updateUser(id) {
    return students
        .doc(id)
        .update(
          {
            'name': "",
            'enrollNo': "",
            'timeOut': "",
            'parentsPhone': "",
            'personalPhone': "",
            'status': ""
          },
        )
        .then((value) => print('User updated'))
        .catchError((error) => print('Failed to update'));
  }

  CollectionReference old_data =
      FirebaseFirestore.instance.collection('old_data');
  Future<void> movingData(
      username, name, enrollNo, timeOut, parentsPhone, personalPhone) {
    return old_data
        .doc(username)
        .set({
          'username': username,
          'name': name,
          'enrollNo': enrollNo,
          'timeOut': timeOut,
          'parentsPhone': parentsPhone,
          'personalPhone': personalPhone,
          'timeIn': timeIn,
          'status': "in"
        })
        .then((value) => print("Data moved"))
        .catchError((error) => print("Data not moved"));
  }

  // For Deleting User
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return students
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  1: FixedColumnWidth(140),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          child: Center(
                            child: Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          child: Center(
                            child: Text(
                              'Enrollment No',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          child: Center(
                            child: Text(
                              'Time-Out',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          child: Center(
                            child: Text(
                              'Parents Phone No',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          child: Center(
                            child: Text(
                              'Personal Phone No',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          child: Center(
                            child: Text(
                              'Action',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (var i = 0; i < storedocs.length; i++) ...[
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                              child: Text(storedocs[i]['name'],
                                  style: TextStyle(fontSize: 18.0))),
                        ),
                        TableCell(
                          child: Center(
                              child: Text(storedocs[i]['timeOut'],
                                  style: TextStyle(fontSize: 18.0))),
                        ),
                        TableCell(
                            child: Form(
                                key: _formKey,
                                child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "In time",
                                      labelText: "In time",
                                      errorStyle: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 15),
                                    ),
                                    controller: timeInController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty)
                                        return "Please enter time in.";
                                      return null;
                                    }))),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () => {
                                  if (_formKey.currentState!.validate())
                                    {
                                      setState(() {
                                        timeIn = timeInController.text;
                                        updateTime(storedocs[i]['id']);
                                        updateStatus(storedocs[i]['id']);
                                        movingData(
                                            storedocs[i]['username'],
                                            storedocs[i]['name'],
                                            storedocs[i]['enrollNo'],
                                            storedocs[i]['timeOut'],
                                            storedocs[i]['parentsPhone'],
                                            storedocs[i]['personalPhone']);
                                        updateUser(storedocs[i]['id']);
                                      })
                                    }
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.orange,
                                ),
                              ),
                              IconButton(
                                onPressed: () =>
                                    {deleteUser(storedocs[i]['id'])},
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        });
  }
}
