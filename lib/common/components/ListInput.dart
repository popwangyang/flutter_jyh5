import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../style.dart';


class ListInput extends StatefulWidget {

  final bool isLast;
  final bool isRequired;
  final String placeholder;
  final String title;
  final String value;
  final ValueChanged onChange;


  ListInput({
    Key key,
    this.isRequired = true,
    this.isLast = false,
    this.placeholder = '请输入',
    @required this.title,
    this.value,
    this.onChange
  }):super(key: key);

  @override
  _ListInputState createState() => _ListInputState();
}

class _ListInputState extends State<ListInput> {

  FocusNode _focusNode = FocusNode();  // 输入框焦点句柄
  TextEditingController _textEditingController = TextEditingController(); // 输入框控制器
  bool _cancelDisplay = false;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(10, 14, 10, 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Text.rich(TextSpan(
                      children: [
                        TextSpan(
                            text: widget.title,
                            style: Style.listTitle()
                        ),
                            (){
                          if(!widget.isRequired){
                            return TextSpan(
                                text: '(选填)',
                                style: Style.placeHolder()
                            );
                          }else{
                            return TextSpan();
                          }
                        }()
                      ]
                  )),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.white30,
                  child: TextField(
                    controller: _textEditingController,
                    onChanged: _onChanged,
                    focusNode: _focusNode,
                    style: Style.inputText(),
                    cursorWidth: 1,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: widget.placeholder,
                        hintStyle: Style.placeHolder()
                    ),
                  ),
                ),
              ),
              Opacity(
                opacity: _cancelDisplay ? 1:0,
                child: InkWell(
                  child: Icon(
                    Icons.cancel,
                    size: ScreenUtil().setSp(20),
                    color: Color.fromRGBO(150, 151, 153, 1),
                  ),
                  onTap: (){
                    if(_cancelDisplay){
                      _cancelBtn();
                    }
                  },
                ),
              )
            ],
          ),
        ),
        Opacity(
          opacity: widget.isLast ? 0:1,
          child: Divider(
            height: 1,
            color: Color.fromRGBO(235, 237, 240, 1),
            indent: 20,
          ),
        )
      ],
    );
  }

  _onChanged(e){
    widget.onChange(e);
    _showCancel();
  }

  _showCancel(){
    if(_textEditingController.text != '' && _focusNode.hasFocus){
      _cancelDisplay = true;
    }else{
      _cancelDisplay = false;
    }
    setState(() {});
  }

  _cancelBtn(){
    _textEditingController.text = '';
    widget.onChange('');
    _cancelDisplay = false;
    setState(() {});
  }

  @override
  void initState() {
    _textEditingController.text = widget.value;
    _focusNode.addListener((){
      _showCancel();
    });
    super.initState();
  }
}