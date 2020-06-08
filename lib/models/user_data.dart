import 'package:scan_app/models/document.dart';
import 'package:scan_app/models/folder.dart';

class UserData {
  List<Folder> folders;
  List<Document> docs;

  UserData({this.folders, this.docs});

  bool get isEmpty => docs.length == 0 && folders.length == 0;
}
