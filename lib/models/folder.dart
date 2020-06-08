import '../models/document.dart';

class Folder {

  String _name;
  final List<Document> _documents;

  Folder({ String name, List<Document> documents }) : _name = name, _documents = documents;

  void setName(String name) {
    this._name = name;
  }

  String get folderName {
    return _name;
  }

  int get documentsCount {
    if (_documents == null) return 0;
    return _documents.length;
  }

}