import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:taasc/data/database.dart';
import 'package:taasc/util/dialog_box.dart';
import 'package:taasc/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var log = Logger();
  //! ref the box
  final _myBox = Hive.box('mybox');
  // //! list
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // if first time opening => create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists some data
      db.loadData();
    }
    super.initState();
  }

  // List toDoList = [
  //   ["Make app", false],
  //   ["Exercise", false],
  // ];

  //! check box tapped
  void _checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();

  }

  //! dialog controller
  final _controller = TextEditingController();

  //! save new task
  void _saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    db.updateDatabase();
    Navigator.pop(context);
  }

  //! create new task
  void _createNewTask() async {
    await showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onCancel: () => Navigator.of(context).pop(),
            onSave: _saveNewTask,
          );
        });
  }

  //! delete task
  void _deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
      ),
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewTask,
        backgroundColor: Colors.blueGrey[300],
        child: const Icon(PhosphorIcons.plus_bold),
      ),
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
                Text("hereeee"),
                SizedBox(
                  height: 10.h,
                ),

                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: db.toDoList.length,
                  itemBuilder: (context, index) {
                    return ToDoTile(
                      taskName: db.toDoList[index][0],
                      taskComplete: db.toDoList[index][1],
                      onChanged: (value) => _checkBoxChanged(value, index),
                      onDelete: (context) => _deleteTask(index),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
