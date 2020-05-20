import 'dart:async';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_app/user.dart';
import 'package:flutter_app/utility/encryption_utility.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SaveDataRepo {

  Future<Database> db;
  final controller = StreamController<List<User>>();

  Stream get dbStream => controller.stream;

  Future<Database> openDb() async {
    if (db != null) return db;

    var path = await getDatabasesPath();

    db = openDatabase(
      join(path, "my db"),
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE User ( id BLOB, name BLOB , age BLOB)");
      },
      version: 1,
    );
    return db;
  }

  Future<void> insertToDb(User user) async {
    var database = await openDb();
    print(user.toMap());
    await database.insert('User', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  void deleteFromDb() async {
    var database = await openDb();
    await database.delete('User');
  }

  void getDbData() async {
    var database = await openDb();
    var data = await database.query('User');

    var list = List.generate(data.length, (index) {
      var entry = data[index];
      return User(
          int.parse(EncrypterUtility.decrypt(Encrypted(entry['id']))),
          EncrypterUtility.decrypt(Encrypted(entry['name'])),
          int.parse(EncrypterUtility.decrypt(Encrypted(entry['age']))));
    });
    controller.sink.add(list);
  }

  void dispose() {
    controller.close();
  }
}
