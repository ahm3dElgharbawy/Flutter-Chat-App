import 'package:chatapp/constants/appColors.dart';
import 'package:chatapp/constants/appRoutes.dart';
import 'package:chatapp/functions/myFunctions.dart';
import 'package:chatapp/view/screens/home.dart';
import 'package:chatapp/view/widgets/customAuthButton.dart';
import 'package:chatapp/view/widgets/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String? errorEmail;
  String? errorPassword;
  

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          "Log In",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: ModalProgressHUD(
        color: Colors.white,
        inAsyncCall: isLoading,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                SizedBox(
                  height: 40,
                ),
                Image.asset(
                  "assets/logo.png",
                  height: 200,
                ),
                SizedBox(
                  height: 40,
                ),
                CustomTextField(
                  controller: _emailController,
                  onChanged: (val) {
                    setState(() {
                      errorEmail = MyFunctions.validate(val, type: "email");
                    });
                  },
                  keyboardType: TextInputType.emailAddress,
                  errorText: errorEmail,
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: _passwordController,
                  onChanged: (val) {
                    setState(() {
                      errorPassword = MyFunctions.validate(val, type: "password");
                    });
                  },
                
                  errorText: errorPassword,
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  obsecureText: true,
                ),
                SizedBox(height: 20),
                CustomAuthButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    if (errorEmail == null && errorPassword == null && _emailController.text!="" && _passwordController!="") {
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text);
                        if (user != null) {
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.home);
                        }
                      } on FirebaseAuthException catch (e) {
                        String error = MyFunctions.authExceptions(e.code);
                        MyFunctions.showSnackBar(context,error);
                      }
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                  title: "login",
                  color: AppColors.blue,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.signup);
                      },
                      child: Text("sign up"),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
