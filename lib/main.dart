import "package:flutter/material.dart";
import 'package:flutter/foundation.dart';
import "AddTaskButton.dart";
import "Task.dart";
import "YesterdayTasks.dart";
import "ByDayTasks.dart";
import "FinishedTasks.dart";
import "NotFinishedTasks.dart";


void main() => runApp(MyApp());

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback resumeCallBack;

  LifecycleEventHandler({this.resumeCallBack});

  @override
  Future<Null> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.suspending:
      case AppLifecycleState.resumed:
        await resumeCallBack();
        break;
    }
  }
}

class MyApp extends StatefulWidget {
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  List<Task> tasks;
  DateTime agora = DateTime.now();
  int selectedTile = 0;

  void initState() {
    tasks = <Task>[
    Task(tasks, "Estudar IA", new DateTime.utc(2019, 11, 27), new DateTime.utc(2019, 11, 10), 1, 0, false, false, false, false, false, false, false,),
    Task(tasks, "Teste 1", new DateTime.utc(2019, 11, 28), new DateTime.utc(1995, 6, 16), 0, 0, false, false, false, false, false, false, false,),
    Task(tasks, "Teste 2", new DateTime.utc(2019, 11, 27), new DateTime.utc(1995, 6, 16), 2, 2, false, false, false, false, false, false, false,),
    Task(tasks, "Teste 3", new DateTime.utc(2019, 11, 26), new DateTime.utc(1995, 6, 16), 1, 0, false, false, false, false, false, false, false,),
    Task(tasks, "Teste 4", new DateTime.utc(2019, 11, 27), new DateTime.utc(1995, 6, 16), 0, 0, false, false, false, false, false, false, false,),
    Task(tasks, "Teste 5", new DateTime.utc(2019, 11, 27), new DateTime.utc(1995, 6, 16), 3, 0, true, false, true, false, false, true, true,),
    Task(tasks, "Teste 5", new DateTime.utc(2019, 11, 27), new DateTime.utc(1995, 6, 16), 3, 0, true, false, true, false, false, true, true,),
    Task(tasks, "Teste 6", new DateTime.utc(2019, 12, 31), new DateTime.utc(1995, 6, 16), 4, 0, false, false, false, false, false, false, false,),
    Task(tasks, "Teste 7", new DateTime.utc(2020, 2, 29), new DateTime.utc(1995, 6, 16), 5, 0, false, false, false, false, false, false, false,),
  ];
    super.initState();
    WidgetsBinding.instance.addObserver(
        new LifecycleEventHandler(resumeCallBack: () async => _refreshContent()));
  }

  void _refreshContent() {
    setState(() {
      agora = DateTime.now();
    });
  }

  Widget hojeTile(BuildContext context){
    Widget atrasadasTasks = YesterdayTasks(tasks: tasks, agora: agora);
    Widget hojeTasks = ByDayTasks(tasks: tasks, agora: agora, numOfDays: 0);

    return ListView(
      children: <Widget>[
        Text("Atrasadas"),
        atrasadasTasks,
        Text("Hoje"),
        hojeTasks,
      ],
    );
  }

  Widget seteDiasTile(BuildContext context){
    Widget amanhaTasks = ByDayTasks(tasks: tasks, agora: agora, numOfDays: 1);
    Widget doisTasks = ByDayTasks(tasks: tasks, agora: agora, numOfDays: 2);
    Widget tresTasks = ByDayTasks(tasks: tasks, agora: agora, numOfDays: 3);
    Widget quatroTasks = ByDayTasks(tasks: tasks, agora: agora, numOfDays: 4);
    Widget cincoTasks = ByDayTasks(tasks: tasks, agora: agora, numOfDays: 5);
    Widget seisTasks = ByDayTasks(tasks: tasks, agora: agora, numOfDays: 6);

    return ListView(
      children: <Widget>[
        Text("Amanhã"),
        amanhaTasks,
        Text("Daqui a 2 dias"),
        doisTasks,
        Text("Daqui a 3 dias"),
        tresTasks,
        Text("Daqui a 4 dias"),
        quatroTasks,
        Text("Daqui a 5 dias"),
        cincoTasks,
        Text("Daqui a 6 dias"),
        seisTasks,
      ],
    );
  }

  Widget concluidosTile(BuildContext context){
    Widget concluidasTasks = FinishedTasks(tasks: tasks);

    return ListView(
      children: <Widget>[
        concluidasTasks,
      ],
    );
  }

  Widget naoConcluidosTile(BuildContext context){
    Widget naoConcluidasTasks = NotFinishedTasks(tasks: tasks);

    return ListView(
      children: <Widget>[
        naoConcluidasTasks,
      ],
    );
  }

  Widget corpoPrincipal(BuildContext context){
    if (selectedTile == 0){
      return hojeTile(context);
    }
    if (selectedTile == 1){
      return seteDiasTile(context);
    }
    if (selectedTile == 2){
      return naoConcluidosTile(context);
    }
    return concluidosTile(context);
  }

  Widget tituloPrincipal(BuildContext context){
    if (selectedTile == 0){
      return Text("Hoje");
    }
    if (selectedTile == 1){
      return Text("Próximos 7 dias");
    }
    if (selectedTile == 2){
      return Text("Tarefas pendentes");
    }
    return Text("Tarefas concluídas");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Text("Detangle"),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text("Hoje"),
                onTap: (){
                  setState((){
                    selectedTile = 0;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Próximos 7 dias"),
                onTap: (){
                    setState((){
                      selectedTile = 1;
                    });
                    Navigator.pop(context);
                  },
              ),
              ListTile(
                title: Text("Tarefas pendentes"),
                onTap: (){
                  setState((){
                    selectedTile = 2;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Tarefas concluídas"),
                onTap: (){
                  setState((){
                    selectedTile = 3;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: tituloPrincipal(context),
        ),
        body: corpoPrincipal(context),
        floatingActionButton: AddTaskButton(tasks: tasks),
        backgroundColor: Colors.blue[50],
      ),
    );
  }
}