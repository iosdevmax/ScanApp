import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:scan_app/bloc/bloc_provider.dart';
import 'package:scan_app/bloc/captured_image_bloc.dart';
import 'package:scan_app/models/preview_image.dart';

import 'package:scan_app/screens/filter_screen/filter_screen.dart';
import 'package:scan_app/screens/main_screen/main_screen.dart';
import 'package:scan_app/screens/preview_screen/preview_bottom_bar_item.dart';
import 'package:scan_app/support_files/helper.dart';

class PreviewScreen extends StatefulWidget {
  static const routeName = '/preview-screen';

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  final PageController controller = PageController();
  int currentPage = 0;
  List<FileSystemEntity> _images;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      int next = controller.page.round();

      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  // List<PreviewImage> _buildPreviewImages(List<FileSystemEntity> images) {
  //   List<PreviewImage> previewImages = [];
  //   images.forEach((element) {
  //     var image = PreviewImage(element);
  //     previewImages.add(image);
  //   });
  //   return previewImages;
  // }

  _buildImagePage(File image, bool active) {
    // Animated Properties
    final double top = active ? 0 : 50;

    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 0, right: 0),
      child: Image.file(image),
    );
  }

  void _cropAndRotateOriginalImage(FileSystemEntity image, BuildContext context) async {
    File croppedImage = await ImageCropper.cropImage(
      sourcePath: image.path,
      maxWidth: 312,
      maxHeight: 512,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Edit document',
          toolbarColor: Theme.of(context).backgroundColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
    );

    if (croppedImage != null) {
      setState(() {
        _images[currentPage] = croppedImage;
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var settings = ModalRoute.of(context).settings;
    final _imagesToEdit = settings.arguments as List<FileSystemEntity>;
    this._images = _imagesToEdit;

    final _block = BlocProvider.of<CapturedImageBloc>(context);

    final bool iphonex =
        (Platform.isIOS) && (MediaQuery.of(context).size.height >= 812.0);
    final double _bottomPadding = iphonex ? 25.0 : 0.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Preview Screen'),
        actions: <Widget>[
          FlatButton(
            highlightColor: Colors.transparent,
            child: Text(
              'Save',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(MainScreen.routeName);
            },
          ),
        ],
        leading: GestureDetector(
          child: Icon(Icons.close),
          onTap: () {
            Helper.showAlert(
                context, '', 'Your document will be deleted. Are you sure?',
                () async {
              _block.clearImages();
              Navigator.of(context).pop();
            }, () {
              print('cancel');
            });
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: _images == null
              ? Container(
                  child: Center(
                    child: Text('No data'),
                  ),
                )
              : Stack(
                  alignment: FractionalOffset.bottomCenter,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 30,
                        top: 10,
                        left: 10,
                        right: 10,
                      ),
                      child: PageView.builder(
                        controller: controller,
                        itemCount: _images.length,
                        itemBuilder: (ctx, index) {
                          bool active = index == currentPage;
                          return _buildImagePage(
                            _images[index],
                            active,
                          );
                        },
                      ),
                    ),
                    _images.length == 0
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${currentPage + 1}/${_images.length}',
                            ),
                          ),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: _bottomPadding),
        decoration: BoxDecoration(
          border: Border.symmetric(
            vertical: BorderSide(width: 0.2),
            horizontal: BorderSide(width: 0),
          ),
        ),
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            PreviewScreenBottomBarItem(
              icon: Icons.add_circle,
              title: 'Add page',
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            PreviewScreenBottomBarItem(
              icon: Icons.photo_filter,
              title: 'Filter',
              onTap: () async {
                // final imageToEdit = _block.getImageAt(currentPage);
                // final filteredImage = await Navigator.of(context)
                //     .pushNamed(FilterScreen.routeName, arguments: imageToEdit) as Image;
 
                // setState(() {
                  // _images[currentPage].filteredImage = filteredImage;
                // });
              },
            ),
            PreviewScreenBottomBarItem(
              icon: Icons.crop_rotate,
              title: 'Edit',
              onTap: () async {
                // go to crop screen
                // final imageToEdit = _block.getImageAt(currentPage);
                // _cropAndRotateOriginalImage(imageToEdit, context);
              },
            ),
            PreviewScreenBottomBarItem(
              icon: Icons.delete,
              title: 'Delete',
              onTap: () async {
                setState(() {
                  _images.removeAt(currentPage);
                  _block.deleteImage(currentPage);
                  if (_images.isEmpty) {
                    _block.clearImages();
                    Navigator.of(context).pop();
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
