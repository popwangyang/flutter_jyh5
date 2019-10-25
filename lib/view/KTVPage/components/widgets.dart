import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class LF extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(12),
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(4), right: ScreenUtil().setWidth(4) ),
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(8)),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color.fromRGBO(241, 194, 135, 1), Color.fromRGBO(204, 152, 88, 1)])
      ),
      child:Center(
        child: Text("量贩",style: TextStyle(
          fontSize: ScreenUtil().setSp(8),
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),),
      ) ,
    );
  }
}

class YZH extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(12),
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(4), right: ScreenUtil().setWidth(4)),
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(8)),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color.fromRGBO(41, 241, 245, 1), Color.fromRGBO(43, 196, 211, 1)])
      ),
      child: Text("夜总会",style: TextStyle(
        fontSize: ScreenUtil().setSp(8),
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),),
    );
  }
}



