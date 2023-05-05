import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final Function(String)? onChanged;
  final String hintText;
  final Icon prefixIcon;
  final TextInputType? keyboardType;
  final bool ?obsecureText ;
  const CustomTextField({
    super.key,
    required this.onChanged,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.errorText,
    this.keyboardType,
    this.obsecureText
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecureText??false,
      keyboardType: keyboardType == null ? TextInputType.text : keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
          errorText: errorText,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          hintText: hintText),
    );
  }
}
