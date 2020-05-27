import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:scan_app/models/document.dart';
import 'package:scan_app/models/folder.dart';
import 'package:scan_app/screens/main_screen/main_screen.dart';
import 'package:scan_app/screens/main_screen/table_data_source.dart';

List<Folder> mockFolders = [
  Folder(name: 'My new folder 1', documents: []),
  Folder(name: 'Someone\'s folder', documents: []),
  Folder(name: 'Work folder', documents: []),
];

void main() {
  group('Sections', () {
    test('Test number of section when there is no documents', () {
      final dataSource = TableDateSource(folders: [Folder(), Folder()]);
      expect(dataSource.sections, 1);
    });

    test('Number of sections when there are folders and same month documents',
        () {
      final dataSource = TableDateSource(folders: mockFolders, docs: [
        Document(createDate: DateTime.parse('2020-05-27 00:00:00')),
        Document(createDate: DateTime.parse('2020-05-24 00:00:00')),
        Document(createDate: DateTime.parse('2020-05-20 00:00:00')),
      ]);

      expect(dataSource.sections, 2);
    });

    test(
        'Number of sections when there are folders, two different months documents',
        () {
      final dataSource = TableDateSource(folders: mockFolders, docs: [
        Document(createDate: DateTime.parse('2020-05-27 00:00:00')),
        Document(createDate: DateTime.parse('2020-05-24 00:00:00')),
        Document(createDate: DateTime.parse('2020-05-20 00:00:00')),
        Document(createDate: DateTime.parse('2020-04-20 00:00:00')),
        Document(createDate: DateTime.parse('2020-04-11 00:00:00')),
      ]);
      expect(dataSource.sections, 3);
    });

    test(
        'Number of sections when there are folders, different months and years documents',
        () {
      final dataSource = TableDateSource(folders: mockFolders, docs: [
        Document(createDate: DateTime.parse('2020-05-27 00:00:00')),
        Document(createDate: DateTime.parse('2020-05-24 00:00:00')),
        Document(createDate: DateTime.parse('2020-03-20 00:00:00')),
        Document(createDate: DateTime.parse('2020-04-20 00:00:00')),
        Document(createDate: DateTime.parse('2020-02-11 00:00:00')),
        Document(createDate: DateTime.parse('2020-05-20 00:00:00')),
        Document(createDate: DateTime.parse('2018-04-20 00:00:00')),
        Document(createDate: DateTime.parse('2020-04-11 00:00:00')),
        Document(createDate: DateTime.parse('2019-04-11 00:00:00')),
      ]);
      expect(dataSource.sections, 7);
    });
  });

  group('Rows', () {
    test('Test number of rows for the folder section', () {
      final dataSource =
          TableDateSource(folders: [Folder(), Folder(), Folder()]);
      expect(dataSource.getRows(0), 3);
    });

    test('Number of rows when there are no folders and same month documents', () {
      final dataSource = TableDateSource(docs: [
        Document(createDate: DateTime.parse('2020-05-27 00:00:00')),
        Document(createDate: DateTime.parse('2020-05-23 00:00:00')),
        Document(createDate: DateTime.parse('2020-05-20 00:00:00')),
      ]);

      expect(dataSource.getRows(0), 3);
      expect(dataSource.getSectionTitle(0), 'May 2020');
    });

    test('Number of rows when there are folders and same month documents', () {
      final dataSource = TableDateSource(folders: mockFolders, docs: [
        Document(createDate: DateTime.parse('2020-05-27 00:00:00')),
        Document(createDate: DateTime.parse('2020-05-23 00:00:00')),
        Document(createDate: DateTime.parse('2020-05-20 00:00:00')),
      ]);

      expect(dataSource.getRows(0), 3);
      expect(dataSource.getRows(1), 3);
      expect(dataSource.getSectionTitle(1), 'May 2020');
    });

    test(
        'Number of rows when there are folder, different months and years documents',
        () {
      final dataSource = TableDateSource(folders: mockFolders, docs: [
        Document(createDate: DateTime.parse('2020-05-27 00:00:00')),
        Document(createDate: DateTime.parse('2020-05-24 00:00:00')),
        Document(createDate: DateTime.parse('2020-03-20 00:00:00')),
        Document(createDate: DateTime.parse('2020-04-20 00:00:00')),
        Document(createDate: DateTime.parse('2020-02-11 00:00:00')),
        Document(createDate: DateTime.parse('2020-05-20 00:00:00')),
        Document(createDate: DateTime.parse('2018-04-20 00:00:00')),
        Document(createDate: DateTime.parse('2020-04-11 00:00:00')),
        Document(createDate: DateTime.parse('2019-04-11 00:00:00')),
      ]);

      expect(dataSource.getRows(0), 3);
      expect(dataSource.getRows(1), 3);
      expect(dataSource.getRows(2), 2);
      expect(dataSource.getRows(3), 1);
      expect(dataSource.getRows(4), 1);
      expect(dataSource.getRows(5), 1);
      expect(dataSource.getRows(6), 1);

      expect(dataSource.getSectionTitle(1), 'May 2020');
      expect(dataSource.getSectionTitle(2), 'Apr 2020');
      expect(dataSource.getSectionTitle(3), 'Mar 2020');
      expect(dataSource.getSectionTitle(4), 'Feb 2020');
      expect(dataSource.getSectionTitle(5), 'Apr 2019');
      expect(dataSource.getSectionTitle(6), 'Apr 2018');
    });
  });

  test('Folder at row', () {
    final folder2 = Folder();
    final dataSource = TableDateSource(folders: [Folder(), folder2]);
    expect(dataSource.getFolderAt(1), folder2);
    expect(dataSource.getFolderAt(0) != folder2, true);
  });

  test('Document at row (with folders)', () {
    final document =
        Document(createDate: DateTime.parse('2020-05-27 00:00:00'));
    final dataSource = TableDateSource(folders: mockFolders, docs: [
      document,
      Document(createDate: DateTime.parse('2020-05-22 00:00:00')),
    ]);

    expect(dataSource.getDocumentAt(1, 0), document);
    expect(dataSource.getDocumentAt(1, 1) != document, true);
  });

  test('Document at row (without folders)', () {
    final document =
        Document(createDate: DateTime.parse('2020-05-27 00:00:00'));
    final dataSource = TableDateSource(docs: [
      Document(createDate: DateTime.parse('2020-05-22 00:00:00')),
      document,
    ]);

    expect(dataSource.getDocumentAt(0, 0), document);
    expect(dataSource.getDocumentAt(0, 1) != document, true);
  });
}
