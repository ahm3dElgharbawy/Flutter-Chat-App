import 'package:chatapp/constants/appRoutes.dart';
import 'package:chatapp/view/screens/auth/signUp.dart';
import 'package:chatapp/view/screens/home.dart';
import 'package:chatapp/view/screens/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'view/screens/auth/login.dart';
SharedPreferences ?prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _auth = FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
      ),
      initialRoute: prefs?.getBool("firstTime")==null?"welcome":_auth.currentUser!= null ?"home":"login",
      routes: {
        AppRoutes.login: (context) => Login(),
        AppRoutes.signup: (context) => SignUp(),
        AppRoutes.home: (context) => Home(),
        AppRoutes.welcome: (context)=>Welcome()
      },
    );
  }
}
