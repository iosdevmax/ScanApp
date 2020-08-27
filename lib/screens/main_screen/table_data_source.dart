import '../../models/document.dart';
import '../../models/folder.dart';

class MonthYear {
  final int month;
  final int year;

  MonthYear({this.month, this.year});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthYear &&
          runtimeType == other.runtimeType &&
          month == other.month &&
          year == other.year;

  @override
  int get hashCode => month.hashCode ^ year.hashCode;

  String get title {
    var title = '';
    switch (month) {
      case 1:
        title += 'Jan';
        break;
      case 2:
        title += 'Feb';
        break;
      case 3:
        title += 'Mar';
        break;
      case 4:
        title += 'Apr';
        break;
      case 5:
        title += 'May';
        break;
      case 6:
        title += 'Jun';
        break;
      case 7:
        title += 'Jul';
        break;
      case 8:
        title += 'Aug';
        break;
      case 9:
        title += 'Sep';
        break;
      case 10:
        title += 'Oct';
        break;
      case 11:
        title += 'Nov';
        break;
      case 12:
        title += 'Dec';
        break;
    }
    return title += ' $year';
  }
}

extension MonthYearComparison on DateTime {
  bool isSame(MonthYear date) {
    if ((this.month == date.month) && (this.year == date.year)) {
      return true;
    }
    return false;
  }
}

class TableDateSource {
  List<Document> _docs;
  List<Folder> _folders;

  TableDateSource({List<Document> docs, List<Folder> folders})
      : _docs = docs,
        _folders = folders;

  List<MonthYear> _extractUniqueDateFrom(List<Document> documents) {
    final List<MonthYear> monthYearDates = [];
    documents.forEach((document) {
      final date = MonthYear(
          month: document.createDate.month, year: document.createDate.year);
      monthYearDates.add(date);
    });
    return monthYearDates.toSet().toList();
  }

  List<SortedDocuments> get _sortedDocuments {
    if (_docs == null) return [];

    /// sorting docs by creation date
    _docs.sort((a, b) => b.createDate.compareTo(a.createDate));

    final uniqueDates = _extractUniqueDateFrom(_docs);

    final List<SortedDocuments> sorted = [];

    uniqueDates.forEach((date) {
      final currentMonthDocs =
          _docs.where((doc) => doc.createDate.isSame(date)).toList();
      final sortedDocs =
          SortedDocuments(docs: currentMonthDocs, title: date.title);
      sorted.add(sortedDocs);
    });

    return sorted;
  }

  int get sections {
    return _sortedDocuments.length + (_folders == null ? 0 : 1);
  }

  int getRows(int section) {
    if (_folders != null) {
      switch (section) {
        case 0:
          return _folders.length;
        default:
          return _sortedDocuments[section - 1].docs.length;
      }
    } else {
      return _sortedDocuments[section].docs.length;
    }
  }

  String getSectionTitle(int section) {
    if (_folders == null) {
      return _sortedDocuments[section].title;
    }
    return section >= 1 ? _sortedDocuments[section - 1].title : '';
  }

  Folder getFolderAt(int row) {
    _folders.sort((a, b) => a.folderName.compareTo(b.folderName));
    return _folders[row];
  }

  Document getDocumentAt(int section, int row) {
    if (_folders == null) {
      return _sortedDocuments[section].docs[row];
    }
    return section >= 1 ? _sortedDocuments[section - 1].docs[row] : null;
  }
}

class SortedDocuments {
  String title;
  List<Document> docs;

  SortedDocuments({this.title, this.docs});
}
