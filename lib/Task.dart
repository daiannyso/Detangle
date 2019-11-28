import "package:flutter/material.dart";
import "PomodoroPage.dart";
import "EditTaskPage.dart";

class Task extends StatefulWidget {
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
  bool val = false;

  Task(List<Task> tasks, String name, DateTime dataInicio, DateTime dataFim, int tipoDeRecorrencia, int numDeDias, bool seg, bool ter, bool qua, bool qui, bool sex, bool sab, bool dom){
    this.tasks = tasks;
    this.name = name;
    this.dataInicio = dataInicio;
    this.diaInicio = dataInicio.day;
    this.mesInicio = dataInicio.month;
    this.dataFim = dataFim;
    this.tipoDeRecorrencia = tipoDeRecorrencia;
    this.numDeDias = numDeDias;
    this.seg = seg;
    this.ter = ter;
    this.qua = qua;
    this.qui = qui;
    this.sex = sex;
    this.sab = sab;
    this.dom = dom;
  }

  _Task createState() => _Task();
}

class _Task extends State<Task> {
  DateTime nextWeekday(DateTime data, int dayOfWeek){
    DateTime result = DateTime.utc(data.year, data.month, data.day, 0, 0, 0, 0, 0);
    if (dayOfWeek > data.weekday)
      return data.add(new Duration(days: dayOfWeek-result.weekday));
    else if (dayOfWeek == data.weekday)
      return data.add(new Duration(days: 7));
    return data.add(new Duration(days: (7-data.weekday)+dayOfWeek));
  }

  DateTime nextDateByWeek(DateTime dataResult){
    DateTime novoInicio = dataResult.add(new Duration(days: 8));
    if (widget.seg){
      DateTime segunda = nextWeekday(dataResult, 1);
      if(segunda.isBefore(novoInicio))
        novoInicio = segunda;
    }
    if (widget.ter){
      DateTime terca = nextWeekday(dataResult, 2);
      if(terca.isBefore(novoInicio))
        novoInicio = terca;
    }
    if (widget.qua){
      DateTime quarta = nextWeekday(dataResult, 3);
      if(quarta.isBefore(novoInicio))
        novoInicio = quarta;
    }
    if (widget.qui){
      DateTime quinta = nextWeekday(dataResult, 4);
      if(quinta.isBefore(novoInicio))
        novoInicio = quinta;
    }
    if (widget.sex){
      DateTime sexta = nextWeekday(dataResult, 5);
      if(sexta.isBefore(novoInicio))
        novoInicio = sexta;
    }
    if (widget.sab){
      DateTime sabado = nextWeekday(dataResult, 6);
      if(sabado.isBefore(novoInicio))
        novoInicio = sabado;
    }
    if (widget.dom){
      DateTime domingo = nextWeekday(dataResult, 7);
      if(domingo.isBefore(novoInicio))
        novoInicio = domingo;
    }
    return novoInicio;
  }

  DateTime nextDateByMonth(DateTime dataResult){
    int ano;
    int mes;
    if (dataResult.day < widget.diaInicio){
      ano = dataResult.year;
      mes = dataResult.month;
    } else if (dataResult.month == 12) {
      ano = dataResult.year+1;
      mes = 1;
    } else {
      ano = dataResult.year;
      mes = dataResult.month+1;
    }
    return (new DateTime.utc(ano, mes, 1, 0, 0, 0, 0, 0)).add(new Duration(days: widget.diaInicio-1));
  }

  DateTime nextDateByYear(DateTime dataResult){//Método que calcula próxima data, caso a recorrência seja anual
    DateTime date;
    if ((widget.diaInicio == 29)&&(widget.mesInicio == 2)){ //Caso a data escolhida seja dia 29 de fevereiro, tratar os anos bissextos
      date = new DateTime.utc(widget.dataInicio.year+1, widget.mesInicio, widget.diaInicio-1, 0, 0, 0, 0, 0);
      date = date.add(new Duration(days: 1));
      while (date.isBefore(dataResult) || date.isAtSameMomentAs(dataResult)){
        date = new DateTime.utc(date.year+1, widget.mesInicio, widget.diaInicio-1, 0, 0, 0, 0, 0);
        date = date.add(new Duration(days: 1));
      }
    } else {
      date = new DateTime.utc(widget.dataInicio.year+1, widget.mesInicio, widget.diaInicio, 0, 0, 0, 0, 0);
      while (date.isBefore(dataResult) || date.isAtSameMomentAs(dataResult))
        date = new DateTime.utc(date.year+1, widget.mesInicio, widget.diaInicio, 0, 0, 0, 0, 0);
    }
    return date;
  }

  DateTime nextDate(){
    DateTime agora = DateTime.now();
    DateTime agoraDia = new DateTime.utc(agora.year, agora.month, agora.day, 0, 0, 0, 0, 0);
    DateTime dataResult = widget.dataInicio;
    if (widget.dataInicio.isBefore(agoraDia)) //Caso a tarefa esteja atrasada
      dataResult = agoraDia;

    if (widget.tipoDeRecorrencia == 0)  //Caso a tarefa não tenha recorrência
      return new DateTime.utc(1995, 6, 16, 0, 0, 0, 0, 0);
    else if (widget.tipoDeRecorrencia == 1) //Caso a tarefa deva se repetir todos os dias
      return dataResult.add(new Duration(days: 1));
    else if (widget.tipoDeRecorrencia == 2) //Caso a tarefa deva se repetir por um número determinado de dias
      return dataResult.add(new Duration(days: widget.numDeDias));
    else if (widget.tipoDeRecorrencia == 3){  //Caso a tarefa deva se repetir em dias específicos da semana
      return nextDateByWeek(dataResult);
    }
    else if (widget.tipoDeRecorrencia == 4){  //Caso a tarefa deva se repetir mensalmente
      return nextDateByMonth(dataResult);
    }
    return nextDateByYear(dataResult);//Caso a tarefa deva se repetir anualmente -> recorrência 5
  }

  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.0,
      child: FlatButton(
        color: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PomodoroPage()),
          );
        },
        child: Row(
          children: <Widget>[
            Checkbox(
              value: widget.val,
              onChanged: (bool value) {
                setState(() {
                  widget.val = value;
                  DateTime proximaData = nextDate();
                  DateTime dateDefault = new DateTime.utc(1995, 6, 16, 0, 0, 0, 0, 0);
                  if (!widget.dataFim.isAtSameMomentAs(dateDefault) && widget.dataFim.isBefore(proximaData))
                    widget.dataInicio = dateDefault;
                  else
                    widget.dataInicio = proximaData;
                });
              },
            ),
            Text(widget.name),
            Text("     " + widget.dataInicio.day.toString() + "/" + widget.dataInicio.month.toString() + "/" + widget.dataInicio.year.toString()),
            FlatButton(
              onPressed: (){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditTaskPage(tasks: widget.tasks, name: widget.name, dataInicio: widget.dataInicio, dataFim: widget.dataFim, diaInicio: widget.diaInicio, mesInicio: widget.mesInicio, tipoDeRecorrencia: widget.tipoDeRecorrencia, numDeDias: widget.numDeDias, seg: widget.seg, ter: widget.ter, qua: widget.qua, qui: widget.qui, sex: widget.sex, sab: widget.sab, dom: widget.dom)),
              );},
              child: Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}
