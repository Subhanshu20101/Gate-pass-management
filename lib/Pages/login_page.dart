// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/form_page.dart';
import 'package:flutter_application_1/utils/routes.dart';
import 'package:flutter_application_1/Pages/submitted_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  moveToHome(BuildContext context) async {
    setState(() {
      changeButton = true;
    });
    await Future.delayed(Duration(seconds: 1));
    await Navigator.pushNamed(context, MyRoutes.formRoute);
    setState(() {
      changeButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            a['id'] = document.id;
            storedocs.add(a);
          }).toList();

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
                        "Welcome $name",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
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
                                if (value == null ||
                                    value.trim().length == 0) {}
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
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    username = usernameController.text;
                                    password = passwordController.text;
                                  }
                                  bool b = false;
                                  var i;
                                  for (i = 0; i < storedocs.length; i++) {
                                    if (storedocs[i]['username'] == username &&
                                        storedocs[i]['password'] == password) {
                                      b = true;
                                      break;
                                    }
                                  }
                                  if (b == true) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder:(context) =>
                                      FormPage(id: storedocs[i]['id']),
                                      )
                                    );
                                  } else {
                                    Navigator.pushNamed(
                                        context, MyRoutes.notRoute);
                                  }
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
                                          "Login",
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
                              color: Colors.deepPurple,
                              borderRadius:
                                  BorderRadius.circular(changeButton ? 50 : 8),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, MyRoutes.registerRoute);
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
        });
  }
}

class UpdateFormPage {}
