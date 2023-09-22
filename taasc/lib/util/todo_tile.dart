import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  ToDoTile(
      {super.key,
      required this.taskName,
      required this.taskComplete,
      required this.onChanged,
      required this.onDelete,});

  final String taskName;
  final bool taskComplete;
  Function(bool?)? onChanged;
  final Function(BuildContext)? onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Slidable(
      endActionPane: ActionPane(
        extentRatio:0.25 ,
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: onDelete,
            icon: PhosphorIcons.trash,
            backgroundColor: Colors.red.shade300,
            borderRadius: BorderRadius.circular(12.h),
          ),
        ],
      ),
      child: Padding(
        padding:  EdgeInsets.only(right:8.0.w),
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
                Checkbox(
                  value: taskComplete,
                  onChanged: onChanged,
                  activeColor: Colors.blueGrey,
                ),
                //! task name
                Text(taskName,
                    style: taskComplete
                        ? TextStyle(decoration: TextDecoration.lineThrough)
                        : TextStyle()),
              ],
            ),
          ),
      ),
      ),
    );
  }
}
