import 'package:flutter/material.dart';

import '../models/document.dart';

class Folder {

  final String _name;
  final List<Document> _documents;

  Folder({ String name, List<Document> documents }) : _name = name, _documents = documents;

  String folderName() {
    return _name;
  }

  int documentsCount() {
    if (_documents == null) return 0;
    return _documents.length;
  }

}