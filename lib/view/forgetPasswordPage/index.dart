import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/api/login.api.dart';
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/Button.dart';
import 'package:jy_h5/common/components/ToastWidget.dart';
import 'package:jy_h5/libs/utils.dart';
import 'package:jy_h5/model/validate/rule.dart';
import 'set_password.dart';
import 'dart:async';

class ForgetPassWord extends StatefulWidget {
  @override
  _ForgetPassWordState createState() => _ForgetPassWordState();
}

class _ForgetPassWordState extends State<ForgetPassWord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            AppTitle(
              title: '邮箱验证',
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
                        child: Text("邮箱验证", style: TextStyle(
                            fontSize: ScreenUtil().setSp(20),
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),),
                        alignment: Alignment.centerLeft,
                      ),
                      Container(
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: "邮箱",
                              hintText: '请输入邮箱',
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
                            fromData['email'] = e;
                          },
                        ),
                      ),
                      Container(
                        child: TextField(
                          onChanged: (e){
                            fromData['code'] = e;
                          },
                          decoration: InputDecoration(
                            labelText: "验证码",
                            hintText: '请输入验证码',
                            hintStyle: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                color: Color(0xffC6CBD4)
                            ),
                            border: UnderlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(12)
                            ),
                            suffixIcon: Container(
                              width: ScreenUtil().setWidth(80),
                              alignment: Alignment.bottomRight,
                              padding: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(4)
                              ),
                              child: (){
                                if(flag){
                                  return InkWell(
                                    child: Text("获取验证码", style: TextStyle(
                                        fontSize: ScreenUtil().setSp(14),
                                        color: Color(0xff4B74FF),
                                        fontWeight: FontWeight.w600
                                    ),),
                                    onTap: _getCode,
                                  );
                                }else{
                                  return TimerCode(
                                    onChang: _onChang,
                                  );
                                }
                              }(),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(50)
                        ),
                        child: Button(
                          text: '下一步',
                          onChange: (e){
                            _nextStep();
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
    'email': '',
    'code': ''
  };

  bool flag = true;

  Map rule = {
    'email': [
      Rule(require: true, message: '请输入邮箱'),
      Rule(message: '邮箱格式不正确', type: ruleType.Email)
    ],
    'code': [
      Rule(require: true, message: '请输入验证码')
    ]
  };

  Map ruleEmail = {
    'email': [
      Rule(require: true, message: '请输入邮箱'),
      Rule(message: '邮箱格式不正确', type: ruleType.Email)
    ]
  };

  _getCode() async{
    bool validateState = Utils.validate(fromData, ruleEmail, context);
    var sendData = {
      'username': fromData['email'],
      'terminal_type': 'jingyi'
    };
    if(validateState){
      ToastWidget.loading(context, message: '获取中...', duration: 0);
      try{
        await getVerificationCode(sendData, context);
        ToastWidget(context, '验证码已发至邮箱，请注意查收');
        setState(() {
          flag = false;
        });
      }catch(err){
        ToastWidget.clear();
      }
    }
  }

  _nextStep() async{

    bool validateState = Utils.validate(fromData, rule, context);

    if(validateState){
      try{
        var sendData = {
          'code': fromData['code'],
          'username': fromData['email']
        };
        ToastWidget.loading(context, duration: 0);
        await verificationCode(sendData, context);
        ToastWidget.clear();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_){
            return SetPassword(
              code: fromData['code'],
              username: fromData['email'],
            );
          }
        ));

      }catch(err){
        ToastWidget.clear();
      }
    }



  }

  _onChang(){
    setState(() {
      flag = true;
    });
  }


}

class TimerCode extends StatefulWidget {

  TimerCode({Key key, this.onChang}):super(key: key);

  final Function onChang;

  @override
  _TimerCodeState createState() => _TimerCodeState();
}

class _TimerCodeState extends State<TimerCode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("${second}s", style:TextStyle(
          fontSize: ScreenUtil().setSp(14),
          color: Color(0xff4B74FF),
          fontWeight: FontWeight.w600
      )),
    );
  }

  Timer timer;

  int second = 60;

  void time(){
    timer = Timer.periodic(Duration(seconds: 1), (Timer t){
      if(second == 0){
        timer.cancel();
        widget.onChang();
        return;
      }
      setState(() {
        second --;
      });
    });
  }

  @override
  void initState() {
    time();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

