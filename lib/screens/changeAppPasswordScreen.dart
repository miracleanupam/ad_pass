import 'package:ad_pass/screens/splashAndPasswordScreen.dart';
import 'package:ad_pass/services/secureServices.dart';
import 'package:flutter/material.dart';

class ChangeAppPassword extends StatefulWidget {
  final String currentPassword;

  ChangeAppPassword({this.currentPassword});

  @override
  _ChangeAppPasswordState createState() => _ChangeAppPasswordState();
}

class _ChangeAppPasswordState extends State<ChangeAppPassword> {
  TextEditingController _currentController = TextEditingController();

  TextEditingController _newController = TextEditingController();

  TextEditingController _newConfirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  SecureServices _secureServices = SecureServices();

  bool errors = false;
  bool submitted = false;

  handleSubmit() {
    if (_formKey.currentState.validate()) {
      setState(() {
        submitted = true;
      });
      if (widget.currentPassword == _currentController.text) {
        _secureServices.writeNewPassword(_newController.text).then((value) {
          setState(() {
            submitted = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => SplashAndPasswordScreen()),
              (route) => false);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Master Password'),
      ),
      body: Material(
          child: Center(
              child: Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter current password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Current Password',
                      ),
                      controller: _currentController,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'New password cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'New Password',
                      ),
                      controller: _newController,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please confirm your current password';
                        } else if (val != _newController.text) {
                          return 'Password do not match';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Confirm New Password',
                      ),
                      controller: _newConfirmController,
                    ),
                    SizedBox(height: 10),
                    errors ? Text('Something is wrong') : Text(''),
                    submitted
                        ? CircularProgressIndicator()
                        : RaisedButton(
                            onPressed: () => handleSubmit(),
                            child: Text('Submit'),
                          ),
                  ])))),
    );
  }
}
