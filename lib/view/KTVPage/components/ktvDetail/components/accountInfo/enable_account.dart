import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/api/ktv.api.dart';
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/Button.dart';
import 'package:jy_h5/common/components/ListSelect.dart';
import 'package:jy_h5/common/components/ToastWidget.dart';
import 'package:jy_h5/libs/utils.dart';
import 'package:provider/provider.dart';
import 'package:jy_h5/store/model/ktvModel.dart';
import 'dart:convert';

class EnablePage extends StatefulWidget {

  EnablePage({Key key, this.ktvId}):super(key: key);

  final int ktvId;

  @override
  _EnablePageState createState() => _EnablePageState();
}

class _EnablePageState extends State<EnablePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            AppTitle(
              hasBack: true,
              title: '正式启用',
            ),
            Container(
              width: ScreenUtil().width,
              height: ScreenUtil().setHeight(36),
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setSp(10)
              ),
              decoration: BoxDecoration(
                color: Color(0xffFFF3E2),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.notifications,
                      size: ScreenUtil().setSp(16),
                      color: Color(0xffFEA018),
                    ),
                    margin: EdgeInsets.only(
                      right: ScreenUtil().setWidth(10)
                    ),
                  ),
                  Text(
                      "正式启用账号后将永久无法使用试用账号",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(12),
                      color: Color(0xff999999)
                    ),
                  )
                ],
              ),
            ),
            ListSelected(
              title: '开始计费时间',
              initValue: value,
              data: days,
              isLast: true,
              onChange: (e){
                value = days[e];
                setDate(e);
              },
            ),
            Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(10),
                vertical: ScreenUtil().setHeight(10),
              ),
              child: Text(dateValue, style: TextStyle(
                fontSize: ScreenUtil().setSp(12),
                color: Color(0xff999999)
              ),),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(10),
                vertical: ScreenUtil().setHeight(30)
              ),
              child: Button(
                text: '正式启用',
                onChange: (e){
                  _enableBtn();
                },
              ),
            )
          ],
        ),
      ),
    );
  }


  List days = [];
  String value;
  String dateValue;

  void getData(){
    for(var i = 1; i < 31; i++){
      String day = "$i天后";
      days.add(day);
    }
  }

  void setDate(int day){
    DateTime date = DateTime.now();
    date = date.add(Duration(days: day + 1));
    setState(() {
      dateValue = "于 ${Utils.dateChang(date.toString().split(" ")[0])} 开始计费 ";
    });
    print(date.toString());
  }

  _enableBtn() async{
     ToastWidget.loading(context, message: '启用中...', duration: 0);
     var sendData = {
       'chargeable_time': days.indexOf(value) + 1
     };
     try{
       var data = await enableAccount(widget.ktvId, sendData, context);
       ToastWidget.success(context, message: '启用成功');
       Provider.of<Ktv>(context).setAccountStatus(2);
       Provider.of<Ktv>(context).setChargeableTime(json.decode(data.toString())['chargeable_time']);
       Future.delayed(Duration(milliseconds: 200), (){
         Navigator.of(context).pop();
       });
     }catch(err){
       ToastWidget.clear();
     }
  }

  @override
  void initState() {
   getData();
   value = days[6];
   setDate(6);
    super.initState();
  }
}
