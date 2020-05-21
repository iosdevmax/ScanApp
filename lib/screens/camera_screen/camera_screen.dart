import 'package:flutter/material.dart';

class CameraScreen extends StatelessWidget {
  static const routeName = '/camera_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Camera'),
      ),
      body: Center(
        child: Text('Camera screen'),
      ),
    );
  }
}
