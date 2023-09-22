import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.white,
      elevation: 4,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(16.h)
      ),
      child:Text(text));
  }
}
