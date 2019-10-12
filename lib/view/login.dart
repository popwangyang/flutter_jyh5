import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../store/model/loginModel.dart';
import '../libs/utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375, height: 667)..init(context);

    final login = Provider.of<Login>(context);
    return Container(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(

          ),
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text("登录"),
                onPressed: () async{
                  login.getLogin('admin@hlchang.cn', 'abc12345').then((val) {
                    Utils.getToken().then((val){
//                   print(val);
                    });
                  }).catchError((err){
                    print(err);
                  });
                },
              ),
              RaisedButton(
                child: Text("退出"),
                onPressed: () async{
                  await Utils.removeToken();
                  print("token清除了");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
