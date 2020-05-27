import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main_screen/table_data_source.dart';
import '../../support_files/helper.dart';
import '../../core_widgets/table_view_widget.dart';
import '../../models/document.dart';
import '../../models/folder.dart';
import '../main_screen/search_bar.dart';
import '../camera_screen/camera_screen.dart';
import '../main_screen/main_screen_popup.dart';


class MainScreen extends StatelessWidget {
  static List<Folder> folders = [
    Folder(name: 'document Folder 1', documents: [Document()]),
    Folder(name: 'wfwer2', documents: [Document(), Document(), Document(), Document()]),
    Folder(name: 'arege', documents: [Document(), Document()]),
  ];

  static List<Document> docs = [
    Document(name: 'Document 1', pages: ['2', '2', '3'], createDate: DateTime.parse('2020-05-27 00:00:00')),
    Document(name: 'Documents 2', pages: ['we'], createDate: DateTime.parse('2020-05-25 00:00:00')),
    Document(name: 'Documemtn 13123', pages: ['qw', 'qw', 'we', 'asd'], createDate: DateTime.parse('2020-05-22 00:00:00')),
    Document(name: 'Documemtn 13', pages: ['qw', 'qw', 'we', 'asd'], createDate: DateTime.parse('2020-04-22 00:00:00')),
    Document(name: 'Documemtn 1123', pages: ['qw', 'qw', 'we', 'asd'], createDate: DateTime.parse('2020-04-22 00:00:00')),
    Document(name: 'Documemtn 123', pages: ['qw', 'qw', 'we', 'asd'], createDate: DateTime.parse('2020-03-21 00:00:00')),
    Document(name: 'Documem23', pages: ['qw', 'qw',], createDate: DateTime.parse('2020-01-02 00:00:00')),
    Document(name: 'Documem23', pages: ['we', 'asd'], createDate: DateTime.parse('2020-01-02 00:00:00')),
    Document(name: 'Documem23', pages: ['qw', 'we', 'asd'], createDate: DateTime.parse('2020-06-12 00:00:00')),
    Document(name: 'Documem23', pages: ['qw', 'qw', 'asd'], createDate: DateTime.parse('2019-11-02 00:00:00')),
    Document(name: 'Documem23', pages: ['qw', 'qw', 'we', 'asd'], createDate: DateTime.parse('2018-01-02 00:00:00')),
  ];

  final tableDataSource = TableDateSource(docs: docs, folders: folders);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        actions: <Widget>[
          MainScreenPopupMenu(),
        ],
        title: Text('ScanApp'),
      ),
      body: Column(
        children: <Widget>[
          SearchBar(),
          TableViewWidget(
            tableDataSource: tableDataSource,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      resizeToAvoidBottomPadding: false,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Helper.presentScreenModally(CameraScreen(), context);
        },
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}
