import 'package:flutter/material.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:jy_h5/common/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CitySelected extends StatelessWidget {

  final String title;
  final String codeValue;
  final String value;
  final Function onChang;
  final bool isRequired;
  final bool isLast;

  CitySelected({
    Key key,
    this.value,
    this.title,
    this.onChang,
    this.codeValue,
    this.isRequired = true,
    this.isLast = false,
  }):super(key: key);

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
          onTap: () async{
            Result result = await CityPickers.showCityPicker(
              context: context,
              locationCode: codeValue,
              height: 260,
              theme: Theme.of(context).copyWith(
                  textTheme: TextTheme(
                    body1: TextStyle(color: Color(0xFF888888), fontSize: 16.0),
                  ),
              ),
              cancelWidget: Text(
                  '取消',
                  style: TextStyle(fontSize: ScreenUtil().setSp(14),color: Color(0xff999999)),
              ),
              confirmWidget: Text(
                  '确定',
                  style: TextStyle(fontSize: ScreenUtil().setSp(14),color: Colors.blue),
              ),
              itemExtent: ScreenUtil().setHeight(30),
              itemBuilder:(value, list, index){
                return Text(value, style: TextStyle(
                  fontSize: ScreenUtil().setSp(16),
                  color: Colors.black
                ),);
              }
            );
            print(result);
            if(result != null){
              onChang(result);
            }
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

}
