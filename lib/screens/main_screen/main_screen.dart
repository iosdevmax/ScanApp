import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scan_app/bloc/bloc_provider.dart';
import 'package:scan_app/bloc/user_data_bloc.dart';

import '../main_screen/table_data_source.dart';
import '../../support_files/helper.dart';
import '../../core_widgets/table_view_widget.dart';
import '../../models/user_data.dart';
import '../main_screen/search_bar.dart';
import '../camera_screen/camera_screen.dart';
import '../main_screen/main_screen_popup.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main_screen';

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserDataBloc>(context).getDocuments();

    return StreamBuilder<UserData>(
        stream: BlocProvider.of<UserDataBloc>(context).userDataStream,
        builder: (context, snapshot) {
          return Scaffold(
            drawer: Drawer(),
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              actions: <Widget>[
                MainScreenPopupMenu(),
              ],
              title: Text('ScanApp'),
            ),
            body: (snapshot.data == null) || (snapshot.data.isEmpty)
                ? Center(
                    child: Text('No documents yet.'),
                  )
                : Column(
                    children: <Widget>[
                      SearchBar(),
                      TableViewWidget(
                        tableDataSource: TableDateSource(
                          docs: snapshot.data.docs,
                          folders: snapshot.data.folders,
                        ),
                      ),
                    ],
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            resizeToAvoidBottomPadding: false,
            floatingActionButton: FloatingActionButton(
              child: Icon(
                Icons.add,
              ),
              onPressed: () {
                Helper.presentScreenModally(CameraScreen(), context);
              },
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).backgroundColor,
            ),
          );
        });
  }
}
