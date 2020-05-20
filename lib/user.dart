
import 'package:flutter_app/utility/encryption_utility.dart';

class User {
  final int id;
  final String name;
  final int age;

  User(this.id, this.name, this.age);

  Map<String, dynamic> toMap() {
    return {
      'id': EncrypterUtility.encrypt(this.id.toString()).bytes,
      'name': EncrypterUtility.encrypt(this.name).bytes,
      'age': EncrypterUtility.encrypt(this.age.toString()).bytes,
    };
  }
}
