import 'package:encrypt/encrypt.dart';

class EncrypterUtility {
  static final key = Key.fromUtf8("This is my sample key for encryn");
  static final iv = IV.fromLength(16);
  static final encrypter = Encrypter(AES(key));

  static Encrypted encrypt(String data) {
    return encrypter.encrypt(data, iv: iv);
  }

  static String decrypt(Encrypted data) {
    return encrypter.decrypt(data, iv: iv);
  }
}