import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset('lib/assets/image/empty.png', 
        width: ScreenUtil().setWidth(158),
        height: ScreenUtil().setHeight(128),
        fit: BoxFit.contain,
      ),
    );
  }
}
