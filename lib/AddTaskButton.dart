import "package:flutter/material.dart";
import "AddTaskPage.dart";
import "Task.dart";

class AddTaskButton extends StatelessWidget{
  List<Task> tasks;

  AddTaskButton({this.tasks});

  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddTaskPage(tasks: tasks)),
        );
      },
    );
  }
}