import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core_widgets/table_view_widget.dart';
import '../../models/document.dart';
import '../../models/folder.dart';
import '../main_screen/search_bar.dart';
import '../camera_screen/camera_screen.dart';
import '../main_screen/main_screen_popup.dart';

class MainScreen extends StatelessWidget {
  static List<Folder> folders = [
    Folder(name: 'Document Folder 1', documents: [Document()]),
    Folder(name: 'Document Folder 2', documents: [Document(), Document(), Document(), Document()]),
    Folder(name: 'Document Folder 3', documents: [Document(), Document()]),
  ];

  static List<Document> docs = [
    Document(name: 'Document 1', pages: ['2', '2', '3']),
    Document(name: 'Documents 2', pages: ['we']),
    Document(name: 'Documemtn 13123', pages: ['qw', 'qw', 'we', 'asd'])
  ];

  final Map<String, List<Object>> data = {
    'folders' : folders,
    'docs' : docs,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        actions: <Widget>[
          MainScreenPopupMenu(),
        ],
        title: Text('ScanApp'),
      ),
      body: Column(
        children: <Widget>[
          SearchBar(),
          TableViewWidget(data),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          // displaying the camera screen modally
          Navigator.of(context, rootNavigator: true).push<void>(
            CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => CameraScreen(),
            ),
          );
          // Navigator.of(context).pushNamed(CameraScreen.routeName);
        },
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}
