import 'package:flutter/material.dart';
import 'package:todoey_flutter/screens/todoo_screen.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/todo_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoManager>(
      builder: (context) => TodoManager(),
      child: MaterialApp(
        home: TasksScreen(),
      ),
    );
  }
}
