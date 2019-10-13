import 'package:flutter/material.dart';
import 'dart:math' as math;

class Loading extends StatefulWidget{
  Loading({
    Key key,
    this.text = '加载中...',
    this.iconData = Icons.camera,
    this.size = 16
  }) :super(key: key);


  final String text;
  final double size;
  final IconData iconData;

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
            child: Icon(widget.iconData, size: widget.size,),
          ),
          SizedBox(width: 4,),
          Text("${widget.text}")
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