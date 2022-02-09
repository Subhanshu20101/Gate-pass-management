// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/routes.dart';
import 'package:flutter_application_1/Pages/submitted_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('students').snapshots();

  String name = "";
  bool changeButton = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  validator(context) {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      moveToHome(context);
    } else {
      print("Not valid");
    }
  }

  var username = "";
  var password = "";

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  Future<void> addUser() {
    return students
    .doc(username)
        .set({
          'username': username, 
          'password': password,
          'name': "",
          'enrollNo': "",
          'timeOut': "",
          'parentsPhone': "",
          'personalPhone': "",
          'status': "",
          'timeIn':""
          })
        .then((value) => print("User added"))
        .catchError((error) => print('Failed to Add user'));
  }

 

  moveToHome(BuildContext context) async {
    setState(() {
      changeButton = true;
    });
    await Future.delayed(Duration(seconds: 1));
    await Navigator.pushNamed(context, MyRoutes.loginRoute);
    setState(() {
      changeButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  "assests/images/undraw_Mobile_login_re_9ntv.png",
                  fit: BoxFit.cover,
                  height: 300,
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Register",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter User Name",
                          labelText: "Username",
                        ),
                        controller: usernameController,
                        onChanged: (value) {
                          name = value;
                          setState(() {});
                        },
                        validator: (String? value) {
                          if (value == null || value.trim().length == 0) {
                            return "Usename cannot be empty";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.trim().length == 0) {
                            return "password cannot be empty";
                          } else if (value.length < 6) {
                            return "password length should be atleat 6";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Enter Password",
                          labelText: "Password",
                        ),
                        controller: passwordController,
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Material(
                        color: Colors.deepPurple,
                        borderRadius:
                            BorderRadius.circular(changeButton ? 50 : 8),
                        child: InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              username = usernameController.text;
                              password = passwordController.text;
                            }
                            addUser();
                            validator(context);
                          },
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            width: changeButton ? 50 : 150,
                            height: 40,
                            alignment: Alignment.center,
                            child: changeButton
                                ? Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Register",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Material(
                          child: Image.asset(
                        'assests/images/120res.png',
                        height: 50,
                        width: 50,
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
