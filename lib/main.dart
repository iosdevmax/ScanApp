import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './screens/document_details_screen/document_details_screen.dart';
import './screens/folder_details_screen/folder_details_screen.dart';
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
          dialogBackgroundColor: Color.fromRGBO(242, 242, 247, 0.96)),
      home: MyHomePage(),
      routes: {
        CameraScreen.routeName: (ctx) => CameraScreen(),
        FolderDetailsScreen.routeName: (ctx) => FolderDetailsScreen(),
        DocumentDetailsScreen.routeName: (ctx) => DocumentDetailsScreen(),
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
