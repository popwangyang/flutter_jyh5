import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

class SystemUpgrade{
  static Future show(BuildContext context, {String initValue}) async{
    Completer completer =Completer();
    var result  = await Navigator.of(context, rootNavigator: true).push(
        _PopRoute(
          initValue: initValue,
        )
    );
    completer.complete(result);
    return completer.future;
  }
}

class AnimatedInput extends AnimatedWidget{
  static final _opacityTween = new Tween<double>(
    begin: 0.0,
    end: 1.0
  );

  AnimatedInput({
    Key key,
    Animation<double> animation,
    this.vodText,
    this.initValue
  })
    :super(
      key: key,
      listenable: animation,
  );

  final String vodText;
  final String initValue;
  
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    
    return Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Transform.scale(
          scale: _opacityTween.evaluate(animation),
          child: _content(context),
        )
    );
  }

  Widget _content(BuildContext context){
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: ScreenUtil().setWidth(280),
          height: ScreenUtil().setHeight(170),
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
                      Text('升级系统', style: TextStyle(
                          fontSize: ScreenUtil().setSp(16),
                          color: Color(0xFF323233)
                      ),),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child:  _messageWidget(),
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
                        Navigator.of(context).pop(vodText);

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
  }

  Widget _messageWidget(){
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(10)
      ),
      child: Column(
        children: <Widget>[
          Text.rich(TextSpan(
              children: [
                TextSpan(
                  text: '当前版本',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(14)
                  )
                ),
                TextSpan(
                    text: initValue,
                    style: TextStyle(
                        color: Colors.grey
                    )
                )
              ]
          )),
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(10)
            ),
            width: ScreenUtil().setWidth(160),
            height: ScreenUtil().setHeight(30),
            decoration: BoxDecoration(
              color: Color(0xffEFEEF3),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: (){
                if(vodText == null || vodText == ''){
                  return Text("请输入版本号");
                }else{
                  return Text(vodText, style: TextStyle(
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                  ),);
                }
              }(),
            ),
          )
          
        ],
      ),
    );
  }
}

class AnimatedKeyboard extends AnimatedWidget{

  final List number = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];

  AnimatedKeyboard({
    Key key,
    Animation<double> animation,
    this.onChang,
    this.deleted,
    this.onOK
  })
  :super(key: key, listenable: animation);

  final Function onChang;
  final Function deleted;
  final Function onOK;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    final _translateTween = new Tween<double>(
        begin: 216,
        end: 0
    );

    return Transform.translate(
      offset: Offset(0.0, _translateTween.evaluate(animation)),
      child: _content(),
    );
  }

  Widget _content(){
    return Material(
      child: Container(
        width: ScreenUtil().setWidth(375),
        height: ScreenUtil().setHeight(216),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(
                width: ScreenUtil().setWidth(93.75 * 3),
                height: ScreenUtil().setHeight(216),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Wrap(
                      children: number.map((item){
                        return _pickItem1(item,);
                      }).toList(),
                    ),
                    Row(
                      children: <Widget>[
                        FlatButton(
                          child: Container(
                            width: ScreenUtil().setWidth(187.5),
                            height: ScreenUtil().setHeight(54),
                            decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                      width: 1,
                                      color: Color(0xffebedf0)
                                  ),
                                )
                            ),
                            child: Center(
                              child: Text('0', style: TextStyle(
                                  fontSize: ScreenUtil().setSp(24),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black
                              ),),
                            ),
                          ),
                          onPressed: (){
                            onChang('0');
                          },
                        ),
                        FlatButton(
                          child: Container(
                            width: ScreenUtil().setWidth(93.75),
                            height: ScreenUtil().setHeight(54),
                            decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                      width: 1,
                                      color: Color(0xffebedf0)
                                  ),
                                )
                            ),
                            child: Center(
                              child: Text('.', style: TextStyle(
                                  fontSize: ScreenUtil().setSp(24),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black
                              ),),
                            ),
                          ),
                          onPressed: (){
                            onChang('.');
                          },
                        ),
                      ],
                    )
                  ],
                )
            ),
            Container(
              width: ScreenUtil().setWidth(93.75),
              height: ScreenUtil().setHeight(216),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      color: Color(0xffebedf0),
                      child: Container(
                        width: ScreenUtil().setWidth(93.75),
                        child: Center(
                          child: Text(
                            '删除',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(16),
                                color: Colors.black
                            ),
                          ),
                        ),
                      ),
                      onPressed: deleted,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child:FlatButton(
                      color: Color(0xff1989fa),
                      child: Container(
                        width: ScreenUtil().setWidth(93.75),
                        child: Center(
                          child: Text(
                            '完成',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(16),
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      onPressed: onOK,
                    ) ,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pickItem1(String num){
    return FlatButton(
      child: Container(
        width: ScreenUtil().setWidth(93.75),
        height: ScreenUtil().setHeight(54),
        decoration: BoxDecoration(
            border: Border(
                right: BorderSide(
                    width: 1,
                    color: Color(0xffebedf0)
                ),
                bottom: BorderSide(
                    width: 1,
                    color: Color(0xffebedf0)
                )
            )
        ),
        child: Center(
          child: Text(num, style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),),
        ),
      ),
      onPressed: (){
        onChang(num);
      },
    );
  }


}


class Box extends StatefulWidget {

  Box({
    Key key,
    this.animation,
    this.initValue,
  }):super(key: key);
  final Animation animation;
  final String initValue;

  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {

  String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(100)
              ),
              child:  AnimatedInput(
                animation: widget.animation,
                vodText: value,
                initValue: widget.initValue,

              ),
            ),
          ),
          AnimatedKeyboard(
            animation: widget.animation,
            onChang: (num){
              setState(() {
                value += num;
              });
            },
            deleted: _deleted,
            onOK: _onOK,
          )
        ],
      ),
    );
  }

  _deleted(){
    if(value != null && value.length > 0){
      setState(() {
        value = value.substring(0, value.length -1);
      });
    }
  }

  _onOK(){
    Navigator.of(context).pop(value);
  }

  @override
  void initState() {
    value = widget.initValue;

    super.initState();
  }
}


///Route
class _PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);

  _PopRoute({
    this.initValue,
  });

  String initValue;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.4);

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Box(
      animation: _animation,
      initValue: initValue,
    );
  }

  @override
  Duration get transitionDuration => _duration;

  Animation<double> _animation;

  @override
  Animation<double> createAnimation() {
    _animation = CurvedAnimation(
      parent: super.createAnimation(),
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut.flipped,
    );
    return _animation;
  }
}



