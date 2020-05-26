import 'dart:async';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_app/user.dart';
import 'package:flutter_app/utility/constants.dart';
import 'package:flutter_app/utility/encryption_utility.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SaveDataRepo {
  Future<Database> db;
  final StreamController<List<PolicyIdCard>> controller =
      StreamController<List<PolicyIdCard>>();

  Stream<List<PolicyIdCard>> get dbStream => controller.stream;

  Future<Database> openDb() async {
    if (db != null) {
      return db;
    }

    final String path = await getDatabasesPath();
    db = openDatabase(
      join(path, Constants.DB_NAME),
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE PolicyId ( policyNumber BLOB, model BLOB , makeCompany BLOB, year BLOB, name BLOB, address BLOB, effectiveDate BLOB, expirationDate BLOB, vehicleId BLOB, naicNumber BLOB, logoString BLOB)');
      },
      version: 2,
    );
    return db;
  }

  Future<void> insertToDb(PolicyIdCard user) async {
    final Database database = await openDb();
    print(user.toMap());
    await database.insert('PolicyId', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteFromDb() async {
    final Database database = await openDb();
    await database.delete('PolicyId');
  }

  Future<void> getDbData() async {
    final Database database = await openDb();
    final List<Map<String, dynamic>> data = await database.query('PolicyId');
    final List<PolicyIdCard> list =
        List<PolicyIdCard>.generate(data.length, (int index) {
      final Map<String, dynamic> entry = data[index];
      return PolicyIdCard(
          decrypt(Encrypted(entry['policyNumber'] as Uint8List)),
          decrypt(Encrypted(entry['model'] as Uint8List)),
          decrypt(Encrypted(entry['makeCompany'] as Uint8List)),
          int.parse(decrypt(Encrypted(entry['year'] as Uint8List))),
          decrypt(Encrypted(entry['name'] as Uint8List)),
          decrypt(Encrypted(entry['address'] as Uint8List)),
          decrypt(Encrypted(entry['effectiveDate'] as Uint8List)),
          decrypt(Encrypted(entry['expirationDate'] as Uint8List)),
          decrypt(Encrypted(entry['vehicleId'] as Uint8List)),
          decrypt(Encrypted(entry['naicNumber'] as Uint8List)),
          decrypt(Encrypted(entry['logoString'] as Uint8List)));
    });
    controller.sink.add(list);
  }

  void dispose() {
    controller.close();
  }
}
