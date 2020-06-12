import 'package:ad_pass/screens/askPasswordScreen.dart';
import 'package:ad_pass/screens/setPasswordScreen.dart';
import 'package:ad_pass/screens/splash.dart';
import 'package:ad_pass/services/secureServices.dart';
import 'package:flutter/material.dart';

class SplashAndPasswordScreen extends StatefulWidget {
  @override
  _SplashAndPasswordScreenState createState() =>
      _SplashAndPasswordScreenState();
}

class _SplashAndPasswordScreenState extends State<SplashAndPasswordScreen> {
  bool isLoading = true;
  bool showSetPassword = true;
  String savedPassword;
  SecureServices _secureServices = SecureServices();

  @override
  void initState() {
    super.initState();
    getSavedPassword();
  }

  getSavedPassword() {
    _secureServices.readSavedPassword().then((value) {
      if (value == null) {
        setState(() {
          isLoading = false;
          showSetPassword = true;
        });
      } else {
        setState(() {
          isLoading = false;
          showSetPassword = false;
          savedPassword = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SplashScreen()
        : showSetPassword
            ? SetPasswordScreen()
            : AskPasswordScreen(
                savedPassword: savedPassword,
              );
  }
}
