import 'package:flutter/material.dart';
import 'package:scan_app/models/document.dart';

class DocumentCell extends StatelessWidget {
  final Document document;

  DocumentCell({this.document});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              Text('15/05/2020', style: TextStyle(fontSize: 10),),
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
          onTap: () {},
        ),
      ),
    );
  }
}
