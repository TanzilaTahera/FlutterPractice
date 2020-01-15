import 'package:flutter/material.dart';
void main() => runApp(CheckApp());

class CheckApp extends StatefulWidget {
  // This widget is the root of your application.
  State<StatefulWidget> createState() {
    return _CheckAppState();
  }
}

class _CheckAppState extends State<CheckApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Container(
            height: 100,
            width: 100,
            color: Colors.redAccent,
          ),
        )
    );
  }
}