import 'package:flutter/material.dart';

class DocumentDetailsScreen extends StatelessWidget {
  static const routeName = '/document_details_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Document details'),
      ),
      body: Center(
        child: Text('Center'),
      ),
    );
  }
}
