import "package:flutter/material.dart";
import "Task.dart";
import "dart:async";

class RecurringBox extends StatefulWidget{
  int dayOfWeekSelected;

  int valueAt;
  String selectedValue;
  int numOfDays;

  bool segunda;
  bool terca;
  bool quarta;
  bool quinta;
  bool sexta;
  bool sabado;
  bool domingo;

  RecurringBox(int dayOfWeekSelected){
    this.dayOfWeekSelected = dayOfWeekSelected;
  }

  _RecurringBox createState() => new _RecurringBox();
}
class _RecurringBox extends State<RecurringBox>{
  List<String> values = new List<String>();

  @override
  void initState(){
    values.addAll(["Sem Recorrência", "Diariamente", "A cada", "Semanalmente", "Mensalmente", "Anualmente"]);
    widget.selectedValue = values.elementAt(0);
    widget.valueAt = 0;
    widget.numOfDays = 1;

    if (widget.dayOfWeekSelected == 1){
      widget.segunda = true; widget.terca = false; widget.quarta = false; widget.quinta = false; widget.sexta = false; widget.sabado = false; widget.domingo = false;
    } else if (widget.dayOfWeekSelected == 2) {
      widget.segunda = false; widget.terca = true; widget.quarta = false; widget.quinta = false; widget.sexta = false; widget.sabado = false; widget.domingo = false;
    } else if (widget.dayOfWeekSelected == 3) {
      widget.segunda = false; widget.terca = false; widget.quarta = true; widget.quinta = false; widget.sexta = false; widget.sabado = false; widget.domingo = false;
    } else if (widget.dayOfWeekSelected == 4) {
      widget.segunda = false; widget.terca = false; widget.quarta = false; widget.quinta = true; widget.sexta = false; widget.sabado = false; widget.domingo = false;
    } else if (widget.dayOfWeekSelected == 5) {
      widget.segunda = false; widget.terca = false; widget.quarta = false; widget.quinta = false; widget.sexta = true; widget.sabado = false; widget.domingo = false;
    } else if (widget.dayOfWeekSelected == 6) {
      widget.segunda = false; widget.terca = false; widget.quarta = false; widget.quinta = false; widget.sexta = false; widget.sabado = true; widget.domingo = false;
    } else {
      widget.segunda = false; widget.terca = false; widget.quarta = false; widget.quinta = false; widget.sexta = false; widget.sabado = false; widget.domingo = true;
    }
  }

  Color selectColor(bool value){
    if (value) return Colors.blue;
    return Colors.white10;
  }

  void onChanged(String value){
    setState((){
      widget.selectedValue = value;
      if (value.compareTo("Diariamente") == 0)
        widget.valueAt = 1;
      else if (value.compareTo("A cada") == 0)
        widget.valueAt = 2;
      else if (value.compareTo("Semanalmente") == 0)
        widget.valueAt = 3;
      else if (value.compareTo("Mensalmente") == 0)
        widget.valueAt = 4;
      else if (value.compareTo("Anualmente") == 0)
        widget.valueAt = 5;
      else
        widget.valueAt = 0;
    });
  }

  Widget selectRecorrencia(BuildContext context){
    return Container(
      child: Column(
          children: <Widget>[
            DropdownButton(
              value: widget.selectedValue,
              items: values.map((String value){
                return new DropdownMenuItem(
                  value: value,
                  child: Text("${value}"),
                );
              }).toList(),
              onChanged: (String value){
                onChanged(value);
              },
            ),
          ]
      ),
    );
  }

  Widget selectDay(BuildContext context){
    return Row(
      children: <Widget>[
        RaisedButton(
          child: Text("-"),
          onPressed: () {
            setState((){
              if(widget.numOfDays > 1)
                widget.numOfDays--;
            });
          }
        ),
        Text("${widget.numOfDays}"),
        RaisedButton(
            child: Text("+"),
            onPressed: () {
              setState((){
                widget.numOfDays++;
              });
            }
        ),
      ],
    );
  }

  Widget selectDaysOfWeek(BuildContext context){
    return Row(
      children: <Widget>[
        SizedBox(
          width: 50,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.blue),
            ),
            color: selectColor(widget.segunda),
            child: Text("S"),
            onPressed: () {
              setState((){
                if (widget.segunda && (widget.dayOfWeekSelected != 1))
                  widget.segunda = false;
                else
                  widget.segunda = true;
              });
            },
          ),
        ),
        SizedBox(
          width: 50,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.blue),
            ),
            color: selectColor(widget.terca),
            child: Text("T"),
            onPressed: () {
              setState((){
                if (widget.terca && (widget.dayOfWeekSelected != 2))
                  widget.terca = false;
                else
                  widget.terca = true;
              });
            },
          ),
        ),
        SizedBox(
          width: 50,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.blue),
            ),
            color: selectColor(widget.quarta),
            child: Text("Q"),
            onPressed: () {
              setState((){
                if (widget.quarta && (widget.dayOfWeekSelected != 3))
                  widget.quarta = false;
                else
                  widget.quarta = true;
              });
            },
          ),
        ),
        SizedBox(
          width: 50,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.blue),
            ),
            color: selectColor(widget.quinta),
            child: Text("Q"),
            onPressed: () {
              setState((){
                if (widget.quinta && (widget.dayOfWeekSelected != 4))
                  widget.quinta = false;
                else
                  widget.quinta = true;
              });
            },
          ),
        ),
        SizedBox(
          width: 50,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.blue),
            ),
            color: selectColor(widget.sexta),
            child: Text("S"),
            onPressed: () {
              setState((){
                if (widget.sexta && (widget.dayOfWeekSelected != 5))
                  widget.sexta = false;
                else
                  widget.sexta = true;
              });
            },
          ),
        ),
        SizedBox(
          width: 50,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.blue),
            ),
            color: selectColor(widget.sabado),
            child: Text("S"),
            onPressed: () {
              setState((){
                if (widget.sabado && (widget.dayOfWeekSelected != 6))
                  widget.sabado = false;
                else
                  widget.sabado = true;
              });
            },
          ),
        ),
        SizedBox(
          width: 50,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.blue),
            ),
            color: selectColor(widget.domingo),
            child: Text("D"),
            onPressed: () {
              setState((){
                if (widget.domingo && (widget.dayOfWeekSelected != 7))
                  widget.domingo = false;
                else
                  widget.domingo = true;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget complementRecorrencia(BuildContext context){
    if (widget.valueAt == 2)
      return selectDay(context);
    else if (widget.valueAt == 3)
      return selectDaysOfWeek(context);
    return Container();
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        selectRecorrencia(context),
        complementRecorrencia(context),
      ],
    );
  }
}