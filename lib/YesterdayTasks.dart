import "package:flutter/material.dart";
import "Task.dart";

class YesterdayTasks extends StatelessWidget {
  final List<Task> tasks;
  final DateTime agora;

  YesterdayTasks({this.tasks,this.agora});

  Widget build(BuildContext context) {
    List<Widget> tasksYesterday = new List();
    DateTime diaResult = new DateTime.utc(agora.year, agora.month, agora.day, 0, 0, 0, 0, 0);
    for (int i = 0; i < tasks.length; i++){
      DateTime dataAux = tasks[i].dataInicio;
      if (dataAux.isBefore(diaResult) && (!tasks[i].val)){
        tasksYesterday.add(tasks[i]);
      }
    }
    return Column(
      children: tasksYesterday,
    );
  }
}
