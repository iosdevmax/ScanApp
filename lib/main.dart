import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scan_app/bloc/bloc_provider.dart';
import 'package:scan_app/bloc/captured_image_bloc.dart';
import 'package:scan_app/bloc/user_data_bloc.dart';
import 'package:scan_app/screens/crop_screen/crop_screen.dart';

import './screens/filter_screen/filter_screen.dart';
import './screens/preview_screen/preview_screen.dart';
import './screens/document_details_screen/document_details_screen.dart';
import './screens/folder_details_screen/folder_details_screen.dart';
import './screens/main_screen/main_screen.dart';
import './screens/camera_screen/camera_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserDataBloc>(
      bloc: UserDataBloc(),
      child: BlocProvider<CapturedImageBloc>(
        bloc: CapturedImageBloc(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            accentColor: Colors.white,
            backgroundColor: Color.fromRGBO(147, 0, 0, 1),
            dialogBackgroundColor: Color.fromRGBO(242, 242, 247, 0.96),
          ),
          home: MyHomePage(),
          routes: {
            CameraScreen.routeName: (ctx) => CameraScreen(),
            PreviewScreen.routeName: (ctx) => PreviewScreen(),
            FolderDetailsScreen.routeName: (ctx) => FolderDetailsScreen(),
            DocumentDetailsScreen.routeName: (ctx) => DocumentDetailsScreen(),
            MainScreen.routeName: (ctx) => MainScreen(),
            FilterScreen.routeName: (ctx) => FilterScreen(),
            CropScreen.routeName: (ctx) => CropScreen(),
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }
}
