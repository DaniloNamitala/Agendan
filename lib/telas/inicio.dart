import 'package:agendan/componentes/lista_notas.dart';
import 'package:flutter/material.dart';
import 'package:agendan/componentes/corpo.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelColor: Colors.white,
            labelStyle: Theme.of(context).textTheme.bodyText1,
            tabs: <Widget>[Tab(text: 'Notas'), Tab(text: 'Tarefas')],
          ),
          backgroundColor: Color.fromRGBO(30, 30, 30, 1),
          title: Text(
            'Agenda-N',
            style: TextStyle(fontFamily: "Times", letterSpacing: 3),
          ),
        ),
        body: TabBarView(
          children: <Widget>[ListaNotas(), Corpo(Text("aaa"))],
        ),
      ),
    );
  }
}
