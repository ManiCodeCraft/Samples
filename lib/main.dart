import 'package:flutter/material.dart';
import 'package:flutter_app/contact_list/contact_screen.dart';
import 'package:flutter_app/dashboard.dart';
import 'package:flutter_app/registration/register_user.dart';
import 'package:flutter_app/save_pdf/save_pdf_data.dart';
import 'package:flutter_app/utility/constants.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mercury Sample',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: Constants.HOME_ROUTE,
      routes: <String, WidgetBuilder>{
        Constants.HOME_ROUTE: (BuildContext context) => DashboardScreen(),
        Constants.REGISTER_USER_ROUTE: (BuildContext context) => RegisterUser(),
        Constants.SAVE_PDF_ROUTE: (BuildContext context) => SaveDataScreen(),
        Constants.CONTACT_LIST_ROUTE: (BuildContext context) => ContactList(),
      },
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
