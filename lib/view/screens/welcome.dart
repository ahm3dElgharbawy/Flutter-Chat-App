import 'package:chatapp/constants/appRoutes.dart';
import 'package:chatapp/main.dart';
import 'package:chatapp/view/widgets/customAuthButton.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    prefs?.setBool("firstTime",true);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Get Started",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: 20),
          Text(
            "Start with signing up or sign in.",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 50),
          Image.asset(
            "assets/welcome.png",
            height: 300,
          ),
          SizedBox(height: 50),
          CustomAuthButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.signup);
              }, title: "Sign up", color: Color(0xff136EF1)),
          CustomAuthButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.login);
              }, title: "Sign in", color: Color(0xfffea832)),
        ]),
      ),
    );
  }
}
