import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scan_app/bloc/bloc_provider.dart';
import 'package:scan_app/bloc/captured_image_bloc.dart';
import 'package:lamp/lamp.dart';

import 'package:scan_app/screens/camera_screen/camera_top_button_widget.dart';
import 'package:scan_app/support_files/constants.dart';
import 'package:scan_app/screens/preview_screen/preview_screen.dart';

String _timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

class CameraWidget extends StatefulWidget {
  final CameraController _controller;
  bool multipage = false;
  bool autocapture = false;
  bool isLightOn = false;
  bool hasLight;

  CameraWidget(this._controller);

  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  @override
  void initState() {
    super.initState();
    print('initState');
    Lamp.hasLamp.then((light) {
      widget.hasLight = light;
    });
  }

  void _captureImage() async {
    if (widget._controller.value.isTakingPicture) {
      return;
    }

    if (widget._controller.value.isInitialized) {
      final Directory extDir = await getApplicationDocumentsDirectory();
      final String dirPath = '${extDir.path}/media';
      await Directory(dirPath).create(recursive: true);
      final String filePath = '$dirPath/${_timestamp()}.jpeg';
      await widget._controller.takePicture(filePath);
      print('image captured');
      setState(() {});
      final myDir = Directory(dirPath);

      List<FileSystemEntity> _images;
      _images = myDir.listSync(recursive: true, followLinks: false);
      _images.sort((a, b) {
        return b.path.compareTo(a.path);
      });

      if (!widget.multipage) {
        Navigator.of(context).pushNamed(PreviewScreen.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _block = BlocProvider.of<CapturedImageBloc>(context);
    _block.getAllSavedImage();

    return Stack(
      alignment: FractionalOffset.center,
      children: <Widget>[
        CameraPreview(widget._controller),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 120.0,
            color: Color.fromRGBO(00, 00, 00, 0.7),
            child: StreamBuilder<List<FileSystemEntity>>(
              stream: _block.imagesStream,
              builder: (ctx, snapshot) {
                print('snapshot - ${snapshot.data}');
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      iconSize: 30,
                      color: Colors.white,
                      icon: Icon(Icons.close),
                      onPressed: () async {
                        _block.clearImages();
                        Navigator.of(context).pop();
                      },
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 65,
                      child: Stack(
                        alignment: FractionalOffset.center,
                        children: <Widget>[
                          IconButton(
                            iconSize: 65,
                            icon: Image.asset(
                              image(CustomImages.camera_button),
                            ),
                            onPressed: widget._controller.value.isTakingPicture
                                ? null
                                : () {
                                    _captureImage();
                                  },
                          ),

                          /// displaying the circular progress while taking pictures
                          widget._controller.value.isTakingPicture
                              ? CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    ((snapshot.data == null) || (snapshot.data.length == 0))
                        ? Container(
                            height: 45,
                            width: 45,
                            child: IconButton(
                              icon: Image.asset(
                                image(CustomImages.library_button),
                              ),
                              onPressed: () {
                                // open library screen
                              },
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                PreviewScreen.routeName,
                                arguments: snapshot.data,
                              );
                            },
                            child: Stack(
                              alignment: FractionalOffset.topRight,
                              children: <Widget>[
                                Container(
                                  width: 45,
                                  height: 45,
                                  child: Image.file(
                                    snapshot.data[0],
                                    fit: BoxFit.scaleDown,
                                    width: 145,
                                    height: 45,
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor:
                                      Theme.of(context).backgroundColor,
                                  child: Text('${snapshot.data.length}'),
                                ),
                              ],
                            ),
                          )
                  ],
                );
              },
            ),
          ),
        ),

        /// top bar with buttons
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: double.infinity,
            height: 120.0,
            color: Color.fromRGBO(00, 00, 00, 0.7),
            child: FutureBuilder(
              future: Lamp.hasLamp,
              builder: (ctx, snapshot) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TopButton(
                      buttonImage: CustomImages.multipage_button,
                      title: 'Multipage',
                      isEnabled: widget.multipage,
                      action: (value) {
                        widget.multipage = value;
                        print('Multipage pressed - $value');
                      },
                    ),
                    TopButton(
                      buttonImage: CustomImages.automatic_button,
                      title: 'Automatic',
                      isEnabled: widget.autocapture,
                      action: (value) {
                        widget.autocapture = value;
                        print('Automatic pressed - $value');
                      },
                    ),
                    TopButton(
                      buttonImage: CustomImages.light_button,
                      title: 'Light',
                      isEnabled: widget.isLightOn,
                      action: snapshot.data == false
                          ? null
                          : (value) {
                              widget.isLightOn = value;
                              if (value == true) {
                                Lamp.turnOff();
                              } else {
                                Lamp.turnOn();
                              }
                              print('Light pressed');
                            },
                    ),
                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
