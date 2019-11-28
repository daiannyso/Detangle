import "package:flutter/material.dart";
import "Task.dart";
import "RecurringBox.dart";
import "dart:async";

class AddTaskPage extends StatefulWidget {
  List<Task> tasks;

  AddTaskPage({this.tasks});

  _AddTaskPage createState() => new _AddTaskPage();
}

class _AddTaskPage extends State<AddTaskPage> {
  bool temDataFim = false;
  DateTime selectedBeginingDate = new DateTime.now();
  DateTime dateAux = new DateTime.now();
  DateTime selectedEndDate = new DateTime.now();
  RecurringBox dados;

  void initState(){
    dados = new RecurringBox(selectedBeginingDate.weekday);
  }

  Future<Null> selectBeginingDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(context: context, initialDate: dateAux, firstDate: dateAux, lastDate: new DateTime(dateAux.year+10));
    if(picked != null){
      setState((){
        selectedBeginingDate = picked;
      });
    }
  }

  Future<Null> selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(context: context, initialDate: selectedBeginingDate, firstDate: selectedBeginingDate, lastDate: new DateTime(selectedBeginingDate.year+10));
    if(picked != null){
      setState((){
        selectedEndDate = picked;
      });
    }
  }

  Widget dataFimSelecionada(BuildContext context){
    if (temDataFim){
      return RaisedButton(
        child: Text(selectedEndDate.day.toString() + "/" + selectedEndDate.month.toString() + "/" + selectedEndDate.year.toString()),
        onPressed: () {
          selectEndDate(context);
        },
      );
    }
    return RaisedButton(
      child: Text(selectedEndDate.day.toString() + "/" + selectedEndDate.month.toString() + "/" + selectedEndDate.year.toString()),
      onPressed: () {},
    );
  }

  Widget selectDataFim(BuildContext context){
    return Row(
      children: <Widget>[
        Checkbox(
          value: temDataFim,
          onChanged: (bool value) {
            setState(() {
              temDataFim = value;
            });
          },
        ),
        dataFimSelecionada(context),
      ],
    );
  }

  void addTask(){
    if(controller.text.isNotEmpty){
      if (temDataFim && ((dados.valueAt == 1) || (dados.valueAt == 4) || (dados.valueAt == 5))){
        widget.tasks.add(Task(widget.tasks, controller.text, new DateTime.utc(selectedBeginingDate.year, selectedBeginingDate.month, selectedBeginingDate.day, 0, 0, 0, 0, 0), new DateTime.utc(selectedEndDate.year, selectedEndDate.month, selectedEndDate.day, 0, 0, 0, 0), dados.valueAt, 1, false, false, false, false, false, false, false),);
        Navigator.pop(context);
      } else if (((dados.valueAt == 1) || (dados.valueAt == 4) || (dados.valueAt == 5) || (dados.valueAt == 0))){
        widget.tasks.add(Task(widget.tasks, controller.text, new DateTime.utc(selectedBeginingDate.year, selectedBeginingDate.month, selectedBeginingDate.day, 0, 0, 0, 0, 0), new DateTime.utc(1995, 6, 16, 0, 0, 0, 0), dados.valueAt, 1, false, false, false, false, false, false, false),);
        Navigator.pop(context);
      }

      else if (dados.valueAt == 2 && temDataFim){
        widget.tasks.add(Task(widget.tasks, controller.text, new DateTime.utc(selectedBeginingDate.year, selectedBeginingDate.month, selectedBeginingDate.day, 0, 0, 0, 0, 0), new DateTime.utc(selectedEndDate.year, selectedEndDate.month, selectedEndDate.day, 0, 0, 0, 0), 2, dados.numOfDays, false, false, false, false, false, false, false),);
        Navigator.pop(context);
      } else if (dados.valueAt == 2){
        widget.tasks.add(Task(widget.tasks, controller.text, new DateTime.utc(selectedBeginingDate.year, selectedBeginingDate.month, selectedBeginingDate.day, 0, 0, 0, 0, 0), new DateTime.utc(1995, 6, 16, 0, 0, 0, 0), 2, dados.numOfDays, false, false, false, false, false, false, false),);
        Navigator.pop(context);
      }

      else if (dados.valueAt == 3 && temDataFim){
        widget.tasks.add(Task(widget.tasks, controller.text, new DateTime.utc(selectedBeginingDate.year, selectedBeginingDate.month, selectedBeginingDate.day, 0, 0, 0, 0, 0), new DateTime.utc(selectedEndDate.year, selectedEndDate.month, selectedEndDate.day, 0, 0, 0, 0), 3, 1, dados.segunda, dados.terca, dados.quarta, dados.quinta, dados.sexta, dados.sabado, dados.domingo),);
        Navigator.pop(context);
      } else if (dados.valueAt == 3){
        widget.tasks.add(Task(widget.tasks, controller.text, new DateTime.utc(selectedBeginingDate.year, selectedBeginingDate.month, selectedBeginingDate.day, 0, 0, 0, 0, 0), new DateTime.utc(1995, 6, 16, 0, 0, 0, 0), 3, 1, dados.segunda, dados.terca, dados.quarta, dados.quinta, dados.sexta, dados.sabado, dados.domingo),);
        Navigator.pop(context);
      }
    }
  }

  final controller = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar tarefa"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              addTask();
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Tarefa',
            ),
          ),
          RaisedButton(
            child: Text(selectedBeginingDate.day.toString() + "/" + selectedBeginingDate.month.toString() + "/" + selectedBeginingDate.year.toString()),
            onPressed: () {
              selectBeginingDate(context);
            },
          ),
          dados,
          selectDataFim(context),
        ],
      ),
    );
  }
}