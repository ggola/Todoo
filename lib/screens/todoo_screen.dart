import 'package:flutter/material.dart';
import 'package:todoey_flutter/widgets/todoo_list.dart';
import 'package:todoey_flutter/screens/add_todo_screen.dart';
import 'package:todoey_flutter/models/todo.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/todo_provider.dart';
import 'package:todoey_flutter/models/todo_manager.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  Future retrieveTasks() async {
    List<Todo> savedTasks = await TodoProvider().getTasks();
    Provider.of<TodoManager>(context).addSavedTasks(savedTasks);
    int activeTasksSaved =
        (savedTasks.where((task) => (task.isDone == false)).toList()).length;
    Provider.of<TodoManager>(context).countActiveTasks(activeTasksSaved);
  }

  @override
  void initState() {
    super.initState();
    retrieveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoManager>(builder: (context, taskData, child) {
      return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            // Slide up a container to add a new task
            showModalBottomSheet(
              context: context,
              builder: (context) => AddTaskScreen(),
            );
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30.0,
                    child: Icon(
                      Icons.list,
                      color: Colors.lightBlueAccent,
                      size: 30.0,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Todoo',
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    (taskData.activeTasks == 0)
                        ? 'Yay! You are all set'
                        : (taskData.activeTasks == 1)
                            ? 'You have 1 thing to do'
                            : 'You have ${taskData.activeTasks} things to do',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                    top: 0, left: 20.0, right: 20.0, bottom: 110.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: TasksList(),
              ),
            ),
          ],
        ),
      );
    });
  }
}
