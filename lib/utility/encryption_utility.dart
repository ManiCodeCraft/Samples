import 'package:encrypt/encrypt.dart';
import 'package:flutter_app/utility/constants.dart';

final Key key = Key.fromUtf8(Constants.ENCRYPTION_KEY);
final IV iv = IV.fromLength(16);
final Encrypter encrypter = Encrypter(AES(key));

Encrypted encrypt(String data) {
  return encrypter.encrypt(data, iv: iv);
}

String decrypt(Encrypted data) {
  return encrypter.decrypt(data, iv: iv);
}
