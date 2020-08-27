import 'package:flutter/material.dart';
import 'package:scan_app/support_files/constants.dart';

enum ColorFilterType { color, greyscale, blackwhite, none }

enum SliderType { brightness, contrast }

class FilterBottomMenu extends StatefulWidget {
  final double height;
  final Function colorFilterCallback;
  final Function sliderCallback;

  FilterBottomMenu(
      {this.height, this.colorFilterCallback, this.sliderCallback});

  @override
  _FilterBottomMenuState createState() => _FilterBottomMenuState();
}

class _FilterBottomMenuState extends State<FilterBottomMenu> {
  double _contrastValue = 1.0;
  double _brightnessValue = 0.0;

  RawMaterialButton _createColorFilterButton(ColorFilterType colorFilterType) {
    var name = '';

    switch (colorFilterType) {
      case ColorFilterType.color:
        name = image(CustomImages.color_filter);
        break;
      case ColorFilterType.greyscale:
        name = image(CustomImages.greyscale_filter);
        break;
      case ColorFilterType.blackwhite:
        name = image(CustomImages.black_white_filter);
        break;
      case ColorFilterType.none:
        name = image(CustomImages.cross);
        break;
      default:
        break;
    }

    return RawMaterialButton(
      onPressed: () {
        // need to reset sliders
        if (colorFilterType == ColorFilterType.none) {
          setState(() {
            _brightnessValue = 0.0;
            _contrastValue = 1.0;
          });
        }
        widget.colorFilterCallback(colorFilterType);
        widget.sliderCallback(SliderType.brightness, 0.0);
        widget.sliderCallback(SliderType.contrast, 1.0);
      },
      elevation: 0.0,
      fillColor: Colors.white,
      child: Image.asset(
        name,
        width: 30,
        height: 30,
      ),
      shape: CircleBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Theme.of(context).backgroundColor,
          width: 1.0,
        ),
      ),
      width: double.infinity,
      height: widget.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _createColorFilterButton(ColorFilterType.color),
              _createColorFilterButton(ColorFilterType.greyscale),
              _createColorFilterButton(ColorFilterType.blackwhite),
              _createColorFilterButton(ColorFilterType.none)
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.wb_sunny,
                          size: 20,
                          color: Colors.black87,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 3.0),
                          alignment: Alignment.center,
                          width: 60,
                          child: Text(
                            'Brightness',
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Colors.black87,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Slider(
                      activeColor: Theme.of(context).backgroundColor,
                      inactiveColor: Theme.of(context).dialogBackgroundColor,
                      min: -1.0,
                      max: 1.0,
                      value: _brightnessValue,
                      onChanged: (value) {
                        setState(() {
                          _brightnessValue = value;
                          widget.sliderCallback(SliderType.brightness, value);
                        });
                      },
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.brightness_medium,
                          size: 20,
                          color: Colors.black87,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 3.0),
                          alignment: Alignment.center,
                          width: 60,
                          child: Text(
                            'Contrast',
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Colors.black87,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Slider(
                      activeColor: Theme.of(context).backgroundColor,
                      inactiveColor: Theme.of(context).dialogBackgroundColor,
                      min: 0.0,
                      max: 2.0,
                      value: _contrastValue,
                      onChanged: (value) {
                        setState(() {
                          _contrastValue = value;
                        });
                      },
                      onChangeEnd: (value) {
                        widget.sliderCallback(SliderType.contrast, value);
                      },
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
