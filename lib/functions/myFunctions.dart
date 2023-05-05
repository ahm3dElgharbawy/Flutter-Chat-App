import 'package:flutter/material.dart';

class MyFunctions {
  static String authExceptions(String code) {
    switch (code) {
      case 'user-not-found':
        return "User not found";
      case 'wrong-password':
        return "Wrong password";
      case 'network-request-failed':
        return "check internet connection";
      case 'email-already-in-use':
        return "email already exist";
      default:
        return 'oops error occurred';
    }
  }

  static String? validate(String input, {String? type}) {
    if (type == "email") {
      bool validEmail = RegExp(r'\S+@\S+\.\S+').hasMatch(input);
      if (!validEmail) {
        return "Not valid email";
      }
    }
    if (type == "password") {
      if (input.length < 8) {
        return "password length should be greater than or equal 8";
      }
    }
    return null;
  }

  static showSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ),
    );
  }
}
