import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'constant.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Compare',
    home: new MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: AppConstant.APP_NAME,
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(AppConstant.APP_NAME),
      ),
      body: new Center(
        child: new Row(
          children: <Widget>[
            new FloatingActionButton(
              onPressed: () => {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new NewRoute()))
              },
              child: new Text("navigate"),
            )
          ],
        ),
      ),
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("new Router"),
      ),
    );
  }
}
