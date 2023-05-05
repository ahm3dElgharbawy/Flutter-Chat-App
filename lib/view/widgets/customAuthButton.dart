import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  final String title;
  final Color color;
  final void Function()? onPressed;
  CustomAuthButton({required this.onPressed,required this.title,required this.color});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        clipBehavior: Clip.antiAlias,
        color: color,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(title,style: TextStyle(color: Colors.white),),
          minWidth: 200,
        ),
      ),
    );
  }
}
