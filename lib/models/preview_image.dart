import 'dart:io';
import 'package:flutter/material.dart';

class PreviewImage {
  FileSystemEntity originalImage;
  Image croppedImage;
  Image filteredImage;
  ColorFilter colorFilter;
  double brightness = 0;
  double contrast = 0;

  PreviewImage(this.originalImage);

  Image getFinalImage() {
    if (croppedImage != null) {
      return croppedImage;
    }
    return Image.file(originalImage);
  }

} 