import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

class DialogWidget {
  static bool flag = false;

  // 提示弹框
  static Future alert(BuildContext context, {
    String title = "",
    String message = "弹框内容",
    bool barrierDismissible = false
  }){
    Completer completer = Completer();
    if(!flag){
      flag = true;
      print("showDialog");
      showGeneralDialog(
        context: context,
        barrierLabel: "你好",
        barrierDismissible: barrierDismissible,
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
                      color: Color(0xffebedf0),
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
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              alignment: Alignment.center, // 添加这个
              scale: animation,
              child: child,
            ),
          );
        },
      ).then((v){
        flag = false;
        completer.complete('ok');
      });

    }else{
      completer.completeError('err');
    }
    return completer.future;
  }

  // 确认弹框
  static Future confirm(BuildContext context, {
    String title = '',
    String message = "弹框内容",
    Widget messageWidget,
    bool barrierDismissible = true
  }){
    Completer completer = Completer();
    if(!flag){
      flag = true;
      showGeneralDialog(
        context: context,
        barrierLabel: "你好",
        barrierDismissible: barrierDismissible,
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
                                child:  (){
                                  if(messageWidget != null){
                                    return messageWidget;
                                  }else{
                                    return Text(message,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(14),
                                          color: Color(0xFF7d7e80)
                                      ),);
                                  }
                                }(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 0.5,
                      color: Color(0xffebedf0),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child:  FlatButton(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: Color(0xffebedf0),
                                    width: 0.5
                                  )
                                )
                              ),
                              height: ScreenUtil().setHeight(52),
                              alignment: Alignment.center,
                              child: Text("取消", style: TextStyle(
                                  fontSize: ScreenUtil().setSp(16),
                                  color: Color(0xff323233)
                              ),),
                            ),
                            onPressed: (){
                              Navigator.of(context).pop();
                              completer.complete('cancel');
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child:  FlatButton(
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
                              completer.complete('ok');
                            },
                          ),
                        )
                      ],
                    )

                  ],
                ),
              ),
            ),
          );
        },
        transitionBuilder: (ctx, animation, _, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              alignment: Alignment.center, // 添加这个
              scale: animation,
              child: child,
            ),
          );
        },
      ).then((v){
        flag = false;
      });

    }else{
      completer.completeError('err');
    }
    return completer.future;
  }


  // 关闭弹框
  static close(BuildContext context){
    Navigator.of(context).pop();
  }

  static loading(BuildContext context){
    showDialog(
        context: context,
        builder: (_){
          return Center(
            child: Text("pppppp"),
          );
        },
        barrierDismissible: false
    );

  }

}


