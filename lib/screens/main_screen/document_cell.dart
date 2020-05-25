import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../support_files/helper.dart';
import '../../screens/document_details_screen/document_details_screen.dart';
import '../../screens/camera_screen/camera_screen.dart';
import '../../models/document.dart';

class DocumentCell extends StatelessWidget {
  final Document document;
  final SlidableController controller;

  DocumentCell({this.document, this.controller});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(document.documentName),
      controller: controller,
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Add page',
          color: Theme.of(context).dialogBackgroundColor,
          icon: Icons.add_circle,
          foregroundColor: Theme.of(context).backgroundColor,
          onTap: () {
            Helper.presentScreenModally(CameraScreen(), context);
          },
        ),
        IconSlideAction(
          caption: 'Share',
          color: Theme.of(context).dialogBackgroundColor,
          icon: Icons.file_upload,
          foregroundColor: Theme.of(context).backgroundColor,
          onTap: () {
            print('Delete button tapped');
            Helper.showAlert(context, 'Shared button tapped');
          },
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Theme.of(context).dialogBackgroundColor,
          icon: Icons.delete,
          foregroundColor: Theme.of(context).backgroundColor,
          onTap: () {
            print('Delete button tapped');
            Helper.showAlert(context, 'Delete document?',
                'Are you sure you want to delete the document?');
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Container(
          alignment: Alignment.center,
          height: 90,
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  document.documentName,
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  '15/05/2020',
                  style: TextStyle(fontSize: 10),
                ),
                Text('#tag1, #tag2', style: TextStyle(fontSize: 12)),
              ],
            ),
            leading: Stack(
              alignment: const Alignment(0.0, 1.0),
              children: <Widget>[
                Container(
                  height: 60,
                  width: 40,
                  child: Image.asset(
                    'assets/images/document_icon.png',
                    width: 40,
                    height: 60,
                  ),
                ),
                Positioned(
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: Text(
                      '${document.pagesCount}',
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
              print('Tapped ${document.documentName}');

              if (controller.activeState != null) {
                controller.activeState.close();
              }
              Navigator.of(context).pushNamed(DocumentDetailsScreen.routeName);
            },
          ),
        ),
      ),
    );
  }
}
