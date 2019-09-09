import 'package:sqflite/sqflite.dart';
import 'package:todoey_flutter/models/todo.dart';
import 'package:path/path.dart';

final String tableTodo = 'tasks';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnDone = 'done';

class TodoProvider {
  Database _db;

  Future _open({String name = 'tasks.db'}) async {
    if (_db == null || !_db.isOpen) {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, name);
      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
          create table $tableTodo ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
          $columnDone integer not null)
        ''');
        },
      );
    }
  }

  Future<List<Todo>> getTasks() async {
    await _open();
    List<Map<String, dynamic>> savedTasks = await _db.query(tableTodo);
    List<Todo> tasks = [];
    if (savedTasks.length > 0) {
      for (var taskSaved in savedTasks) {
        Todo task = Todo.fromMap(taskSaved);
        tasks.add(task);
      }
    }
    await close();
    return tasks;
  }

  // task id is provided by db.insert method
  Future<int> insert(Todo task) async {
    await _open();
    task.id = await _db.insert(tableTodo, task.toMap());
    await close();
    return task.id;
  }

  Future<int> update(Todo task) async {
    await _open();
    int result = await _db.update(tableTodo, task.toMap(),
        where: '$columnId = ?', whereArgs: [task.id]);
    await close();
    return result;
  }

  Future<int> delete(int id) async {
    await _open();
    int result =
        await _db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
    await close();
    return result;
  }

  Future close() async => _db.close();

  Future<Todo> getSingleTask(int id) async {
    List<Map> maps = await _db.query(tableTodo,
        columns: [columnId, columnDone, columnTitle],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Todo.fromMap(maps.first);
    }
    return null;
  }
}
