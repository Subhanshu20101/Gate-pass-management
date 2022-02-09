import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/form_page.dart';
import 'package:flutter_application_1/Pages/login_page.dart';
import 'package:flutter_application_1/Pages/ask_page.dart';
import 'package:flutter_application_1/Pages/submitted_page.dart';
import 'package:flutter_application_1/Pages/register.dart';
import 'package:flutter_application_1/Pages/not.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/utils/routes.dart';

import 'Pages/login_page_admin.dart';

Future main(List<String> args) async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            themeMode: ThemeMode.light,
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
              fontFamily: GoogleFonts.lato().fontFamily,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: MyRoutes.askRoute,
            routes: {
              "/": (context) => AskPage(),
              MyRoutes.formRoute: (context) => FormPage(id: '',),
              MyRoutes.loginRoute: (context) => LoginPage(),
              MyRoutes.askRoute: (context) => AskPage(),
              MyRoutes.submittedRoute: (context) => const SubmittedPage(),
              MyRoutes.registerRoute: (context) => const RegisterPage(),
              MyRoutes.notRoute: (context) => const NotPage(),
              MyRoutes.loginadminRoute: (context) => const LoginAdminPage(),
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
