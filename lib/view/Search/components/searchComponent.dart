
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchWidget extends StatefulWidget {

  final String placeHolder;
  final Function onChange;

  SearchWidget({
    Key key,
    this.placeHolder = '请输入',
    this.onChange,
  }):super(key: key);


  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {


  TextEditingController _unameController = TextEditingController();
  bool cancelBtnStatues = false;
  Timer timer;

  FocusNode _commentFocus = FocusNode();  // 焦点句柄

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Container(
        width: ScreenUtil().setWidth(345),
        height: ScreenUtil().setHeight(35),
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: Color.fromRGBO(239, 238, 243, 1),
          borderRadius: BorderRadius.circular(18)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.search,
              size: ScreenUtil().setSp(16),
              color: Color.fromRGBO(204, 204, 204, 1),
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
              flex: 1,
              child: TextField(
                controller: _unameController, //设置controller
                focusNode: _commentFocus,
                onChanged: _onChanged,
                cursorWidth: 1,
                cursorColor: Colors.black,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.black
                ),
                decoration: InputDecoration(
                  hintText: widget.placeHolder,
                  hintStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(12),
                    color: Color.fromRGBO(204, 204, 204, 1)
                  )
                ),
              ),
            ),
            Opacity(
              opacity: cancelBtnStatues ? 1:0,
              child: InkWell(
                child: Icon(
                  Icons.cancel,
                  size: ScreenUtil().setSp(16),
                  color: Color.fromRGBO(204, 204, 204, 1),
                ),
                onTap: _cancelBtn,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _cancelBtn(){
    if(cancelBtnStatues){
      _unameController.text = '';
      _onChanged('');
    }
  }

  _inputChange(e){

    // 防抖函数
    timer?.cancel();
    timer = Timer(Duration(milliseconds: 300), (){
      widget.onChange(e);
    });
  }

  _onChanged(e){
    _inputChange(e);
  }

  @override
  void initState() {
    cancelBtnStatues = false;
    _unameController.addListener((){
      print('_unameController');
      setState(() {
        cancelBtnStatues = _unameController.text != '' ? true:false;
      });
    });
    super.initState();
  }
}
