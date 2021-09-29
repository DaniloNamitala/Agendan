import 'package:flutter/material.dart';

class Corpo extends StatefulWidget {
  final Widget listBuilder;
  Corpo(this.listBuilder);
  @override
  _CorpoState createState() => _CorpoState();
}

class _CorpoState extends State<Corpo> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 9,
        child: Container(
            padding: EdgeInsets.only(top: 5), child: widget.listBuilder));
  }
}
