import 'package:flutter/material.dart';

class PreviewScreenBottomBarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  PreviewScreenBottomBarItem({this.icon, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: Theme.of(context).backgroundColor,),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(fontSize: 10, color: Theme.of(context).backgroundColor),
          ),
        ],
      ),
    );
  }
}
