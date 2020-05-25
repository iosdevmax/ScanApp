import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../support_files/helper.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
      child: DecoratedBox(
        child: CupertinoTextField(
          onTap: () {
            Helper.showAlert(context, 'Search Button Pressed');
          },
          prefix: Container(
            padding: EdgeInsets.only(left: 3),
            child: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
          placeholder: "Search...",
        ),
        decoration: BoxDecoration(color: Colors.white),
      ),
    );
  }
}
