import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import '../style.dart';

enum DateType {

  DATE,

  TIME,

}

class DateSelect extends StatefulWidget {

  final bool isLast;
  final String title;
  final bool isRequired;
  final DateTime initValue;
  final Function onChang;
  final DateType type;



  DateSelect({
    Key key,
    this.isLast = false,
    this.title,
    this.isRequired = true,
    this.initValue,
    this.type = DateType.DATE,
    @required this.onChang
  }): super(key: key);

  @override
  _DateSelectState createState() => _DateSelectState();
}

class _DateSelectState extends State<DateSelect> {

  DateTime _value;
  String _dateFormat;
  DateTimePickerMode  _datePickerMode;



  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(10, 14, 10, 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child:  Text.rich(TextSpan(
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
                    if(_value != null){
                      return Text(
                       foo(_value),
                        style: Style.inputText(),
                      );
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
              DatePicker.showDatePicker(
                  context,
                  initialDateTime: _value == null ? DateTime.now().add(Duration(hours: 8)):_value,
                  dateFormat: _dateFormat,
                  locale: DateTimePickerLocale.zh_cn,
                  pickerMode: _datePickerMode,
                  onConfirm: (date, index){
                    setState(() {
                      _value = date;
                      widget.onChang(foo(date));
                    });
                  }
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

  @override
  void initState() {
    _value = widget.initValue;
    _dateFormat = widget.type == DateType.DATE ? 'yyyy年-MMMM月-dd日':'H时-m分-s秒';
    _datePickerMode = widget.type == DateType.DATE ? DateTimePickerMode.date: DateTimePickerMode.time;
    super.initState();
  }

  String foo(DateTime date){
    String result = widget.type == DateType.DATE ?
    _value.toString().substring(0, 10):
    _value.toString().substring(10, 19);
    return result;
  }


}
