import 'package:flutter/foundation.dart';
import 'package:todoey_flutter/models/todo.dart';
import 'dart:collection';

// Change listener
class TodoManager extends ChangeNotifier {
  List<Todo> _tasks = [];

  UnmodifiableListView<Todo> get tasks {
    return UnmodifiableListView(_tasks);
  }

  void addSavedTasks(List<Todo> savedTasks) {
    _tasks = savedTasks;
    notifyListeners();
  }

  void addTask({String title, int id}) {
    _tasks.add(Todo(name: title, id: id));
    notifyListeners();
  }

  void removeTask(Todo task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void updateToggleDone(Todo task) {
    task.isDone = !task.isDone;
    notifyListeners();
  }

  int get taskCount {
    return _tasks.length;
  }

  int activeTasks = 0;

  void countActiveTasks(int activeTasksSaved) {
    activeTasks = activeTasksSaved;
    notifyListeners();
  }

  void updateActiveTasks({bool checkBoxState}) {
    activeTasks = checkBoxState ? activeTasks - 1 : activeTasks + 1;
    notifyListeners();
  }
}
