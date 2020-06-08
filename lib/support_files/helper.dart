import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Helper {
  /// Present screen modally iOS style
  ///
  static void presentScreenModally(
      StatefulWidget screen, BuildContext context) {
    Navigator.of(context, rootNavigator: true).push<void>(
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (context) => screen,
      ),
    );
  }

  /// show AlertDialog
  ///
  static void showAlert(BuildContext context, String title,
      [String content = '', Function onConfirm, Function onCancel]) {
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
              if (onCancel != null) onCancel();
            },
          ),
          FlatButton(
            child: Text('Yes'),
            onPressed: () {
              Navigator.of(ctx).pop(true);
              if (onConfirm != null) onConfirm();
            },
          ),
        ],
      ),
    );
  }
}
