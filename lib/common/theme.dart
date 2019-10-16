import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final appTheme = ThemeData(
  primarySwatch: Colors.blue,
  textTheme: TextTheme(
    body1: TextStyle(color: Color(0xFF888888), fontSize: 12.0),
    display4: TextStyle(
      fontFamily: 'PingFangSC-Regular,PingFangSC;',
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: Color.fromRGBO(198,203,212,1),
    ),
  ),
  buttonTheme: ButtonThemeData(
    minWidth: 0,
    height: 0,
    padding: EdgeInsets.all(0),
    buttonColor: Colors.transparent
  ),
  inputDecorationTheme: InputDecorationTheme(
      contentPadding:EdgeInsets.all(0),  // 设置input的默认padding
      border: InputBorder.none  // 设置input的默认border
  )
);