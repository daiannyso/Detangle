import "package:flutter/material.dart";
import "Task.dart";

class FinishedTasks extends StatelessWidget {
  final List<Task> tasks;

  FinishedTasks({this.tasks});

  Widget build(BuildContext context) {
    List<Widget> tasksResult = new List();
    for (int i = 0; i < tasks.length; i++){
      if(tasks[i].val) tasksResult.add(tasks[i]);
    }
    return Column(
      children: tasksResult,
    );
  }
}