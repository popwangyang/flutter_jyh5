import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Style {
  static TextStyle placeHolder(){
    return TextStyle(
      fontSize: ScreenUtil.getInstance().setSp(14),
      color: Color.fromRGBO(204, 204, 204, 1),
    );
  }
  static TextStyle pageTitle(){
    return TextStyle(
        fontWeight: FontWeight.w600,
        color: Color.fromRGBO(2, 2, 2, 1),
        fontSize: ScreenUtil.getInstance().setSp(16)
    );
  }

  static TextStyle listTitle(){
    return TextStyle(
        color: Color.fromRGBO(68, 68, 68, 1),
        fontWeight: FontWeight.w400,
        fontSize: ScreenUtil().setSp(14)
    );
  }

  static TextStyle listLabel(){
    return TextStyle(
        color: Color.fromRGBO(160, 160, 160, 1),
        fontSize: ScreenUtil().setSp(14),
        fontWeight: FontWeight.w400
    );
  }

  static TextStyle navTitle(){
    return TextStyle(
      fontSize: ScreenUtil().setSp(12),
      color: Color.fromRGBO(153, 153, 153, 1),
      fontWeight: FontWeight.w400,
    );
  }



}