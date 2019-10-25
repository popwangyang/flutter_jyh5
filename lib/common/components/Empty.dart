import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/style.dart';

class Empty extends StatelessWidget {

  final String text;
  Empty({
    Key key,
    this.text = "暂无内容"
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('lib/assets/image/empty1.png',
            width: ScreenUtil().setWidth(158),
            height: ScreenUtil().setHeight(128),
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: 0,
          ),
          Text(text, style: Style.emptyTitle(),)
        ],
      ),
    );
  }
}
