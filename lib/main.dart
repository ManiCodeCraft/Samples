import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_app/HomeScreen.dart';
import 'package:flutter_app/register_user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register user',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: RegisterUser(),
    );
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