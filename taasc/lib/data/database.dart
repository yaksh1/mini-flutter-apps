import 'package:hive/hive.dart';

class ToDoDatabase {
  //! initial list
  List toDoList = [];
  //ref the box
  final _myBox = Hive.box('mybox');

  //! first time opening of app
  void createInitialData() {
    toDoList = [
      ["Demo Task", true],
      ["Demo Task2", false],
    ];
  }

  //! load the data from database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  //! upda te the database
  void updateDatabase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
