import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scan_app/bloc/bloc_provider.dart';
import 'package:scan_app/bloc/captured_image_bloc.dart';

import 'package:scan_app/screens/camera_screen/camera_screen.dart';
import 'package:scan_app/screens/crop_screen/crop_screen.dart';
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

  _buildImagePage(File imageFile, bool active) {
    // Animated Properties
    final double top = active ? 0 : 50;

    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 0, right: 0),
      child: Image.file(
        imageFile,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _block = BlocProvider.of<CapturedImageBloc>(context);
    _block.getAllSavedImage();

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
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: StreamBuilder<List<FileSystemEntity>>(
            stream: _block.imagesStream,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container(
                      child: Center(
                        child: Text('No data'),
                      ),
                    )
                  : Stack(
                      alignment: FractionalOffset.bottomCenter,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30, top: 10),
                          child: PageView.builder(
                            controller: controller,
                            itemCount: snapshot.data.length,
                            itemBuilder: (ctx, index) {
                              bool active = index == currentPage;
                              return _buildImagePage(
                                  snapshot.data[index], active);
                            },
                          ),
                        ),
                        snapshot.data.length == 0
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    '${currentPage + 1}/${snapshot.data.length}'),
                              ),
                      ],
                    );
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
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
              onTap: () {
                Navigator.of(context).pushNamed(FilterScreen.routeName);
              },
            ),
            PreviewScreenBottomBarItem(
              icon: Icons.rotate_90_degrees_ccw,
              title: 'Rotate',
              onTap: () {},
            ),
            PreviewScreenBottomBarItem(
              icon: Icons.crop_free,
              title: 'Crop',
              onTap: () {
                // go to crop screen
                Navigator.of(context).pushNamed(CropScreen.routeName);
              },
            ),
            PreviewScreenBottomBarItem(
              icon: Icons.delete,
              title: 'Delete',
              onTap: () async {
                await _block.deleteImage(currentPage);
                if (await _block.isEmptyImageList()) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
