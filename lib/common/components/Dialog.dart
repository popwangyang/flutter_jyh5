import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

class DialogWidget {
  static bool flag = false;

  static Future alert(BuildContext context, {
    String title = "提示",
    String message = "弹框内容"
  }){
    if(!flag){
      Completer completer = Completer();
      flag = true;
      print("showDialog");
      showGeneralDialog(
        context: context,
        barrierLabel: "你好",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.7),
        transitionDuration: Duration(milliseconds: 160),
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: ScreenUtil().setWidth(280),
                height: ScreenUtil().setHeight(160),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            (){
                              if(title != null && title != ''){
                                return Text(title, style: TextStyle(
                                    fontSize: ScreenUtil().setSp(14),
                                    color: Color(0xFF323233)
                                ),);
                              }else{
                                return SizedBox(
                                  height: 0,
                                );
                              }
                            }(),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child:  Text(message,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(14),
                                    color: Color(0xFF7d7e80)
                                ),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 0.5,
                      color: Colors.black.withOpacity(0.7),
                    ),
                    FlatButton(
                      child: Container(
                        height: ScreenUtil().setHeight(52),
                        alignment: Alignment.center,
                        child: Text("确认", style: TextStyle(
                            fontSize: ScreenUtil().setSp(16),
                            color: Color.fromRGBO(25, 137, 250, 1)
                        ),),
                      ),
                      onPressed: (){
                        Navigator.of(context).pop();

                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
        transitionBuilder: (ctx, animation, _, child) {
          return ScaleTransition(
            alignment: Alignment.center, // 添加这个
            scale: animation,
            child: child,
          );
        },
      ).then((v){
        flag = false;
        completer.complete('ok');
      });
      return completer.future;
    }else{
      return completer.future;
    }
  }

  static Future confirm(BuildContext context, {

  })


}