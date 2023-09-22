import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taasc/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //! list
  List toDoList = [
    ["Make app", false],
    ["Exercise", false],
  ];

  //! check box tapped
  void _checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 50,),
              Text(
                "To Dos:",
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: toDoList.length,
                itemBuilder: (context, index) {
                  return ToDoTile(
                      taskName: toDoList[index][0],
                      taskComplete: toDoList[index][1],
                      onChanged: (value) => _checkBoxChanged(value, index));
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
