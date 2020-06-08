import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:scan_app/bloc/bloc_provider.dart';
import 'package:scan_app/bloc/captured_image_bloc.dart';

import '../../screens/camera_screen/camera_widget.dart';

class CameraScreen extends StatefulWidget {
  static const routeName = '/camera_screen';

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  bool isCameraReady = false;

  // bool showCapturedPhoto = false;
  // var ImagePath;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (_controller != null) {
        _initializeControllerFuture = _controller.initialize();
      }
    }
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(firstCamera, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      isCameraReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraWidget(_controller);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            ); // Otherwise, display a loading indicator.
          }
        },
      ),
    );
  }
}
