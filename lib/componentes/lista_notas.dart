import 'dart:io';

import 'package:agendan/telas/tela_texto.dart';
import 'package:flutter/material.dart';
import 'arquivos.dart';
import 'nota_item_lista.dart';

class ListaNotas extends StatefulWidget {
  final Future<String> futurePath = Arquivo().localPath;
  @override
  _ListaNotasState createState() => _ListaNotasState();
}

class _ListaNotasState extends State<ListaNotas> {
  List<Map<String, dynamic>> lista;
  abreNota(String nota, [bool isNew = false]) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TelaTexto(nota, isNew, addItem, renameItem)));

  String path;
  geraLista() {
    widget.futurePath.then((value) {
      path = value + '/arquivos';
      Arquivo().listaArquivos(path).then((value) {
        setState(() {
          lista = value;
        });
      });
    });
  }

  deletarArquivo(String nome) {
    File(path + '/' + nome).delete();
    setState(() {
      lista.removeWhere((element) => element['nome'] == nome);
    });
  }

  @override
  void initState() {
    super.initState();
    geraLista();
  }

  addItem(String item, DateTime data) {
    setState(() {
      lista.add({'nome': item, 'data': data});
    });
  }

  renameItem(String antigo, String novo) {
    setState(() {
      lista[lista.indexWhere((element) => element['nome'] == antigo)]['nome'] =
          novo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => abreNota('new' + DateTime.now().toString(), true),
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: ListView.builder(
            itemCount: lista == null ? 0 : lista.length,
            itemBuilder: (BuildContext context, int index) {
              return NotaItem(
                titulo: lista[index]['nome'],
                data: lista[index]['data'],
                acaoAbrir: abreNota,
                acaoDeletar: deletarArquivo,
              );
            }),
      ),
    );
  }
}
