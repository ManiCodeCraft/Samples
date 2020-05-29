import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/bloc_provider.dart';
import 'package:flutter_app/contact_list/contact_screen.dart';
import 'package:flutter_app/drawer_bloc.dart';
import 'package:flutter_app/drawer_layout.dart';
import 'package:flutter_app/registration/register_user.dart';
import 'package:flutter_app/save_pdf/save_data_repo.dart';
import 'package:flutter_app/save_pdf/save_pdf_data.dart';
import 'package:flutter_app/user.dart';
import 'package:flutter_app/utility/constants.dart';
import 'package:flutter_app/utility/strings.dart';

class DashboardScreen extends StatelessWidget {
  final SaveDataRepo repo = SaveDataRepo();

  @override
  Widget build(BuildContext context) {
    final DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: StreamBuilder<String>(
              stream: bloc.currentPageStream,
              initialData: 'Home',
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data) {
                    case Strings.REGISTER_USER:
                    case Strings.CONTACTS:
                      return Text(snapshot.data);
                      break;
                    default:
                      return Text(Strings.DASHBOARD);
                  }
                } else {
                  return Text(Strings.DASHBOARD);
                }
              }),
        ),
        /*drawer: Drawer(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text(Strings.REGISTER_USER),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, Constants.REGISTER_USER_ROUTE);
                  },
                ),
                RaisedButton(
                  child: Text(Strings.SAVE_PDF),
                  onPressed: () async {
                    Navigator.of(context).pop();
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
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, Constants.CONTACT_LIST_ROUTE);
                  },
                )
              ],
            ),
          ),
        ),*/
        drawer: DrawerLayout(),
        body: StreamBuilder<String>(
          stream: bloc.currentPageStream,
          initialData: 'Home',
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data) {
                case Strings.REGISTER_USER:
                  return RegisterUser();
                  break;
                case Strings.CONTACTS:
                  return ContactListScreen();
                  break;
                default:
                  return _getDefaultLayout();
              }
            } else {
              return _getDefaultLayout();
            }
          },
        ));
  }

  Widget _getDefaultLayout() {
    return const Center(
      child: Text('Home page'),
    );
  }

 /* Future<bool> _showAlert(BuildContext context) async {
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
  }*/
}
