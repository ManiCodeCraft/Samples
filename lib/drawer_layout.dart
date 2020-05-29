import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/save_pdf/save_data_repo.dart';
import 'package:flutter_app/user.dart';
import 'package:flutter_app/utility/constants.dart';
import 'package:flutter_app/utility/strings.dart';

import 'bloc_provider.dart';
import 'drawer_bloc.dart';

typedef DrawerItemTap = void Function();

class DrawerLayout extends StatelessWidget {
  final SaveDataRepo repo = SaveDataRepo();

  @override
  Widget build(BuildContext context) {
    final DrawerBloc bloc = BlocProvider.of<DrawerBloc>(context);
    return Drawer(
      child: Column(
        children: <Widget>[
          _getHeader(),
          Container(
            height: 1,
            color: Colors.black12,
          ),
          _getDrawerItem(Icons.account_box, Strings.REGISTER_USER, () {
            Navigator.of(context).pop();
           bloc.updatePage(Strings.REGISTER_USER);
          }),
          _getDrawerItem(
            Icons.picture_as_pdf,
            Strings.SAVE_PDF,
            () async {
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
          _getDrawerItem(Icons.contacts, Strings.CONTACTS, () {
            Navigator.of(context).pop();
            bloc.updatePage(Strings.CONTACTS);
          }),
        ],
      ),
    );
  }

  Widget _getHeader() {
    return Row(
        // padding: const EdgeInsets.fromLTRB(0, 64, 0, 16),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 64, 0, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 48,
                  width: 48,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          'images/logo.jpg',
                        ),
                      )),
                ),
                /*Image.asset(
                  'images/mani_pic.png',
                  height: 48,
                  width: 48,
                ),*/
                const SizedBox(
                  height: 8,
                ),
                const Text('Mani Murugan'),
                const SizedBox(
                  height: 4,
                ),
                const Text('mani@codecraft.co.in')
              ],
            ),
          ),
        ]);
  }

  Widget _getDrawerItem(IconData icon, String title, DrawerItemTap onTap) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 0, 16),
        child: Row(
          children: <Widget>[
            Icon(icon),
            const SizedBox(
              width: 24,
            ),
            Text(title)
          ],
        ),
      ),
      onTap: onTap,
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
