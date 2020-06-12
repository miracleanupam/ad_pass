import 'dart:io';

import 'package:ad_pass/services/dbServices.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ExportScreen extends StatefulWidget {
  @override
  _ExportScreenState createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  String progress;

  @override
  void initState() {
    super.initState();
    startExport();
  }

  convertToString(val) {
    return '''"${val['id']}","${val['title']}","${val['username']}","${val['password']}","${val['notes']}"''';
  }

  startExport() async {
    if (await Permission.storage.request().isGranted) {
      String dirLoc = '/sdcard/download/adpass/';
      try {
        FileUtils.mkdir([dirLoc]);
        setState(() {
          progress = 'started';
        });
        DbServices.instance.queryAll().then((value) async {
          List strVals = value.map((e) => convertToString(e)).toList();
          String strToExport = strVals.join('''\r\n''');
          File file = File('$dirLoc/export.csv');
          File result = await file.writeAsString('$strToExport');
          setState(() {
            progress = 'complete';
          });
        });
      } catch (e) {}
    } else {
      setState(() {
        progress = 'Permission Denied';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Export Data'),
      ),
      body: Center(
        child: progress == null
            ? CircularProgressIndicator()
            : progress == 'Permission Denied'
                ? Text('Permission Denied')
                : progress == 'started'
                    ? Column(children: [
                        CircularProgressIndicator(),
                        Text('Exporting! This might take a while...'),
                      ])
                    : Text('Export Complete'),
      ),
    );
  }
}
