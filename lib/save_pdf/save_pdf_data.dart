import 'package:flutter/material.dart';
import 'package:flutter_app/save_pdf/save_data_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SaveDataScreen extends StatefulWidget {
  @override
  _SaveDataState createState() => _SaveDataState();
}

class _SaveDataState extends State<SaveDataScreen> {
  var repo = SaveDataRepo();
  Future<String> fileContent;
  FlutterSecureStorage args;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    fileContent=repo.readFile();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    fileContent = args.read(key: "file");
    return Scaffold(
      appBar: AppBar(
        title: Text("File Data"),
      ),
      body: Container(
        child: FutureBuilder<String>(
          future: fileContent,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
