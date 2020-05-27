import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_tableview/flutter_tableview.dart';

import '../screens/main_screen/document_cell.dart';
import '../screens/main_screen/folder_cell.dart';
import '../screens/main_screen/table_data_source.dart';

class TableViewWidget extends StatefulWidget {
  final TableDateSource tableDataSource;

  final SlidableController slidableController = SlidableController();

  TableViewWidget({this.tableDataSource});

  @override
  _TableViewWidgetState createState() => _TableViewWidgetState();
}

class _TableViewWidgetState extends State<TableViewWidget> {
  // How many section.
  int get _sectionCount {
    return widget.tableDataSource.sections;
  }

  // Get row count.
  int _rowCountAtSection(int section) {
    return widget.tableDataSource.getRows(section);
  }

  // Section header widget builder.
  Widget _sectionHeaderBuilder(BuildContext context, int section) {
    // First section is for folders
    final sectionTitle = widget.tableDataSource
        .getSectionTitle(section); //.sortedDocs[section].title;
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
              height: 25,
              child: Text(sectionTitle),
            ),
          );
  }

  // cell item widget builder.
  Widget _cellBuilder(BuildContext context, int section, int row) {
    return InkWell(
      onTap: () {
        print('click cell item. -> section:$section row:$row');
      },
      child: section == 0
          ? FolderCell(
              folder: widget.tableDataSource.getFolderAt(row), //folders[row],
              controller: widget.slidableController,
            )
          : DocumentCell(
              document: widget.tableDataSource
                  .getDocumentAt(section, row), //sortedDocs.docs[row],
              controller: widget.slidableController,
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
      height: 550,
      //FlutterTableView
      child: FlutterTableView(
        sectionCount: _sectionCount,
        rowCountAtSection: _rowCountAtSection,
        sectionHeaderBuilder: _sectionHeaderBuilder,
        cellBuilder: _cellBuilder,
        sectionHeaderHeight: _sectionHeaderHeight,
        cellHeight: _cellHeight,
      ),
    );
  }
}
