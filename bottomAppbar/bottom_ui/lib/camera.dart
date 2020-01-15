import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyCameraApp());

class MyCameraApp extends StatefulWidget {
  // This widget is the root of your application.
  State<StatefulWidget> createState() {
    return _MyCameraAppState();
  }
}

class _MyCameraAppState extends State<MyCameraApp> {
  File _image;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }
    @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: SingleChildScrollView( child:
      Column(children: <Widget>[
        Center(
          child: _image == null
            ? new Text('No image selected')
            : new Image.file(_image),
      ),
      ],),
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: getImage,
          tooltip: 'Pick Image',
          child: new Icon(Icons.photo_camera)),
    ));
  }
}