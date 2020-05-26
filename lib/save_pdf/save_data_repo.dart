import 'dart:async';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_app/user.dart';
import 'package:flutter_app/utility/encryption_utility.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SaveDataRepo {
  Future<Database> db;
  final controller = StreamController<List<PolicyIdCard>>();

  Stream get dbStream => controller.stream;

  Future<Database> openDb() async {
    if (db != null) return db;

    var path = await getDatabasesPath();

    db = openDatabase(
      join(path, "my_db"),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE PolicyId ( policyNumber BLOB, model BLOB , makeCompany BLOB, year BLOB, name BLOB, address BLOB, effectiveDate BLOB, expirationDate BLOB, vehicleId BLOB, naicNumber BLOB, logoString BLOB)");
      },
      version: 2,
    );
    return db;
  }

  Future<void> insertToDb(PolicyIdCard user) async {
    var database = await openDb();
    print(user.toMap());
    await database.insert('PolicyId', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  void deleteFromDb() async {
    var database = await openDb();
    await database.delete('PolicyId');
  }

  void getDbData() async {
    var database = await openDb();
    var data = await database.query('PolicyId');
    var list = List.generate(data.length, (index) {
      var entry = data[index];
      return PolicyIdCard(
          EncrypterUtility.decrypt(Encrypted(entry['policyNumber'])),
          EncrypterUtility.decrypt(Encrypted(entry['model'])),
          EncrypterUtility.decrypt(Encrypted(entry['makeCompany'])),
          int.parse(EncrypterUtility.decrypt(Encrypted(entry['year']))),
          EncrypterUtility.decrypt(Encrypted(entry['name'])),
          EncrypterUtility.decrypt(Encrypted(entry['address'])),
          EncrypterUtility.decrypt(Encrypted(entry['effectiveDate'])),
          EncrypterUtility.decrypt(Encrypted(entry['expirationDate'])),
          EncrypterUtility.decrypt(Encrypted(entry['vehicleId'])),
          EncrypterUtility.decrypt(Encrypted(entry['naicNumber'])),
          EncrypterUtility.decrypt(Encrypted(entry['logoString'])));
    });
    controller.sink.add(list);
  }

  void dispose() {
    controller.close();
  }
}
