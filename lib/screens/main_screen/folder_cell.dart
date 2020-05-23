import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scan_app/support_files/constants.dart';

import '../../models/folder.dart';

const String folderIcon = 'assets/images/folder_icon.png';

class FolderCell extends StatelessWidget {
  final Folder folder;
  final SlidableController controller;

  FolderCell({this.folder, this.controller});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(folder.folderName),
      controller: controller,
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Rename',
          color: Theme.of(context).dialogBackgroundColor,
          icon: Icons.edit,
          foregroundColor: Theme.of(context).backgroundColor,
          onTap: () {
            print('More button tapped');
          },
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Theme.of(context).dialogBackgroundColor,
          icon: Icons.delete,
          foregroundColor: Theme.of(context).backgroundColor,
          onTap: () {
            print('Delete button tapped');
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Container(
          alignment: Alignment.center,
          height: 90,
          child: ListTile(
            title: Text(
              folder.folderName,
              style: TextStyle(fontSize: 16),
            ),
            leading: Stack(
              alignment: const Alignment(0.0, 1.0),
              children: <Widget>[
                Container(
                  height: 60,
                  width: 60,
                  child: Image.asset(
                    folderIcon,
                    width: 60,
                    height: 60,
                  ),
                ),
                Positioned(
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: Text(
                      '${folder.documentsCount}',
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
            trailing: IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: null,
            ),
            onTap: () {
              print('Tapped ${folder.folderName}');

              if (controller.activeState != null) {
                controller.activeState.close();
              }
            },
          ),
        ),
      ),
    );
  }
}
