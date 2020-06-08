import 'package:flutter/material.dart';
import 'package:scan_app/support_files/constants.dart';

class TopButton extends StatefulWidget {
  final CustomImages buttonImage;
  final String title;
  bool isEnabled;
  final Function action;

  TopButton({this.buttonImage, this.title, this.isEnabled, this.action});

  @override
  _TopButtonState createState() => _TopButtonState();
}

class _TopButtonState extends State<TopButton> {
  @override
  Widget build(BuildContext context) {
    print(widget.isEnabled);
    Color color = widget.isEnabled ? Theme.of(context).backgroundColor : Colors.white;
    if (widget.action == null) {
      color = Colors.white24;
    }

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 0.5),
          borderRadius: BorderRadius.circular(5),
        ),
        width: 78,
        height: 49,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              image(widget.buttonImage),
              width: 15,
              height: 20,
              color: color,
            ),
            SizedBox(height: 5),
            Text(
              widget.title,
              style: TextStyle(fontSize: 10, color: color),
            ),
          ],
        ),
      ),
      onTap: () {
        if (widget.action == null) return;

        setState(() {
          widget.isEnabled = !widget.isEnabled;
        });
        widget.action(widget.isEnabled);
      },
    );
  }
}
