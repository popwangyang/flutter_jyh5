import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../ValueNotifier.dart';

class InputForm extends StatefulWidget {

  InputForm({
    Key key,
    this.inputValue,
    this.onChange,
    this.inputType = 'text',
    this.placeholder = '请输入',
    this.vn
  }):super(key: key);
  final String inputValue;
  final ValueChanged onChange;
  final String inputType;
  final String placeholder;
  final ValueNotifierData vn;


  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {

  TextEditingController _unameController = TextEditingController();

  FocusNode _commentFocus = FocusNode();  // 焦点句柄

  bool _showCancle = false;
  double inputWidth;
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    inputWidth = widget.inputType == 'text'? 230 : 180;
    return Container(
      width: ScreenUtil.getInstance().setWidth(280),
      height: ScreenUtil.getInstance().setHeight(44),
      margin: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(30)),
      padding: EdgeInsets.only(left: 10, right: 10,),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromRGBO(204, 204, 204, 1),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width:ScreenUtil.getInstance().setWidth(inputWidth),
              height: ScreenUtil.getInstance().setHeight(44),
              child:  TextField(
                controller: _unameController, //设置controller
                obscureText: widget.inputType == 'text'? false : _showPassword,
                keyboardType: TextInputType.text,
                focusNode: _commentFocus,
                decoration: InputDecoration(
                  hintText: widget.placeholder,
                  hintStyle: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(14),
                    color: Color.fromRGBO(204, 204, 204, 1),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            Opacity(
                opacity: _showCancle ? 1:0,
                child: InkWell(
                  child: Icon(Icons.cancel, size: ScreenUtil.getInstance().setSp(20), color: Color.fromRGBO(204, 204, 204, 1),),
                  onTap: _cancelBtn,
                )
            ),
            (){
              if(widget.inputType != 'text'){
                return _eyeWidget();
              }else{
                return Container();
              }
            }()
          ],
        ),
      ),
    );
  }


  // 密码可见按钮
  Widget _eyeWidget(){
    return InkWell(
      child: Icon(_showPassword ? Icons.visibility_off:Icons.remove_red_eye, size: ScreenUtil.getInstance().setSp(20), color: Color.fromRGBO(204, 204, 204, 1),),
      onTap: _eyeBtn,
    );
  }

  @override
  void initState() {

    _unameController.addListener((){
      _showCancle = _unameController.text == '' ? false : true;
      _inputChange(_unameController.text);
    });
    widget.vn.addListener(_vnListener);
    super.initState();

  }
  void _vnListener(){
    if(_commentFocus.hasFocus){
      _commentFocus.unfocus();
    }
  }

  void _inputChange(String val){
    setState(() {});
    widget.onChange(val);
  }

  void _cancelBtn(){
    setState(() {});
    _unameController.text = '';
    _commentFocus.unfocus();
  }

  void _eyeBtn(){
    _showPassword = !_showPassword;
    setState(() {});
  }

  @override
  void dispose() {
    _unameController.dispose();
    widget.vn.dispose();
    super.dispose();
  }

}