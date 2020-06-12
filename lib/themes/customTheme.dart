import 'package:flutter/material.dart';

class AppTheme {
  //
  AppTheme._();

  static const Color test = Colors.grey;

  static const Color _primaryColor = Color(0xff00695c);
  static const Color _primaryLightColor = Color(0xff439889);
  static const Color _primaryDarkColor = Color(0xff003d33);
  // static const Color _secondaryColor = Color(0xff283593);
  static const Color _secondaryLightColor = Color(0xff5f5fc4);
  // static const Color _secondaryDarkColor = Color(0xff001064);
  // static const Color _primaryTextColor = Color(0xffffffff);
  // static const Color _secondaryTextColor = Color(0xffffffff);
  // static const Color _errorColor = Color(0xffb71c1c);
  static const Color _buttonColor = Color(0xff003d33);
  static const Color _appBarColor = Color(0xff003d33);
  static const Color _drawerBottomBackgroundColor = Color(0xff003d33);
  static const Color _textInputLabelColor = Colors.amber;
  static const Color _textInputHintColor = Color(0xa44439889);
  static const Color _textInputBorderColor = Color(0xff003d33);

  // static const Color _iconColor = Color()

  // backgroung in body of scaffold
  static const Color _scaffoldBackgroundColor = Color(0xff212121);

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: _primaryColor,
    primaryColorLight: _primaryLightColor,
    primaryColorDark: _primaryDarkColor,
    scaffoldBackgroundColor: _scaffoldBackgroundColor,
    backgroundColor: _secondaryLightColor,
    // accentColor: _primaryDarkColor,

    buttonTheme: ButtonThemeData(
      buttonColor: _buttonColor,
    ),
    appBarTheme: AppBarTheme(
      color: _appBarColor,
    ),

    dividerColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: _primaryDarkColor,
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.white70,
      backgroundColor: _primaryLightColor,
      splashColor: _primaryColor,
    ),

    // accentColor: _primaryColor,

    // colorScheme: ColorScheme.dark(
    //     primary: _primaryColor,
    //     secondary: _secondaryColor,
    //     background: _scaffoldBackgroundColor,
    //     onSurface: _primaryDarkColor,
    //     brightness: Brightness.dark),

    textTheme: TextTheme(
      // TextFormField() Text input
      // headline6: TextStyle(color: Colors.tealAccent[700]),
      subtitle1: TextStyle(color: Colors.tealAccent[700], fontSize: 24.0),
      subtitle2: TextStyle(
        color: Colors.tealAccent[700],
      ),
      bodyText1: TextStyle(color: Colors.tealAccent[700]),
      // Text() inside Forms
      bodyText2: TextStyle(color: Colors.yellow),
    ),

    // background for bottom part of drawer
    canvasColor: _drawerBottomBackgroundColor,

    cursorColor: _textInputBorderColor,

    inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          fontSize: 18.0,
          height: 1.2,
          color: _textInputLabelColor,
        ),
        suffixStyle: TextStyle(
          color: _primaryDarkColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: TextStyle(
          fontSize: 18.0,
          height: 1.2,
          color: _textInputHintColor,
        ),
        enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.zero, bottomRight: Radius.zero),
            borderSide: BorderSide(
              color: _textInputBorderColor,
              width: 2.0,
              style: BorderStyle.solid,
            )),
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.zero, bottomRight: Radius.zero),
            borderSide: BorderSide(
              color: _textInputBorderColor,
              width: 2.0,
              style: BorderStyle.solid,
            ))),
  );
}
