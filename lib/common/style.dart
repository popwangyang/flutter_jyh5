import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Style {
  static TextStyle inputText(){
    return TextStyle(
        color: Color.fromRGBO(102, 102, 102, 1),
        fontSize: ScreenUtil().setSp(14)
    );
  }
  static TextStyle pickListText(){
    return TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: ScreenUtil().setSp(16)
    );
  }
  static TextStyle buttonText(){
    return TextStyle(
        color: Color.fromRGBO(25, 137, 250, 1),
        fontSize: ScreenUtil().setSp(14)
    );
  }

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