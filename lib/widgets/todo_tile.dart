import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String taskTitle;
  final bool isChecked;
  final Function onLongPressed;
  final Function onChanged;
  TaskTile(
      {this.taskTitle, this.isChecked, this.onLongPressed, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: onLongPressed,
      title: Text(
        taskTitle,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        checkColor: Colors.white,
        value: isChecked,
        onChanged: onChanged,
      ),
    );
  }
}
