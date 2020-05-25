import 'package:flutter/material.dart';

class FolderDetailsScreen extends StatelessWidget {
  static const routeName = '/folder_details_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Folder Details'),
      ),
      body: Center(
        child: Text('Centel'),
      ),
    );
  }
}
