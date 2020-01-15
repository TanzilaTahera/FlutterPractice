import 'package:flutter/material.dart';

void main() => runApp(MyTabApp());
class MyTabApp extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _MyTabAppState();
  }
}

class _MyTabAppState extends State<MyTabApp> {
    @override
  Widget build(BuildContext context) {
    return MaterialApp(
            home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'First Tab',),
                Tab(icon: Icon(Icons.mail)),
                Tab(icon: Icon(Icons.phone)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
            Container(
              child: Text('This is First Tab'),
            ),
            Container(
              child: Text('This is Second Tab'),
            ),
            Container(
              child: Text('This is Third Tab'),
            ),
            ],
          ),
        ),
      ),
    );
  }
}