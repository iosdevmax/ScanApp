import 'dart:io';
import 'package:bitmap/bitmap.dart';
import 'package:bitmap/transformations.dart' as bmp;

import 'package:flutter/material.dart';
import 'package:image/image.dart' as encode;
import 'package:scan_app/screens/filter_screen/filter_bottom_menu.dart';
import 'package:scan_app/support_files/constants.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter-screen';

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final double menuHeight = 160;
  File newImage;
  double _brightness = 0;
  double _contrast = 1;

  ColorFilter _colorFilter =
      ColorFilter.mode(Colors.transparent, BlendMode.multiply);

  static const ColorFilter blackWhite = ColorFilter.matrix(
    <double>[
      1,1,1,0,-50,
      1,1,1,0,-50,
      1,1,1,0,-50,
      1,0,0,1,0,
    ],
  );

  static const ColorFilter colored = ColorFilter.matrix(
    <double>[
      1.438,-0.062,-0.062,0,1,
      -0.122,1.378,-0.122,0,1,
      -0.016,-0.016,1.483,0,1,
      0,0,0,1,0
    ],
  );

  void _updateColorFilterWith(ColorFilterType colorFilterType) {
    ColorFilter colorFilter;
    switch (colorFilterType) {
      case ColorFilterType.color:
        colorFilter = ColorFilter.mode(Colors.red, BlendMode.saturation);
        break;
      case ColorFilterType.blackwhite:
        colorFilter = blackWhite;
        break;
      case ColorFilterType.greyscale:
        colorFilter = ColorFilter.mode(Colors.grey, BlendMode.saturation);
        break;
      case ColorFilterType.none:
        colorFilter = ColorFilter.mode(Colors.transparent, BlendMode.multiply);
        break;
    }

    setState(() {
      _colorFilter = colorFilter;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _selectedImage = ModalRoute.of(context).settings.arguments as File;

    Future<Image> getImage(File image) async {
      var imageHeight = MediaQuery.of(context).size.height - menuHeight - 96;

      Bitmap bitmap = await Bitmap.fromProvider(FileImage(image));
      Bitmap brightBitmap = bmp.brightness(bitmap, _brightness);
      Bitmap nowThisBitmapLooksWeird = bmp.contrast(brightBitmap, _contrast);
      Bitmap finalBitmap =
          bmp.adjustColor(nowThisBitmapLooksWeird, saturation: 1.0);

      var headedBitmap = finalBitmap.buildHeaded();
      var finalImage = Image.memory(headedBitmap, height: imageHeight);

      return finalImage;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
        backgroundColor: Theme.of(context).backgroundColor,
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
              Navigator.pop(context, this.newImage);
            },
          ),
        ],
        leading: GestureDetector(
          child: Icon(Icons.close),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ColorFiltered(
                colorFilter: _colorFilter,
                child: FutureBuilder<Image>(
                  future: getImage(_selectedImage),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return snapshot.data;
                    } else {
                      return Container(
                        height: MediaQuery.of(context).size.height -
                            menuHeight -
                            96,
                        width: double.infinity,
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            FilterBottomMenu(
              height: menuHeight,
              colorFilterCallback: (value) {
                _updateColorFilterWith(value);
              },
              sliderCallback: (type, value) {
                if (type == SliderType.brightness) {
                  setState(() {
                    _brightness = value;
                  });
                } else if (type == SliderType.contrast) {
                  setState(() {
                    _contrast = value;
                  });
                }
                // print('$type = $value');
              },
            )
          ],
        ),
      ),
    );
  }
}
