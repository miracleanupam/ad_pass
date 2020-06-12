import 'package:ad_pass/screens/dashboardScreen.dart';
import 'package:ad_pass/services/secureServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SetPasswordScreen extends StatefulWidget {
  @override
  _SetPasswordScreenState createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmController = TextEditingController();
  SecureServices _secureServices = SecureServices();
  String error;
  bool submitted = false;

  handleSubmit() {
    setState(() {
      submitted = true;
    });
    if (_formKey.currentState.validate()) {
      if (_passwordController.text == _confirmController.text) {
        _secureServices.writeNewPassword(_passwordController.text);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DashboardScreen(savedPassword: _passwordController.text)));
      } else {
        setState(() {
          error = 'Password should match';
          submitted = false;
        });
      }
    } else {
      setState(() {
        error = 'Something is not right';
        submitted = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Security Setup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Enter Password...',
                            labelText: 'Create Master Password'),
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                        textInputAction: TextInputAction.next),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Confirm Password...',
                            labelText: 'Confirm Master Password'),
                        controller: _confirmController,
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                        textInputAction: TextInputAction.next),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      error == null ? '' : error.isEmpty ? '' : error,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    submitted
                        ? CircularProgressIndicator()
                        : RaisedButton(
                            onPressed: () => handleSubmit(),
                            child: Text('Submit'),
                          )
                  ])),
        ),
      ),
    );
  }
}
