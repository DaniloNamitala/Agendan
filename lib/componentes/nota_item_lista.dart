import 'package:flutter/material.dart';

class NotaItem extends StatefulWidget {
  final String titulo;
  final DateTime data;
  final Function acaoAbrir;
  final Function acaoDeletar;
  NotaItem({this.titulo, this.data, this.acaoAbrir, this.acaoDeletar});

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<NotaItem> {
  formatarData(DateTime data) {
    return data.day.toString() +
        "/" +
        data.month.toString() +
        '/' +
        data.year.toString();
  }

  confirmaDelete() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).dialogBackgroundColor,
            title: Text(
              'Tem certeza que deseja deletar?',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            actions: <Widget>[
              RaisedButton(
                color: Color.fromRGBO(100, 0, 0, 1),
                child: Text(
                  'Sim',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .apply(color: Colors.white),
                ),
                onPressed: () {
                  widget.acaoDeletar(widget.titulo);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Color.fromRGBO(0, 0, 0, 0.1),
          border: Border.all(color: Color.fromRGBO(255, 255, 255, 1))),
      height: 80,
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: GestureDetector(
              onTap: () => widget.acaoAbrir(widget.titulo),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.titulo,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: "Times",
                          letterSpacing: 3)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Criado em ' + formatarData(widget.data),
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                    onPressed: () => confirmaDelete())
              ],
            ),
          )
        ],
      ),
    );
  }
}
