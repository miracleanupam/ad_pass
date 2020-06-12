import 'package:ad_pass/models/debouncer.dart';
import 'package:ad_pass/models/passwordItem.dart';
import 'package:ad_pass/screens/addPassword.dart';
import 'package:ad_pass/screens/drawer.dart';
import 'package:ad_pass/screens/passListItem.dart';
import 'package:ad_pass/services/dbServices.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'editPasswordScreen.dart';

class DashboardScreen extends StatefulWidget {
  final String savedPassword;

  DashboardScreen({this.savedPassword});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Password> passList;
  List<Password> filteredPassList;
  bool isLoading = true;
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    queryAllPasswords();
  }

  Future<void> handleRefresh() async {
    queryAllPasswords();
  }

  queryAllPasswords() {
    DbServices.instance.queryAll().then((value) {
      setState(() {
        passList = value.map((e) => Password.fromMap(e)).toList();
        filteredPassList = passList;
        isLoading = false;
      });
    });
  }

  handleAddAction() async {
    var newPasswd = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddPassword()));
    if (newPasswd != null) {
      Fluttertoast.showToast(
          msg: 'Added',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 16.0);
      setState(() {
        passList.add(newPasswd);
        filteredPassList = passList;
      });
    }
  }

  handleDelete(int id) async {
    DbServices.instance.delete(id).then((value) {
      Fluttertoast.showToast(
          msg: 'Deleted',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 16.0);
    });
    setState(() {
      passList.removeWhere((element) => element.id == id);
      filteredPassList.removeWhere((element) => element.id == id);
    });
  }

  handleEdit(int id) async {
    int indexToEdit = passList.indexWhere((element) => element.id == id);
    var passwdToEdit = passList[indexToEdit];

    var updatedPasswd = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditPassword(toEdit: passwdToEdit)));

    if (updatedPasswd != null) {
      Fluttertoast.showToast(
          msg: 'Updated',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 16.0);
      setState(() {
        passList[indexToEdit].title = updatedPasswd.title;
        passList[indexToEdit].username = updatedPasswd.username;
        passList[indexToEdit].passwd = updatedPasswd.passwd;
        passList[indexToEdit].notes = updatedPasswd.notes;
        filteredPassList = passList;
      });
    }
  }

  handleSearch(String searchTerm) {
    _debouncer.run(() {
      String lowerSearchTerm = searchTerm.toLowerCase();
      setState(() {
        filteredPassList = passList
            .where((e) =>
                e.title.toLowerCase().contains(lowerSearchTerm) ||
                e.username.toLowerCase().contains(lowerSearchTerm) ||
                e.notes.toLowerCase().contains(lowerSearchTerm))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADPass'),
      ),
      drawer: ADrawer(
        currentPassword: widget.savedPassword,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => handleRefresh(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Search!!!'),
                      onChanged: handleSearch,
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return PassListItem(
                              passItem: filteredPassList[index],
                              fn: handleDelete,
                              fnn: handleEdit);
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(height: 10),
                        itemCount: filteredPassList.length),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => handleAddAction(),
        child: Icon(Icons.add),
      ),
    );
  }
}
