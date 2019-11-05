import 'package:flutter/material.dart';
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/components/Button.dart';
import 'package:jy_h5/common/components/ToastWidget.dart';
import 'package:jy_h5/libs/utils.dart';
import 'package:jy_h5/model/validate/rule.dart';
import 'package:jy_h5/api/login.api.dart';
import 'dart:async';

class SetPassword extends StatefulWidget {

  SetPassword({Key key, this.code, this.username}):super(key: key);

  final String code;
  final String username;

  @override
  _SetPasswordState createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            AppTitle(
              title: '重置密码',
              hasBack: true,
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20)
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(20)
                        ),
                        child: Text("新密码", style: TextStyle(
                            fontSize: ScreenUtil().setSp(20),
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),),
                        alignment: Alignment.centerLeft,
                      ),
                      Container(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "新密码",
                            hintText: '请输新密码',
                            hintStyle: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                color: Color(0xffC6CBD4)
                            ),
                            border: UnderlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(12)
                            ),
                          ),
                          onChanged: (e){
                            fromData['password1'] = e;
                          },
                        ),
                      ),
                      Container(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "确认密码",
                            hintText: '请再次输新密码',
                            hintStyle: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                color: Color(0xffC6CBD4)
                            ),
                            border: UnderlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(12)
                            ),
                          ),
                          onChanged: (e){
                            fromData['password2'] = e;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(50)
                        ),
                        child: Button(
                          text: '完成',
                          onChange: (e){
                            _btnClick();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Map fromData = {
    'password1': '',
    'password2': ''
  };

  Map rule = {
    'password1': [
      Rule(require: true, message: '请输入新密码'),
      Rule(message: '请输入8~16的字母和数字的组合', type: ruleType.Password)
    ]
  };

  bool validate(){
    bool result;
    bool validateState = Utils.validate(fromData, rule, context);
    if(validateState){
      if(fromData['password1'] != fromData['password2']){
        ToastWidget(context, "两次密码不一致");
        result = false;
      }else{
        result = true;
      }
    }else{
      result = false;
    }
    return result;
  }

  _btnClick() async{
    if(validate()){
      var sendData = {
        'code': widget.code,
        'username': widget.username,
        'password': fromData['password1']
      };
      print(sendData);
      try{
        ToastWidget.loading(context, message: '加载中...', duration: 0);
        await resetPassword(sendData, context);
        ToastWidget.success(context, message: '设置成功');
        Timer(Duration(milliseconds: 400), (){
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        });
      }catch(err){
        print(err);
        ToastWidget.clear();
      }

    }
  }

}
