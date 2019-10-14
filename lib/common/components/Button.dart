import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'loading.dart';

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
      width: ScreenUtil.getInstance().setWidth(280),
      child: RaisedButton(
        textColor: Colors.white,
        highlightColor: Colors.lightBlueAccent,
        color: Colors.blue,
        padding: EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(10),top: ScreenUtil.getInstance().setHeight(10), right: ScreenUtil.getInstance().setWidth(0),left: ScreenUtil.getInstance().setWidth(0)),
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

