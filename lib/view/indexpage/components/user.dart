import 'package:flutter/material.dart';
import 'package:jy_h5/common/components/ListPicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/components/Dialog.dart';
import 'package:jy_h5/store/model/loginModel.dart';
import 'package:provider/provider.dart';


class User{

  static foo(BuildContext context){
    Login login = Provider.of<Login>(context);
    ListPicker.pickerList(
        context,
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Center(
                  child: Text("管理员", style: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                    color: Color.fromRGBO(119, 119, 119, 1),
                    decoration: TextDecoration.none,
                  ),),
                ),
              ),
              Divider(
                height: 1,
                color: Color.fromRGBO(235, 237, 240, 1),
              ),
              Expanded(
                flex: 1,
                child: FlatButton(
                  child: Center(
                    child: Text("退出", style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      color: Color.fromRGBO(119, 119, 119, 1),
                      decoration: TextDecoration.none,
                    ),),
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                    Future.delayed(Duration(milliseconds: 200),(){
                      DialogWidget.confirm(context, title: "提示", message: "是否要退出登录？").then((val){
                        if(val == 'ok'){
                          login.logOut().then((e){
                            Navigator.of(context).pushNamed('login');
                          });
                        }
                      });
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        height: ScreenUtil().setHeight(146),
        isShowTitle: true,
        onSelected: (){
          print("ppppp");
        }
    );
  }

}