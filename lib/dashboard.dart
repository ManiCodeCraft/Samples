import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/save_pdf/save_data_repo.dart';
import 'package:flutter_app/user.dart';
import 'package:flutter_app/utility/constants.dart';
import 'package:flutter_app/utility/strings.dart';

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
                var image = await rootBundle.load("images/logo.jpg");
                String imageString = base64Encode(image.buffer.asUint8List());
                print(imageString);
                await repo.insertToDb(PolicyIdCard(
                    "0401-27-2001-67006",
                    "COROLLA",
                    "TOYOTA",
                    2009,
                    "REYNA REYNOSA",
                    "5700 Cowles Mountain Blvd #E141\nLa Mesa CA 91942",
                    "08/07/2019",
                    "02/07/2020",
                    "JTDBL40EX9J022713",
                    "NAIC #38342",
                    imageString));
                Navigator.pushNamed(context, Constants.SAVE_PDF_ROUTE);
              },
            )
          ],
        ),
      ),
    );
  }
}
