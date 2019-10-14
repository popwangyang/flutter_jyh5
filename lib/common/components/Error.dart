import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Error extends StatelessWidget {

  final Function reload;

  Error({Key key, this.reload}): super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      child: Center(
        child: Container(
          width: ScreenUtil.getInstance().setWidth(135),
          height: ScreenUtil.getInstance().setHeight(208),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset('lib/assets/image/error.png',
                width: ScreenUtil.getInstance().setWidth(135),
                fit: BoxFit.fitWidth,
              ),
              Positioned(
                top: ScreenUtil.getInstance().setHeight(120),
                child: Row(
                  children: <Widget>[
                    Text("加载失败，", style: themeData.textTheme.display4,),
                    InkWell(
                      child: Text("重新加载", style: TextStyle(
                        color: Colors.blue,
                        fontSize: ScreenUtil().setSp(12),
                        fontWeight: FontWeight.w400
                      ),),
                      onTap: (){
                        reload();
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
