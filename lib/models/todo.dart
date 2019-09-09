final String tableTodo = 'tasks';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnDone = 'done';

// Todoo model
class Todo {
  int id;
  String name;
  bool isDone;

  Todo({this.id, this.name, this.isDone = false});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: name,
      columnDone: isDone == true ? 1 : 0
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Todo.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnTitle];
    isDone = (map[columnDone] == 1) ? true : false;
  }
}
