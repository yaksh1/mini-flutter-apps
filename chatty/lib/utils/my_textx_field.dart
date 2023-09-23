import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key, required this.autocorrect, required this.obscureText, required this.suggestions, required this.controller, required this.labelText, required this.hintText});

  final bool autocorrect;
  final bool obscureText;
  final bool suggestions;
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: autocorrect,
      obscureText: obscureText,
      enableSuggestions: suggestions,
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        label: Text(labelText),
        hintText: hintText,
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(
              color: Colors.black,
            )),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
