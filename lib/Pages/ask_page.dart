// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/routes.dart';

class AskPage extends StatefulWidget {
  const AskPage({Key? key}) : super(key: key);

  @override
  State<AskPage> createState() => _AskPageState();
}

class _AskPageState extends State<AskPage> {
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
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  "assests/images/undraw_welcome_cats_thqn.png",
                  fit: BoxFit.cover,
                  height: 300,
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  " Welcome Are You",
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
                      Material(
                        color: Colors.deepPurple,
                        borderRadius:
                            BorderRadius.circular(changeButton ? 50 : 8),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, MyRoutes.loginRoute);
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
                                    "Student",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                      " OR",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                    Material(
                        color: Colors.deepPurple,
                        borderRadius:
                            BorderRadius.circular(changeButton ? 50 : 8),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, MyRoutes.loginRoute);
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
                                    "Admin",
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
                        child: Image.asset('assests/images/120res.png' , height: 70, width: 70,)
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
