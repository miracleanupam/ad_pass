import 'dart:io';

import 'package:ad_pass/models/passwordItem.dart';
import 'package:ad_pass/services/dbServices.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ImportScreen extends StatefulWidget {
  @override
  _ImportScreenState createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  String progress = 'initiated';

  beginImport() async {
    File file = await FilePicker.getFile(
        type: FileType.custom, allowedExtensions: ['csv', 'CSV']);

    setState(() {
      progress = 'started';
    });

    var strContent = await file.readAsString();
    List records = strContent.split("\r\n");
    List<Password> listOfPasswords = records.map((e) {
      List row = e.split(',');
      Password passwd = Password(
        title: row[1].substring(1, row[1].length - 1),
        username: row[2].substring(1, row[2].length - 1),
        passwd: row[3].substring(1, row[3].length - 1),
        notes: row[4].substring(1, row[4].length - 1),
      );
      return passwd;
    }).toList();

    DbServices.instance.truncate();

    for (var passw in listOfPasswords) {
      int res = await DbServices.instance.insert(passw.toMap());
    }

    setState(() {
      progress = 'complete';
    });
  }

  goToDashboard() {
    Navigator.pop(context);
    Fluttertoast.showToast(
        msg: 'Pull to Update...',
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Import from CSV'),
        ),
        body: Center(
            child: progress == 'initiated'
                ? Column(children: [
                    Icon(Icons.file_upload),
                    FlatButton(
                      child: Text('Choose File'),
                      onPressed: () => beginImport(),
                    ),
                  ])
                : progress == 'started'
                    ? Column(children: [
                        CircularProgressIndicator(),
                        Text('Importing ...')
                      ])
                    : Column(children: [
                        Text('Import Complete'),
                        FlatButton(
                          onPressed: () => goToDashboard(),
                          child: Text('Go to Dashboard'),
                        ),
                      ])));
  }
}
