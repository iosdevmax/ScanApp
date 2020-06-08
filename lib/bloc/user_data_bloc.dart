import 'dart:async';

import 'package:scan_app/bloc/bloc.dart';
import 'package:scan_app/models/document.dart';
import 'package:scan_app/models/folder.dart';
import 'package:scan_app/models/user_data.dart';

class UserDataBloc implements Bloc {
  UserData _userData;
  UserData get userData => _userData;

  /// access to file management system

  final _userDataController = StreamController<UserData>();

  Stream<UserData> get userDataStream => _userDataController.stream;

  void getDocuments() async {
    final result = UserData(docs: docs, folders: folders);
    _userDataController.sink.add(result);
  }

  @override
  void dispose() {
    _userDataController.close();
  }

  static List<Folder> folders = [
    Folder(name: 'document Folder 1', documents: [Document()]),
    Folder(name: 'wfwer2', documents: [Document()]),
    Folder(name: 'arege', documents: [Document(), Document()]),
  ];

  static List<Document> docs = [
    Document(
        name: 'Document 1',
        pages: ['2', '2', '3'],
        createDate: DateTime.parse('2020-05-27 00:00:00')),
    Document(
        name: 'Documents 2',
        pages: ['we'],
        createDate: DateTime.parse('2020-05-25 00:00:00')),
    Document(
        name: 'Documemtn 13123',
        pages: ['qw', 'qw', 'we', 'asd'],
        createDate: DateTime.parse('2020-05-22 00:00:00')),
    Document(
        name: 'Documemtn 13',
        pages: ['qw', 'qw', 'we', 'asd'],
        createDate: DateTime.parse('2020-04-22 00:00:00')),
    Document(
        name: 'Documemtn 1123',
        pages: ['qw', 'qw', 'we', 'asd'],
        createDate: DateTime.parse('2020-04-22 00:00:00')),
    Document(
        name: 'Documemtn 123',
        pages: ['qw', 'qw', 'we', 'asd'],
        createDate: DateTime.parse('2020-03-21 00:00:00')),
    Document(
        name: 'Documem23',
        pages: [
          'qw',
          'qw',
        ],
        createDate: DateTime.parse('2020-01-02 00:00:00')),
    Document(
        name: 'Documem23',
        pages: ['we', 'asd'],
        createDate: DateTime.parse('2020-01-02 00:00:00')),
    Document(
        name: 'Documem23',
        pages: ['qw', 'we', 'asd'],
        createDate: DateTime.parse('2020-06-12 00:00:00')),
    Document(
        name: 'Documem23',
        pages: ['qw', 'qw', 'asd'],
        createDate: DateTime.parse('2019-11-02 00:00:00')),
    Document(
        name: 'Documem23',
        pages: ['qw', 'qw', 'we', 'asd'],
        createDate: DateTime.parse('2018-01-02 00:00:00')),
  ];
}
