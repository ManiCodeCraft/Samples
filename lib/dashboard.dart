import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/save_pdf/save_data_repo.dart';
import 'package:flutter_app/user.dart';
import 'package:flutter_app/utility/constants.dart';
import 'package:flutter_app/utility/strings.dart';

class DashboardScreen extends StatelessWidget {
  final SaveDataRepo repo = SaveDataRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.DASHBOARD),
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
                final List<PolicyIdCard> idList =
                    await repo.getDbData('0401-27-2001-67006');
                if (idList.isNotEmpty) {
                  Navigator.pushNamed(context, Constants.SAVE_PDF_ROUTE,
                      arguments: idList.first);
                } else {
                  if (await _showAlert(context)) {
                    await _insertToDb(context);
                  }
                }
              },
            ),
            RaisedButton(
              child: Text(Strings.CONTACTS),
              onPressed: () {
                Navigator.pushNamed(context, Constants.CONTACT_LIST_ROUTE);
              },
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _showAlert(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ID card is not dowloaded yet'),
            content: const Text('Would you like to download ?'),
            actions: <Widget>[
              FlatButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              FlatButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              )
            ],
          );
        });
  }

  Future<void> _insertToDb(BuildContext context) async {
    final ByteData image = await rootBundle.load('images/logo.jpg');
    final String imageString = base64Encode(image.buffer.asUint8List());
    // print(imageString);
    final PolicyIdCard idCard = PolicyIdCard(
        '0401-27-2001-67006',
        'COROLLA',
        'TOYOTA',
        2009,
        'REYNA REYNOSA',
        '5700 Cowles Mountain Blvd #E141\nLa Mesa CA 91942',
        '08/07/2019',
        '02/07/2020',
        'JTDBL40EX9J022713',
        'NAIC #38342',
        imageString);
    await repo.insertToDb(idCard);
    Navigator.pushNamed(context, Constants.SAVE_PDF_ROUTE, arguments: idCard);
  }
}
