import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/bloc_provider.dart';
import 'package:flutter_app/contact_list/contact_repo.dart';
import 'package:flutter_app/dashboard.dart';
import 'package:flutter_app/drawer_bloc.dart';
import 'package:flutter_app/utility/constants.dart';

void main() {
  Timer.periodic(const Duration(seconds: 10), (Timer timer) {
    print('triggered');
  });
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactRepo>(
        bloc: ContactRepo(),
        child: BlocProvider<DrawerBloc>(
            bloc: DrawerBloc(),
            child: MaterialApp(
              title: 'Mercury Sample',
              theme: ThemeData(
                primarySwatch: Colors.pink,
              ),
              initialRoute: Constants.HOME_ROUTE,
              routes: <String, WidgetBuilder>{
                Constants.HOME_ROUTE: (BuildContext context) =>
                    DashboardScreen(),
                /* Constants.REGISTER_USER_ROUTE: (BuildContext context) =>
                    RegisterUser(),*/
                /* Constants.SAVE_PDF_ROUTE: (BuildContext context) =>
                    SaveDataScreen(),*/
                /* Constants.CONTACT_LIST_ROUTE: (BuildContext context) =>
                    ContactListScreen(),*/
              },
            )));
  }
}
/*
void main() {

  runApp(RegisterUser());
  /*
  runApp(MaterialApp(
    title: 'My app', // used by the OS task switcher
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(),
            TextField(),
            TextField(),
            CircleAvatar(
              backgroundImage: AssetImage("images/mani_pic.png"),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5.0),
              color: Colors.red,
              child: SizedBox(
                width: double.infinity,
                child: FlatButton(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ));

   */
}
*/
