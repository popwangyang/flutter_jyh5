import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

class Button extends StatefulWidget {
  Button({Key key, this.text ="加载", this.isLoading = false, this.onChange}): assert(text != ''), super(key:key);
  final String text;
  final bool isLoading;
  final ValueChanged<bool> onChange;
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      width: ScreenUtil.getInstance().setWidth(280),
      child: RaisedButton(
        textColor: Colors.white,
        highlightColor: Colors.lightBlueAccent,
        color: Colors.blue,
        padding: EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(0),top: ScreenUtil.getInstance().setHeight(0), right: ScreenUtil.getInstance().setWidth(0),left: ScreenUtil.getInstance().setWidth(0)),
        child: widget.isLoading ? Loading(text: widget.text,):Text(widget.text),
        onPressed: _btn,
      ),
    );
  }

  void _btn(){
    if(!widget.isLoading){
      widget.onChange(true);

    }
  }
}

class Loading extends StatefulWidget{
   Loading({Key key, this.text = '加载中'}) :super(key: key);


   final String text;
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin{

  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(seconds: 200), vsync: this);
    //图片宽高从0变到300
    animation = new Tween(begin: 0.0, end: 300*math.pi).animate(controller)
      ..addListener(() {
        setState(()=>{});
      });
    //启动动画(正向执行)
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Transform.rotate(
            angle: animation.value,
            child: Icon(Icons.camera, size: 16,),
          ),
          SizedBox(width: 4,),
          Text("${widget.text}...")
        ],
      ),
    );
  }

  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

