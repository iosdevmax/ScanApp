import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scan_app/models/document.dart';
import 'package:scan_app/models/folder.dart';

import '../main_screen/folder_cell.dart';
import '../main_screen/search_bar.dart';
import '../camera_screen/camera_screen.dart';
import '../main_screen/main_screen_popup.dart';

class MainScreen extends StatelessWidget {
  
  final List<Folder> folders = [
    Folder(name: 'Document Folder 1', documents: [Document()]),
    Folder(name: 'Document Folder 2', documents: [Document(),Document(),Document(),Document()]),
    Folder(name: 'Document Folder 3', documents: [Document(), Document()]),
  ];

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
          Container(
            height: 600,
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
                height: 0,
                thickness: 0.5,
              ),
              itemBuilder: (ctx, i) => FolderCell(folder: folders[i]),
              itemCount: folders.length,
            ),
          ),
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
