import 'package:ad_pass/screens/dashboardScreen.dart';
import 'package:flutter/material.dart';

class AskPasswordScreen extends StatefulWidget {
  final String savedPassword;

  AskPasswordScreen({this.savedPassword});
  @override
  _AskPasswordScreenState createState() => _AskPasswordScreenState();
}

class _AskPasswordScreenState extends State<AskPasswordScreen> {
  TextEditingController _controller = TextEditingController();
  bool isMatched;

  handleSubmit() {
    if (widget.savedPassword == _controller.text) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DashboardScreen(savedPassword: widget.savedPassword)));
    } else {
      setState(() {
        isMatched = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Security Check')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                  controller: _controller,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    labelText: 'Your Master Password',
                  )),
              SizedBox(
                height: 10,
              ),
              Text(
                isMatched == null ? '' : isMatched ? '' : 'Incorrect Password',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Spacer(),
                  RaisedButton(
                    onPressed: () => handleSubmit(),
                    child: Text('Enter'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  Spacer(),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
