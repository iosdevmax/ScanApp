import 'package:flutter/material.dart';

import '../../models/folder.dart';

class FolderCell extends StatelessWidget {
  final Folder folder;

  FolderCell({this.folder});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
        alignment: Alignment.center,
        height: 90,
        child: ListTile(
          title: Text(
            folder.folderName(),
            style: TextStyle(fontSize: 16),
          ),
          leading: Stack(
            alignment: const Alignment(0.0, 1.0),
            children: <Widget>[
              Container(
                height: 60,
                width: 60,
                child: Image.asset(
                  'assets/images/folder_icon.png',
                  width: 60,
                  height: 60,
                ),
              ),
              Positioned(
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: Text(
                    '${folder.documentsCount()}',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                  radius: 8,
                ),
              )
            ],
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
