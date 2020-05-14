import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class SaveDataRepo {
  Future<File> getFile() async {
    final path = (await getApplicationDocumentsDirectory()).path;
    return File("$path/file.pdf");
  }

  Future<File> saveFile() async {
    var file = await getFile();
    var dataBytes = await rootBundle.load('assets/sample.pdf');
    // var list=dataBytes.buffer.asUint8List();
    var s = await rootBundle.load('assets/code.txt');
    print(s);
    await file.writeAsBytes(s.buffer.asUint8List(), flush: true);
    return file;
  }

  Future<String> getFileContent() async {
    var dataByte = await rootBundle.load('assets/sample.pdf');
    return String.fromCharCodes(dataByte.buffer.asUint8List());
  }

  Future<String> readFile() async {
    try {
      var file = await getFile();
      Uint8List contents = await file.readAsBytes();
      return String.fromCharCodes(contents);
    } catch (e) {
      return e.toString();
    }
  }
}
