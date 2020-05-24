import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shruticontactapp/bloc/bloc_provider.dart';
import 'package:shruticontactapp/bloc/contact_bloc.dart';
import 'package:shruticontactapp/screens/add_new_contact_screen.dart';
import 'package:shruticontactapp/screens/contact_list_screen.dart';
import 'package:shruticontactapp/screens/favorite_contact_screen.dart';
import 'package:shruticontactapp/screens/update_contact_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  PermissionStatus _permissionStatus = PermissionStatus.undetermined;

  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();
    setState(() {
      print(status);
      _permissionStatus = status;
      print(_permissionStatus);
    });
  }

  @override
  void initState() {
    super.initState();
    requestPermission(Permission.contacts);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: ContactBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: _permissionStatus.isGranted
            ? ContactListScreen()
            : Scaffold(
                appBar: AppBar(
                  title: Text('Contact List'),
                ),
                body: Center(
                    child: Text(
                  "No permission granted",
                )),
              ),
        routes: {
          FavoriteContactScreen.routeName: (ctx) => FavoriteContactScreen(),
          UpdateContactScreen.routeName: (ctx) => UpdateContactScreen(),
          AddNewContactScreen.routeName: (ctx) => AddNewContactScreen(),
        },
      ),
    );
  }
}
