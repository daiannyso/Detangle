import "package:flutter/material.dart";
import "Task.dart";

class NotFinishedTasks extends StatelessWidget {
  final List<Task> tasks;

  NotFinishedTasks({this.tasks});

  Widget build(BuildContext context) {
    List<Widget> tasksResult = new List();
    for (int i = 0; i < tasks.length; i++){
      if(!tasks[i].val) tasksResult.add(tasks[i]);
    }
    return Column(
      children: tasksResult,
    );
  }
}