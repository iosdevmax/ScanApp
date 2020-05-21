
class Document {
  DateTime _createDate;
  DateTime _updateDate;
  List<String> _pages;
  String _documentName;

  Document({
    String name, 
    DateTime createDate, 
    DateTime updateDate, 
    List<String> pages}) : _documentName = name, _createDate = createDate, _updateDate = updateDate, _pages = pages;

  void addPage(Object page) {
    _pages.add(page);
  }

}