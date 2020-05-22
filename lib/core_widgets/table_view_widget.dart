import 'package:flutter/material.dart';
import 'package:flutter_tableview/flutter_tableview.dart';
import 'package:scan_app/models/document.dart';
import 'package:scan_app/models/folder.dart';
import 'package:scan_app/screens/main_screen/document_cell.dart';
import 'package:scan_app/screens/main_screen/folder_cell.dart';

class TableViewWidget extends StatefulWidget {
  final Map<String, List<Object>> data;

  TableViewWidget(this.data);

  @override
  _TableViewWidgetState createState() => _TableViewWidgetState();
}

class _TableViewWidgetState extends State<TableViewWidget> {
  // How many section.
  int sectionCount = 2;

  // Get row count.
  int _rowCountAtSection(int section) {
    if (section == 0) {
      var folders = widget.data['folders'] as List<Folder>;
      if (folders.length == null) return 0;
      return folders.length;
    } else if (section == 1) {
      var docs = widget.data['docs'] as List<Document>;
      if (docs == null) return 0;
      return docs.length;
    }
    return 0;
  }

  // Section header widget builder.
  Widget _sectionHeaderBuilder(BuildContext context, int section) {
    // First section is for folders
    return section == 0
        ? null
        : InkWell(
            onTap: () {
              print('click section header. -> section:$section');
            },
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 16.0),
              color: Color.fromRGBO(220, 220, 220, 1),
              height: 100,
              child: Text('I am section header -> section:$section'),
            ),
          );
  }

  // cell item widget builder.
  Widget _cellBuilder(BuildContext context, int section, int row) {
    var folders = widget.data['folders'] as List<Folder>;
    var docs = widget.data['docs'] as List<Document>;

    return InkWell(
      onTap: () {
        print('click cell item. -> section:$section row:$row');
      },
      child: section == 1
          ? DocumentCell(
              document: docs[row],
            )
          : FolderCell(
              folder: folders[row],
            ),
    );
  }

  // Each section header height;
  double _sectionHeaderHeight(BuildContext context, int section) {
    return 25.0;
  }

  // Each cell item widget height.
  double _cellHeight(BuildContext context, int section, int row) {
    return 90.0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      //FlutterTableView
      child: FlutterTableView(
        sectionCount: 3,
        rowCountAtSection: _rowCountAtSection,
        sectionHeaderBuilder: _sectionHeaderBuilder,
        cellBuilder: _cellBuilder,
        sectionHeaderHeight: _sectionHeaderHeight,
        cellHeight: _cellHeight,
      ),
    );
  }
}
