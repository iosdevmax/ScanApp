import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(147, 0, 0, 1),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
            ),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(
              Icons.scanner,
            ),
            onPressed: null,
          ),
        ],
        title: Text('ScanApp'),
      ),
      body: Center(
        child: Center(
          child: Text('Center'),
        ),
      ),
    );
  }
}
