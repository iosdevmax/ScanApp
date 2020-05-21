import 'package:flutter/material.dart';

class MainScreenPopupMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      offset: Offset(0, 100),
      itemBuilder: (_) => [
        PopupMenuItem(
          // value: value,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset('assets/images/add_folder_icon.png'),
              SizedBox(
                width: 10,
              ),
              Text(
                'Add Folder',
                style: TextStyle(color: Theme.of(context).backgroundColor),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          // value: value,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset('assets/images/select_icon.png'),
              SizedBox(
                width: 10,
              ),
              Text(
                'Select',
                style: TextStyle(color: Theme.of(context).backgroundColor),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          // value: value,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset('assets/images/sort_by_icon.png'),
              SizedBox(
                width: 10,
              ),
              Text(
                'Sort By',
                style: TextStyle(color: Theme.of(context).backgroundColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
