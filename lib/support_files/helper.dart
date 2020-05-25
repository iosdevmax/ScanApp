import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Helper {
  /// Present screen modally iOS style
  ///
  static void presentScreenModally(
      StatelessWidget screen, BuildContext context) {
    Navigator.of(context, rootNavigator: true).push<void>(
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (context) => screen,
      ),
    );
  }

  /// show AlertDialog
  ///
  static void showAlert(BuildContext context, String title, [String content = '']) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(ctx).pop(false);
            },
          ),
          FlatButton(
            child: Text('Yes'),
            onPressed: () {
              Navigator.of(ctx).pop(true);
            },
          ),
        ],
      ),
    );
  }
}