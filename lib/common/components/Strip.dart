import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/style.dart';

class Strip extends StatelessWidget {

  final String title;

  Strip({Key key, this.title}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: ScreenUtil().setHeight(40),
      width: ScreenUtil().width,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
      child: Text(title, style: Style.navTitle()),
    );
  }
}
