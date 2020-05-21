import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './screens/main_screen/main_screen.dart';
import './screens/camera_screen/camera_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Colors.white,
        backgroundColor: Color.fromRGBO(147, 0, 0, 1),
      ),
      home: MyHomePage(),
      routes: {
        CameraScreen.routeName: (ctx) => CameraScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }
}
