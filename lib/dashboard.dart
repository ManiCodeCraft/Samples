import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/save_pdf/save_data_repo.dart';
import 'package:flutter_app/strings.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DashboardScreen extends StatelessWidget {
  var repo = SaveDataRepo();
  var storage = FlutterSecureStorage();

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
                await storage.deleteAll();
                var data = await repo.getFileContent();
                await storage.write(key: "file", value: data);
                Navigator.pushNamed(context, Constants.SAVE_PDF_ROUTE,arguments: storage);
              },
            )
          ],
        ),
      ),
    );
  }
}
