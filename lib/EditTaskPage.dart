import "package:flutter/material.dart";
import "Task.dart";
import "RecurringBox.dart";
import "dart:async";

class EditTaskPage extends StatefulWidget {
  List<Task> tasks;
  String name;
  DateTime dataInicio;
  DateTime dataFim;
  int diaInicio;
  int mesInicio;
  int tipoDeRecorrencia;//[0] Sem recorrência, [1] diariamente, [2] a cada (num) dias, [3] semanalmente (pode selecionar os dias da semana), [4] mensalmente, [5] anualmente
  int numDeDias;
  bool seg;
  bool ter;
  bool qua;
  bool qui;
  bool sex;
  bool sab;
  bool dom;

  EditTaskPage({this.tasks, this.name, this.dataInicio, this.dataFim, this.diaInicio, this.mesInicio, this.tipoDeRecorrencia, this.numDeDias, this.seg, this.ter, this.qua, this.qui, this.sex, this.sab, this.dom});

  _EditTaskPage createState() => new _EditTaskPage();
}

class _EditTaskPage extends State<EditTaskPage> {
  bool temDataFim = false;
  DateTime selectedBeginingDate;
  DateTime dateAux = new DateTime.now();
  DateTime selectedEndDate;
  RecurringBox dados;

  void initState(){
    selectedBeginingDate = widget.dataInicio;
    selectedEndDate = widget.dataFim;
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

  void removePreviousTask(){
    for (int i = 0; i < widget.tasks.length; i++){
      if((widget.name.compareTo(widget.tasks[i].name) == 0) &&
          (widget.dataInicio.isAtSameMomentAs(widget.tasks[i].dataInicio)) &&
          (widget.dataFim.isAtSameMomentAs(widget.tasks[i].dataFim)) &&
          (widget.diaInicio == widget.tasks[i].diaInicio) &&
          (widget.mesInicio == widget.tasks[i].mesInicio) &&
          (widget.tipoDeRecorrencia == widget.tasks[i].tipoDeRecorrencia) &&
          (widget.numDeDias == widget.tasks[i].numDeDias) &&
          (widget.seg == widget.tasks[i].seg) &&
          (widget.ter == widget.tasks[i].ter) &&
          (widget.qua == widget.tasks[i].qua) &&
          (widget.qui == widget.tasks[i].qui) &&
          (widget.sex == widget.tasks[i].sex) &&
          (widget.sab == widget.tasks[i].sab) &&
          (widget.dom == widget.tasks[i].dom)){
        widget.tasks.removeAt(i);
      }
    }
  }

  void addTask(){
    if(controller.text.isNotEmpty){
      if (temDataFim && ((dados.valueAt == 1) || (dados.valueAt == 4) || (dados.valueAt == 5))){
        widget.tasks.add(Task(widget.tasks, controller.text, new DateTime.utc(selectedBeginingDate.year, selectedBeginingDate.month, selectedBeginingDate.day, 0, 0, 0, 0, 0), new DateTime.utc(selectedEndDate.year, selectedEndDate.month, selectedEndDate.day, 0, 0, 0, 0), dados.valueAt, 1, false, false, false, false, false, false, false),);
        removePreviousTask();
        Navigator.pop(context);
      } else if (((dados.valueAt == 1) || (dados.valueAt == 4) || (dados.valueAt == 5) || (dados.valueAt == 0))){
        widget.tasks.add(Task(widget.tasks, controller.text, new DateTime.utc(selectedBeginingDate.year, selectedBeginingDate.month, selectedBeginingDate.day, 0, 0, 0, 0, 0), new DateTime.utc(1995, 6, 16, 0, 0, 0, 0), dados.valueAt, 1, false, false, false, false, false, false, false),);
        removePreviousTask();
        Navigator.pop(context);
      }

      else if (dados.valueAt == 2 && temDataFim){
        widget.tasks.add(Task(widget.tasks, controller.text, new DateTime.utc(selectedBeginingDate.year, selectedBeginingDate.month, selectedBeginingDate.day, 0, 0, 0, 0, 0), new DateTime.utc(selectedEndDate.year, selectedEndDate.month, selectedEndDate.day, 0, 0, 0, 0), 2, dados.numOfDays, false, false, false, false, false, false, false),);
        removePreviousTask();
        Navigator.pop(context);
      } else if (dados.valueAt == 2){
        widget.tasks.add(Task(widget.tasks, controller.text, new DateTime.utc(selectedBeginingDate.year, selectedBeginingDate.month, selectedBeginingDate.day, 0, 0, 0, 0, 0), new DateTime.utc(1995, 6, 16, 0, 0, 0, 0), 2, dados.numOfDays, false, false, false, false, false, false, false),);
        removePreviousTask();
        Navigator.pop(context);
      }

      else if (dados.valueAt == 3 && temDataFim){
        widget.tasks.add(Task(widget.tasks, controller.text, new DateTime.utc(selectedBeginingDate.year, selectedBeginingDate.month, selectedBeginingDate.day, 0, 0, 0, 0, 0), new DateTime.utc(selectedEndDate.year, selectedEndDate.month, selectedEndDate.day, 0, 0, 0, 0), 3, 1, dados.segunda, dados.terca, dados.quarta, dados.quinta, dados.sexta, dados.sabado, dados.domingo),);
        removePreviousTask();
        Navigator.pop(context);
      } else if (dados.valueAt == 3){
        widget.tasks.add(Task(widget.tasks, controller.text, new DateTime.utc(selectedBeginingDate.year, selectedBeginingDate.month, selectedBeginingDate.day, 0, 0, 0, 0, 0), new DateTime.utc(1995, 6, 16, 0, 0, 0, 0), 3, 1, dados.segunda, dados.terca, dados.quarta, dados.quinta, dados.sexta, dados.sabado, dados.domingo),);
        removePreviousTask();
        Navigator.pop(context);
      }
    }
  }

  final controller = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar tarefa"),
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
              labelText: widget.name,
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