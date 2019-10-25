import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'loading.dart';

class Button extends StatefulWidget {
  Button({
    Key key,
    this.text ="加载",
    this.isLoading = false,
    this.onChange,
  }): assert(text != ''), super(key:key);
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
      width: ScreenUtil.getInstance().width,
      child: RaisedButton(
        textColor: Colors.white,
        highlightColor: Colors.lightBlueAccent,
        color: Colors.blue,
        padding: EdgeInsets.only(
            bottom: ScreenUtil.getInstance().setHeight(10),
            top: ScreenUtil.getInstance().setHeight(10),
            right: ScreenUtil.getInstance().setWidth(0),
            left: ScreenUtil.getInstance().setWidth(0)
        ),
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

class ButtonCircle extends StatelessWidget {

  ButtonCircle({
    Key key,
    this.height = 30,
    this.onClick,
    this.text = '按钮',

  }):super(key: key);
  final double height;
  final Function onClick;
  final String text;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(height),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromRGBO(61, 158, 255, 1),
                Color.fromRGBO(24, 82, 243, 1)
              ]
          ),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [ //阴影
            BoxShadow(
                color:Colors.black45,
                offset: Offset(1.0,1.0),
                blurRadius: 2.0
            )
          ]
      ),
      child: FlatButton(
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(16),
            right: ScreenUtil().setWidth(16)
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Text(text, style: TextStyle(
            color: Colors.white
        ),),
        onPressed: onClick,
      ),
    );
  }
}




