import 'package:ad_pass/models/passwordItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PassListItem extends StatefulWidget {
  final Password passItem;
  final Function fn;
  final Function fnn;

  PassListItem({this.passItem, this.fn, this.fnn});

  @override
  _PassListItemState createState() => _PassListItemState();
}

class _PassListItemState extends State<PassListItem> {
  bool showPassword = false;

  toggleShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  alertBeforeDelete(BuildContext context) {
    Widget cancelButton = RaisedButton(
      child: Text("Cancel"),
      elevation: 6.0,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget deleteButton = RaisedButton(
      child: Text("Delete"),
      elevation: 6.0,
      onPressed: () {
        Navigator.of(context).pop();
        widget.fn(widget.passItem.id);
      },
    );
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 10.0,
      backgroundColor: Color(0xff003d33),
      titleTextStyle: TextStyle(fontSize: 16.0),
      title: Text("Attention!"),
      contentTextStyle: TextStyle(fontSize: 16.0),
      content: Text("This action cannot be undone. Delete?"),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  copyPasswordToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.passItem.passwd));
    Fluttertoast.showToast(
        msg: 'Copied to Clipboard',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(0xff003d33),
        border: Border.all(
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: ExpansionTile(
        key: PageStorageKey<Password>(widget.passItem),
        title: Text(widget.passItem.title),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // SizedBox(height: 2),
              Divider(
                thickness: 1,
                color: Colors.tealAccent[100],
              ),
              Text(
                'Username',
                style: TextStyle(fontSize: 12.0, color: Colors.tealAccent[100]),
              ),
              Text(
                widget.passItem.username,
                style: TextStyle(fontSize: 20.0),
              ),
              // SizedBox(height: 20),
              Divider(
                thickness: 1,
                color: Colors.tealAccent[100],
              ),
              Text(
                'Password',
                style: TextStyle(fontSize: 12.0, color: Colors.tealAccent[100]),
              ),
              Row(children: [
                showPassword
                    ? Expanded(
                        child: Text(
                        widget.passItem.passwd,
                        style: TextStyle(fontSize: 20.0),
                      ))
                    : Expanded(
                        child: Text(
                        '*' * widget.passItem.passwd.length,
                        style: TextStyle(fontSize: 20.0),
                      )),
                // Spacer(),
                IconButton(
                    icon: Icon(
                        showPassword ? Icons.visibility_off : Icons.visibility,
                        size: 20.0,
                        color: Colors.tealAccent[700]),
                    onPressed: () => toggleShowPassword()),
                IconButton(
                    icon: Icon(
                      Icons.content_copy,
                      size: 20.0,
                      color: Colors.tealAccent[700],
                    ),
                    onPressed: () => copyPasswordToClipboard()),
              ]),
              Divider(
                thickness: 1,
                color: Colors.tealAccent[100],
              ),
              // SizedBox(height: 10),
              Text(
                'Notes',
                style: TextStyle(fontSize: 12.0, color: Colors.tealAccent[100]),
              ),
              Text(
                widget.passItem.notes,
                style: TextStyle(fontSize: 20.0),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Divider(
                thickness: 1,
                color: Colors.tealAccent[100],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Expanded(
                    child: SizedBox(
                        height: 50,
                        child: FlatButton.icon(
                          onPressed: () {
                            widget.fnn(widget.passItem.id);
                          },
                          icon: Icon(Icons.edit),
                          textColor: Colors.blue,
                          label: Text('Edit'),
                        ))),
                Expanded(
                    child: SizedBox(
                        height: 50,
                        child: FlatButton.icon(
                          onPressed: () {
                            // widget.fn(widget.passItem.id);
                            alertBeforeDelete(context);
                          },
                          icon: Icon(Icons.delete_forever),
                          textColor: Colors.red,
                          label: Text('Delete'),
                        ))),
              ])
            ]),
          )
        ],
      ),
    );
  }
}
