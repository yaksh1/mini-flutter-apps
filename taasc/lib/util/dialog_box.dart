import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taasc/util/m_button.dart';

class DialogBox extends StatelessWidget {
  DialogBox({super.key, required this.controller, required this.onSave, required this.onCancel});

  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        padding: EdgeInsets.only(top: 10.h),
        height: 80.h,
        width: 300.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //! user input
            TextField(    
                controller: controller,
                decoration: 
                InputDecoration(
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r)
                    ), 
                    hintText: "Add a new task"),
              ),
          ],
        ),
      ),
      actions: [
        //! save button
        MyButton(text: "save", onPressed: onSave),
        SizedBox(
          width: 10.h,
        ),
        //! cancel button
        MyButton(text: "cancel", onPressed: onCancel),
      ],
    );
  }
}
