import 'package:flutter/material.dart';
import 'telas/inicio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda-N',
      theme: ThemeData(
          fontFamily: "Times",
          backgroundColor: Color.fromRGBO(50, 50, 50, 1),
          dialogBackgroundColor: Color.fromRGBO(75, 75, 75, 1),
          primarySwatch: MaterialColor(0xFF262626, {
            50: Color.fromRGBO(51, 51, 51, .1),
            100: Color.fromRGBO(51, 51, 51, .2),
            200: Color.fromRGBO(51, 51, 51, .3),
            300: Color.fromRGBO(51, 51, 51, .4),
            400: Color.fromRGBO(51, 51, 51, .5),
            500: Color.fromRGBO(51, 51, 51, 1),
            600: Color.fromRGBO(51, 51, 51, .7),
            700: Color.fromRGBO(51, 51, 51, .8),
            800: Color.fromRGBO(51, 51, 51, .9),
            900: Color.fromRGBO(51, 51, 51, 1),
          }),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
              bodyText1: TextStyle(letterSpacing: 3, color: Colors.white))),
      home: Inicio(),
    );
  }
}
