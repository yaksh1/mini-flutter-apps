import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.buttonText, required this.onPressed});
  final String buttonText;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(15.h),
      onPressed: onPressed,
      color: Colors.blue[200],
      shape:
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      minWidth: double.infinity,
      // 
      child: Text(
        buttonText,style: TextStyle(
          color:Colors.white,
          fontSize: 18.sp),),
    );
  }
}
