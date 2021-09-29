import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class TelaTexto extends StatefulWidget {
  final Function addItem;
  final String nomeArquivo;
  final bool isNew;
  final Function rename;
  TelaTexto(this.nomeArquivo, [this.isNew = false, this.addItem, this.rename]);
  @override
  _TelaTextoState createState() => _TelaTextoState();
}

class _TelaTextoState extends State<TelaTexto> {
  String nomeArquivo;
  bool isNew;
  TextEditingController controllerTexto = TextEditingController();
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path + '/arquivos';
  }

  Future<File> _localFile(String nome) async {
    final path = await _localPath;
    return File('$path/$nome');
  }

  Future<String> get _leArquivo async {
    try {
      final file = await _localFile(nomeArquivo);
      String txt = await file.readAsString();
      return txt;
    } catch (e) {
      return '';
    }
  }

  Future<bool> salvaArquivo(String nome, [String antigoNome]) async {
    bool isDone = false;
    final file = await _localFile(nome);
    if (!file.existsSync()) {
      if (isNew) {
        escreveArquivo(file);
        isDone = true;
      } else {
        renomeia(antigoNome, nome);
        isDone = true;
      }
    } else {
      if (antigoNome == null) {
        escreveArquivo(file);
      } else {
        Fluttertoast.showToast(
            msg: "Já existe um arquivo com esse nome",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromRGBO(75, 75, 75, 1),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
    return isDone;
  }

  escreveArquivo(File file) async {
    file.writeAsString(controllerTexto.text);
  }

  renomeia(String antigo, String novo) async {
    File file = await _localFile(antigo);
    file.delete();
    file = await _localFile(novo);
    escreveArquivo(file);
    widget.rename(antigo, novo);
  }

  recebeTitulo(String titulo) {
    var tituloController = TextEditingController();
    tituloController.text = titulo;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).dialogBackgroundColor,
            title: Text(
              isNew ? 'Salvar como:' : 'Renomear',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .apply(color: Colors.white, fontSizeDelta: 5),
            ),
            content: TextField(
              controller: tituloController,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .apply(color: Colors.white, fontSizeDelta: 1),
            ),
            actions: <Widget>[
              RaisedButton(
                color: Color.fromRGBO(0, 100, 0, 1),
                child: Text(
                  'Salvar',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .apply(color: Colors.white),
                ),
                onPressed: () {
                  salvaArquivo(tituloController.text, nomeArquivo)
                      .then((value) {
                    if (value) {
                      if (isNew) {
                        widget.addItem(tituloController.text, DateTime.now());
                        isNew = false;
                      }
                      setState(() {
                        nomeArquivo = tituloController.text;
                      });
                      Navigator.of(context).pop();
                    }
                  });
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    nomeArquivo = widget.nomeArquivo;
    isNew = widget.isNew;
    _leArquivo.then((String value) => {
          setState(() {
            if (value != null) controllerTexto.text = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            disabledColor: Color.fromRGBO(80, 80, 80, 1),
            tooltip: "Renomear",
            icon: Icon(Icons.edit),
            onPressed: isNew ? null : () => recebeTitulo(nomeArquivo),
          ),
          IconButton(
              tooltip: 'Salvar',
              icon: Icon(Icons.save),
              onPressed: () {
                isNew ? recebeTitulo(nomeArquivo) : salvaArquivo(nomeArquivo);
              })
        ],
        backgroundColor: Color.fromRGBO(30, 30, 30, 1),
        title: Text(
          nomeArquivo,
          style: Theme.of(context).textTheme.bodyText1.apply(
              color: Color.fromRGBO(255, 255, 255, 1), fontSizeDelta: 10),
        ),
      ),
      body: Container(
        color: Color.fromRGBO(50, 50, 50, 1),
        padding: EdgeInsets.all(10),
        child: TextField(
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .apply(color: Color.fromRGBO(255, 255, 255, 1), fontSizeDelta: 3),
          controller: controllerTexto,
          decoration: InputDecoration(border: InputBorder.none),
          minLines: 40,
          maxLines: null,
          keyboardType: TextInputType.multiline,
        ),
      ),
    );
  }
}
