import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:scan_app/bloc/bloc.dart';
import 'package:thumbnails/thumbnails.dart';
import 'package:path/path.dart' as path;


class CapturedImageBloc implements Bloc {
  List<FileSystemEntity> _images;
  List<FileSystemEntity> get images => _images;

  StreamController<List<FileSystemEntity>> _imagesController = BehaviorSubject();

  Stream<List<FileSystemEntity>> get imagesStream => _imagesController.stream;

  void getAllSavedImage() async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/media';
    final myDir = Directory(dirPath);
    List<FileSystemEntity> _images;
    if (await myDir.exists() == false) return;

    _images = myDir.listSync(recursive: true, followLinks: false);
    _images.sort((a, b) {
      return b.path.compareTo(a.path);
    });
    if (_images.length == 0) return;
    
    var lastFile = _images[0];
    var extension = path.extension(lastFile.path);
    if (extension == '.jpeg') {
      _imagesController.sink.add(_images.reversed.toList());
    } else {
      String thumb = await Thumbnails.getThumbnail(
          videoFile: lastFile.path, imageType: ThumbFormat.PNG, quality: 30);
      _imagesController.sink.add([File(thumb)]);
    }
  }

  void clearImages() async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/media';
    final myDir = Directory(dirPath);
    if (await myDir.exists()) {
      myDir.deleteSync(recursive: true);
      _imagesController.sink.add([]);
    }
  }

  Future<void> deleteImage(int index) async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/media';
    final myDir = Directory(dirPath);
    if (await myDir.exists() == false) return;
    _images = myDir.listSync(recursive: true, followLinks: false);
    _images.sort((a, b) {
      return b.path.compareTo(a.path);
    });

    var reversedImgs = _images.reversed.toList();
    print('reversedImgs - ${reversedImgs.length}');

    reversedImgs[index].deleteSync(recursive: true);
    reversedImgs.remove(reversedImgs[index]);
    print('deleteSync reversedImgs - ${reversedImgs.length}');

    _imagesController.sink.add(reversedImgs);
  }

  Future<bool> isEmptyImageList() async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/media';
    final myDir = Directory(dirPath);
    if (await myDir.exists()) {
      _images = myDir.listSync(recursive: true, followLinks: false);
      return _images.length == 0;
    }
    return false;
  }

  @override
  void dispose() {
    _imagesController.close();
  }
}
