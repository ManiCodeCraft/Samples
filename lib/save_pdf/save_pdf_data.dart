import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/save_pdf/save_data_repo.dart';
import 'package:flutter_app/user.dart';
import 'package:flutter_app/utility/strings.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class SaveDataScreen extends StatefulWidget {
  @override
  _SaveDataState createState() => _SaveDataState();
}

class _SaveDataState extends State<SaveDataScreen> {
  final repo = SaveDataRepo();
  Future<File> pdfFile;

  Future<File> constructFile(User user) async {
    final doc = pw.Document();
    var data = await rootBundle.load("fonts/Roboto-Regular.ttf");
    final f = pw.Font.ttf(data);
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
              child: pw.Text(
                  "id : ${user.id}\nname : ${user.name}\nage : ${user.age}",
                  style: pw.TextStyle(font: f, fontSize: 40),
                  textAlign: pw.TextAlign.center));
        }));
    String dir = (await getTemporaryDirectory()).path;
    File temp = new File('$dir/temp.file');
    final newFile = await temp.writeAsBytes(doc.save());
    return newFile;
  }

  @override
  void initState() {
    super.initState();
    repo.getDbData();
  }

  @override
  void dispose() {
    repo.dispose();
    pdfFile.then((value) => value.delete());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<User>>(
      stream: repo.dbStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          bool isDataPresent = _getPdFData(snapshot.data);
          if (isDataPresent) {
            return FutureBuilder<File>(
                future: pdfFile,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return PDFViewerScaffold(
                      appBar: AppBar(
                        title: Text(Strings.FILE_DATA),
                      ),
                      path: snapshot.data.path,
                    );
                  } else {
                    return Scaffold(
                        appBar: AppBar(
                          title: Text(Strings.FILE_DATA),
                        ),
                        body: Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ));
                  }
                });
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: Text(Strings.FILE_DATA),
                ),
                body: Center(
                  child: Text(Strings.NO_DATA_PRESENT),
                ));
          }
        } else {
          return Scaffold(
              appBar: AppBar(
                title: Text(Strings.FILE_DATA),
              ),
              body: CircularProgressIndicator());
        }
      },
    );
  }

  bool _getPdFData(List<User> list) {
    if (list.length > 0) {
      pdfFile = constructFile(list.first);
      return true;
    } else {
      return false;
    }
  }
}
