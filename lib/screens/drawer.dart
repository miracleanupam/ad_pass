import 'package:ad_pass/screens/aboutScreen.dart';
import 'package:ad_pass/screens/changeAppPasswordScreen.dart';
import 'package:ad_pass/screens/exportScreen.dart';
import 'package:ad_pass/screens/importScreen.dart';
import 'package:flutter/material.dart';

class ADrawer extends StatelessWidget {
  final String currentPassword;

  ADrawer({this.currentPassword});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(child: Text('ADPass')),
            decoration: BoxDecoration(
              color: Color(0xff00695c),
            ),
          ),
          ListTile(
            title: Text('Change App Password'),
            trailing: Icon(
              Icons.change_history,
              color: Colors.tealAccent[700],
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangeAppPassword(
                            currentPassword: currentPassword,
                          )));
            },
          ),
          ListTile(
            title: Text('Export'),
            trailing: Icon(
              Icons.subdirectory_arrow_right,
              color: Colors.tealAccent[700],
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ExportScreen()));
            },
          ),
          ListTile(
            title: Text('Import'),
            trailing: Icon(
              Icons.subdirectory_arrow_left,
              color: Colors.tealAccent[700],
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ImportScreen()));
            },
          ),
          // ListTile(
          //   title: Text('Destroy Everything'),
          //   trailing: Icon(
          //     Icons.close,
          //     color: Colors.tealAccent[700],
          //   ),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
          ListTile(
            title: Text('About ADPass'),
            trailing: Icon(
              Icons.info_outline,
              color: Colors.tealAccent[700],
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutScreen()));
            },
          ),
        ],
      ),
    );
  }
}
