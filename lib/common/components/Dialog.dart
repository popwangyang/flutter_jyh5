import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

class DialogWidget {
  static bool flag = false;

  // 提示弹框
  static Future alert(BuildContext context, {
    String title = "",
    String message = "弹框内容",
    bool barrierDismissible = false,
    int duration = 160
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
        transitionDuration: Duration(milliseconds: duration),
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
                        Future.delayed(Duration(milliseconds: duration),(){
                          completer.complete('ok');
                        });
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
    bool barrierDismissible = true,
    int duration = 160
  }){
    Completer completer = Completer();
    if(!flag){
      flag = true;
      showGeneralDialog(
        context: context,
        barrierLabel: "你好",
        barrierDismissible: barrierDismissible,
        barrierColor: Colors.black.withOpacity(0.7),
        transitionDuration: Duration(milliseconds: duration),
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
                              Future.delayed(Duration(milliseconds: duration),(){
                                completer.complete('cancel');
                              });
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
                            onPressed: () async{
                              Navigator.of(context).pop();
                              Future.delayed(Duration(milliseconds: duration),(){
                                completer.complete('ok');
                              });
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

  static loading(BuildContext context, String text){
    showDialog(
        context: context,
        builder: (_){
          return LoadingDialog( //调用对话框
            text: text,
          );
        },
        barrierDismissible: true
    );

  }

}

class LoadingDialog extends Dialog {

  final String text;

  LoadingDialog({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Material( //创建透明层
      type: MaterialType.transparency, //透明类型
      child: new Center( //保证控件居中效果
        child: new SizedBox(
          width: 120.0,
          height: 120.0,
          child: new Container(
            decoration: ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new CircularProgressIndicator(),
                new Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: new Text(
                    text,
                    style: new TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


