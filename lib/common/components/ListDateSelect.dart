import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import '../style.dart';
import 'dart:math';

enum DateType {

  DATE,

  TIME,

}

class DatePick extends StatelessWidget {

  final bool isLast;
  final String title;
  final bool isRequired;
  final String value;
  final Function onChang;
  final DateType type;



  DatePick({
    Key key,
    this.isLast = false,
    this.title,
    this.isRequired = true,
    this.value,
    this.type = DateType.DATE,
    @required this.onChang
  }): super(key: key);

  String dateFormat;
  DateTimePickerMode  datePickerMode;

  @override
  Widget build(BuildContext context) {
    dateFormat = type == DateType.DATE ? 'yyyy年-MMMM月-dd日':'H时-m分-s秒';
    datePickerMode = type == DateType.DATE ? DateTimePickerMode.date: DateTimePickerMode.time;


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
                            text: title,
                            style: Style.listTitle()
                        ),
                            (){
                          if(!isRequired){
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
                    if(value != null){
                      return Text(
                        value,
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
                initialDateTime: value == null ? DateTime.now().add(Duration(hours: 8)) : goo(value),
                dateFormat: dateFormat,
                locale: DateTimePickerLocale.zh_cn,
                pickerMode: datePickerMode,
                onConfirm: (date, index){
                  print(foo(date));
                  onChang(foo(date));
                }
            );
          },
        ),
        Opacity(
          opacity: isLast ? 0:1,
          child: Divider(
            indent: 16,
            height: 1,
            color: Color.fromRGBO(235, 237, 240, 1),
          ),
        )
      ],
    );
  }

  String foo(DateTime date){
    String result = type == DateType.DATE ?
    date.toString().substring(0, 10):
    date.toString().substring(10, 19);
    return result;
  }

  DateTime goo(String str){
    DateTime result = DateTime.now();
    if(type == DateType.DATE){
      result = DateTime.parse(str);
    }else{
      if(str != ''){
        List arr = str.split(':');
        DateTime now = DateTime.now();
        print(arr);
        result = DateTime(now.year, now.month, now.day, int.parse(arr[0]), int.parse(arr[1]), int.parse(arr[2]));
      }
    }
    return result;
  }


}

