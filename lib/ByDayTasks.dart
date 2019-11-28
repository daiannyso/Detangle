import "package:flutter/material.dart";
import "Task.dart";

class ByDayTasks extends StatelessWidget {
  final List<Task> tasks;
  final DateTime agora;
  final int numOfDays;

  ByDayTasks({this.tasks,this.agora,this.numOfDays});

  Widget build(BuildContext context) {
    List<Widget> tasksResult = new List();
    DateTime diaResult = agora.add(new Duration(days: numOfDays));
    for (int i = 0; i < tasks.length; i++){
      DateTime dataAux = tasks[i].dataInicio;
      if ((dataAux.day == diaResult.day) && (dataAux.month == diaResult.month) && (dataAux.year == diaResult.year)){
        if(tasks[i].val) tasks[i].val = false;
        tasksResult.add(tasks[i]);
      }
    }
    return Column(
      children: tasksResult,
    );
  }
}