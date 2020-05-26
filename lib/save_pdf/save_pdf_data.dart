import 'dart:convert';
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
//import 'package:printing/printing.dart';

class SaveDataScreen extends StatefulWidget {
  @override
  _SaveDataState createState() => _SaveDataState();
}

class _SaveDataState extends State<SaveDataScreen> {
  final repo = SaveDataRepo();
  Future<File> pdfFile;
  File logoImage;

  Future<File> constructFile(PolicyIdCard user) async {
    final doc = pw.Document();
    var data = await rootBundle.load("fonts/Roboto-Regular.ttf");
    String dir = (await getTemporaryDirectory()).path;
    logoImage = new File('$dir/tempImage.jpg');
    logoImage.writeAsBytesSync(base64Decode(user.logoString));
    final f = pw.Font.ttf(data);
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return buildPdf(context, user, doc.document, f);
        }));

    File temp = new File('$dir/temp1.pdf');
    print("doc done ${temp.path}");
    // Printing.printPdf(document: doc.document);
    var bytes = doc.save();
    print("bytes");
    final newFile = await temp.writeAsBytes(bytes);
    print("doc done1");
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
    pdfFile.then((value) {
      value.delete();
      logoImage.delete();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PolicyIdCard>>(
      stream: repo.dbStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          bool isDataPresent = _getPdFData(snapshot.data);
          if (isDataPresent) {
            // return Center(child: Image.memory(snapshot.data.first.logoString,width: 32,height: 32,),);
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
                          title: Text(Strings.SAVE_PDF),
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

  bool _getPdFData(List<PolicyIdCard> list) {
    if (list.length > 0) {
      pdfFile = constructFile(list.first);
      return true;
    } else {
      return false;
    }
  }

  pw.Widget buildPdf(
      pw.Context context, PolicyIdCard user, PdfDocument pdf, pw.Font font) {
    print(user.logoString);
    return pw.Container(
      child: pw.Column(children: <pw.Widget>[
        pw.Container(
          padding: pw.EdgeInsets.all(8.0),
          decoration: pw.BoxDecoration(
              border: pw.BoxBorder(
                  left: true,
                  top: true,
                  right: true,
                  bottom: true,
                  color: PdfColors.black)),
          child: pw.Column(
            children: <pw.Widget>[
              _getHeader(pdf, font, user),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Row(
                    children: <pw.Widget>[
                      pw.Flexible(
                        fit: pw.FlexFit.tight,
                        flex: 1,
                        child: _getPolicyDataLayout(
                            "POLICY NUMBER", user.policyNumber, font),
                      ),
                      pw.Flexible(
                        fit: pw.FlexFit.tight,
                        flex: 1,
                        child: _getPolicyDataLayout(
                            "EFFECTIVE / EXPIRATION DATES",
                            "${user.effectiveDate}  ${user.expirationDate}",
                            font),
                      ),
                    ],
                  ),
                  pw.Row(
                    children: <pw.Widget>[
                      pw.Flexible(
                        fit: pw.FlexFit.tight,
                        flex: 1,
                        child: _getPolicyDataLayout(
                            "YEAR/MAKE/MODEL",
                            "${user.year.toString()} ${user.makeCompany} ${user.model}",
                            font),
                      ),
                      pw.Flexible(
                        fit: pw.FlexFit.tight,
                        flex: 1,
                        child: _getPolicyDataLayout(
                            "VEHICLE IDENTIFICATION NUMBER",
                            user.vehicleId,
                            font),
                      ),
                    ],
                  ),
                  _getPolicyDataLayout(
                      "NAMED INSURANCE", "${user.name}\n${user.address}", font)
                ],
              ),
              pw.SizedBox(
                height: 48.0,
              ),
              pw.Text(
                "TO REPORT A CLAIM, please call (800) 503-3724.",
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                    /*font: font,*/
                    fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                "For access to ROADSIDE ASSISTANCE ONLY, please call (866) 519-6478.",
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                    /*font: font,*/
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(
                height: 8.0,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: <pw.Widget>[
                  pw.Text(
                    user.naicNumber,
                    style: pw.TextStyle(
                        /*font: font,*/
                        fontSize: 10),
                  )
                ],
              )
            ],
          ),
        ),
        pw.SizedBox(
          height: 4.0,
        ),
        pw.Text(
          "This inssurance complies with CVC \$16056 or \$16500.5.\nThis image may not meet law enforcement requirements for proof of insurance",
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
              /*font: font,*/
              fontSize: 10.0),
        ),
      ]),
    );
  }

  pw.Widget _getHeader(PdfDocument pdf, pw.Font font, PolicyIdCard user) {
    return pw.Row(
      children: <pw.Widget>[
        pw.Image(PdfImage.file(pdf, bytes: logoImage.readAsBytesSync()),
            width: 32, height: 32),
        pw.SizedBox(
          width: 4,
        ),
        pw.Column(
          children: <pw.Widget>[
            pw.Text(
              "MERCURY",
              style: pw.TextStyle(
                  /*font: font,*/
                  fontSize: 16.0,
                  fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(
              "INSURANCE",
              style: pw.TextStyle(
                  /*font: font,*/
                  fontSize: 14.0,
                  fontWeight: pw.FontWeight.bold),
            ),
          ],
        ),
        pw.Expanded(
          child: pw.Column(
            children: <pw.Widget>[
              pw.Text(
                "CALIFORNIA EVIDENCE OF INSURED ID CARD",
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                    /*font: font,*/
                    fontSize: 11.0,
                    fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                "CALIFORNIA AUTOMOBILE ISURANCE COMPANY",
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                    /*font: font,*/
                    fontSize: 13.0,
                    fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                "AGENCY . True Pro Insurance Center Inc. 619-820-0036",
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(/*font: font,*/ fontSize: 10),
              )
            ],
          ),
        )
      ],
    );
  }

  pw.Widget _getPolicyDataLayout(String header, String value, pw.Font font) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: <pw.Widget>[
        pw.SizedBox(
          height: 16.0,
        ),
        pw.Text(
          header,
          style: pw.TextStyle(
              /*font: font,*/
              fontSize: 12,
              fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          value,
          style: pw.TextStyle(
            /*font: font,*/
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
