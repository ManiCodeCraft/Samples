import 'package:flutter/material.dart';
import 'package:flutter_app/utility/constants.dart';
import 'package:flutter_app/save_pdf/save_data_repo.dart';
import 'package:flutter_app/utility/strings.dart';
import 'package:flutter_app/user.dart';

class DashboardScreen extends StatelessWidget {
  final repo = SaveDataRepo();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text(Strings.REGISTER_USER),
              onPressed: () {
                Navigator.pushNamed(context, Constants.REGISTER_USER_ROUTE);
              },
            ),
            RaisedButton(
              child: Text(Strings.SAVE_PDF),
              onPressed: () async {
                await repo.insertToDb(User(4,"Priya",23));
                Navigator.pushNamed(context, Constants.SAVE_PDF_ROUTE);
              },
            )
          ],
        ),
      ),
    );
  }
}
