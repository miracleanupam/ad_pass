import 'package:ad_pass/models/passwordItem.dart';
import 'package:ad_pass/services/dbServices.dart';
import 'package:flutter/material.dart';

class EditPassword extends StatefulWidget {
  final Password toEdit;

  EditPassword({this.toEdit});
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  bool showPassword = false;
  bool submitted = false;

  toggleShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  void initState() {
    super.initState();
    populateFields();
  }

  populateFields() {
    _titleController.text = widget.toEdit.title;
    _passwordController.text = widget.toEdit.passwd;
    _usernameController.text = widget.toEdit.username;
    _notesController.text = widget.toEdit.notes;
  }

  handleSubmit() {
    setState(() {
      submitted = true;
    });
    if (_formKey.currentState.validate()) {
      Password passwd = Password(
          id: widget.toEdit.id,
          title: _titleController.text,
          username: _usernameController.text,
          passwd: _passwordController.text,
          notes: _notesController.text);

      DbServices.instance.update(passwd.toMap());
      Navigator.pop(context, passwd);
    } else {
      setState(() {
        submitted = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Title cannot be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Title', labelText: 'Title'),
                        controller: _titleController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.none,
                        autocorrect: false,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Username cannot be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Username', labelText: 'Username'),
                        controller: _usernameController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                          suffixIcon: IconButton(
                              icon: Icon(
                                showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color(0xff003d33),
                              ),
                              onPressed: () => toggleShowPassword()),
                        ),
                        obscureText: !showPassword,
                        controller: _passwordController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Notes', labelText: 'Notes'),
                        controller: _notesController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                      SizedBox(height: 10),
                      RaisedButton(
                        onPressed: () => handleSubmit(),
                        child: Text('Submit'),
                      )
                    ])),
          ),
        ),
      ),
    );
  }
}
