import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/todo.dart';
import 'package:todoey_flutter/models/todo_provider.dart';
import 'package:todoey_flutter/models/todo_manager.dart';

TodoProvider todoProvider = TodoProvider();

class AddTaskScreen extends StatelessWidget {
  void addTask(TodoManager taskData, String newTask) async {
    int taskId = await todoProvider.insert(Todo(name: newTask));
    taskData.addTask(title: newTask, id: taskId);
    taskData.updateActiveTasks(checkBoxState: false);
  }

  @override
  Widget build(BuildContext context) {
    String newTask;
    return Consumer<TodoManager>(
      builder: (context, taskData, child) {
        return Container(
          color: Color(0xFF757575),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Add todoo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Theme(
                  data: ThemeData(
                    primaryColor: Colors.lightBlueAccent,
                    accentColor: Colors.lightBlueAccent,
                    hintColor: Colors.lightBlueAccent,
                  ),
                  child: TextField(
                    onSubmitted: (value) async {
                      newTask = value;
                      addTask(taskData, newTask);
                      Navigator.pop(context);
                    },
                    onChanged: (value) {
                      newTask = value;
                    },
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 1.5),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 2.5),
                      ),
                    ),
                    autofocus: true,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ButtonTheme(
                  height: 40.0,
                  child: FlatButton(
                    onPressed: () async {
                      addTask(taskData, newTask);
                      Navigator.pop(context);
                    },
                    color: Colors.lightBlueAccent,
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
