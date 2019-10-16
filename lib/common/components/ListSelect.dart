import 'package:flutter/material.dart';
import 'package:jy_h5/common/components/ListPicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../style.dart';

class ListSelected extends StatefulWidget {
  final bool isRequired;
  final List data;
  final ValueChanged onChange;
  final String initValue;
  final bool isLast;
  final String title;

  ListSelected({
    Key key,
    this.isRequired = true,
    this.data,
    this.onChange,
    this.initValue,
    this.title,
    this.isLast = false
  }):super(key: key);

  @override
  _ListSelectedState createState() => _ListSelectedState();
}

class _ListSelectedState extends State<ListSelected>{

  double customerItemExtent = 40;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 2,
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
                Expanded(
                  flex: 4,
                  child: (){
                    if(widget.initValue != null){
                      return Text(widget.initValue, style: Style.inputText(),);
                    }else{
                      return Text('请选择', style: Style.placeHolder());
                    }
                  }(),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(20),
                  height: ScreenUtil().setHeight(20),
                )
              ],
            ),
          ),
          onTap: (){
            ListPicker.pickerList(
                context,
                widget.data,
                _onSelected,
                widget.initValue
            );
          },
        ),
        Opacity(
          opacity: widget.isLast ? 0:1,
          child: Divider(
            indent: 16,
            height: 1,
            color: Color.fromRGBO(235, 237, 240, 1),
          ),
        )
      ],
    );
  }

  _onSelected(int index){
    widget.onChange(index);
  }

}


