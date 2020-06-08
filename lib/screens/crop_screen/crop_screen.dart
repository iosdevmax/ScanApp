import 'package:flutter/material.dart';

class CropScreen extends StatelessWidget {
  static const routeName = '/crop-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop'),
      ),
      body: Center(
        child: Text('Center'),
      ),
    );
  }
}
