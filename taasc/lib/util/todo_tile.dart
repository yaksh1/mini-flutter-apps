import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToDoTile extends StatelessWidget {
  ToDoTile({super.key, required this.taskName, required this.taskComplete,required this.onChanged});

  final String taskName;
  final bool taskComplete;
  Function(bool?)? onChanged;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.h),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            )
          ],
        ),
        child: Row(
          children: [
            //! checkbox
            Checkbox(value: taskComplete, onChanged: onChanged),
            //! task name
            Text(taskName),
          ],
        ),
      ),
    );
  }
}
