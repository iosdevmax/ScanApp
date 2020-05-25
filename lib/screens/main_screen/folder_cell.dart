import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scan_app/support_files/helper.dart';

import '../../screens/folder_details_screen/folder_details_screen.dart';
import '../../support_files/constants.dart';
import '../../models/folder.dart';

const String folderIcon = 'assets/images/folder_icon.png';

class FolderCell extends StatefulWidget {
  final Folder folder;
  final SlidableController controller;

  FolderCell({this.folder, this.controller});

  @override
  _FolderCellState createState() => _FolderCellState();
}

class _FolderCellState extends State<FolderCell> {
  final TextEditingController textController = TextEditingController();

  Future<String> _showRenameDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Folder name'),
        content: TextField(
          controller: textController,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Save'),
            onPressed: () {
              Navigator.of(ctx).pop(textController.text.toString());
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    textController.text = widget.folder.folderName;
    return Slidable(
      key: Key(widget.folder.folderName),
      controller: widget.controller,
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
            _showRenameDialog(context).then((onValue) {
              // TODO: Research on a StreamBuilder pattern
              Future.delayed(const Duration(milliseconds: 100), () {
                setState(() {
                  widget.folder.setName(onValue);
                });
              });
            });
          },
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Theme.of(context).dialogBackgroundColor,
          icon: Icons.delete,
          foregroundColor: Theme.of(context).backgroundColor,
          onTap: () {
            Helper.showAlert(context, 'Delete folder?',
                'Are you sure you want to delete the folder and its content?');
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
              widget.folder.folderName,
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
                      '${widget.folder.documentsCount}',
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
              onPressed: () {
                // open right options programmatically
              },
            ),
            onTap: () {
              print('Tapped ${widget.folder.folderName}');

              if (widget.controller.activeState != null) {
                widget.controller.activeState.close();
              }
              Navigator.of(context).pushNamed(FolderDetailsScreen.routeName);
            },
          ),
        ),
      ),
    );
  }
}
