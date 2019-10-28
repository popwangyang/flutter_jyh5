import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../api/login.api.dart';
import '../../api/merchant.api.dart';
import '../../model/user.dart';
import '../../model/brand.dart';
import 'dart:async';
import 'dart:convert';
import '../../libs/utils.dart';

class Login with ChangeNotifier {
  User _user;
  List  companyBrands;

  User get user => _user;

  Future getLogin(Map fromData, BuildContext context) async{
    Completer completer = new Completer();

    var params = {
      'username': fromData['username'],
      'password': fromData['password'],
      'terminal_type': "jingyi"
    };
    try{
      var res = await login(params, context,);
      var userData = res.data['user'];
          userData['username'] = fromData['username'];
          userData['password'] = fromData['password'];
          userData['autoLogin'] = true;
      _user = User.fromJson(userData);
      await Utils.setToken(res.data['token']);
      await Utils.setLocalData('user', json.encode(_user.toJson()));
      print(_user);
      completer.complete(_user);
    }catch(err){
      completer.completeError(err);
    }
    return completer.future;
  }

  initUser() async{
    var user = await Utils.getLocalData('user');
    if(user != null){
      _user = User.fromJson(json.decode(user));
    }
  }

  Future logOut() async{
    Completer completer = Completer();
    try{
      await Utils.removeToken();
      user.autoLogin = false;
      await Utils.setLocalData('user', json.encode(user.toJson()));
      companyBrands = null;
      completer.complete('ok');
    }catch(error){
      completer.completeError(error);
    }
    return completer.future;
  }

  Future getLoginInfo(BuildContext context) async{
    if(companyBrands == null){
      var result = await getCompanyBrandList(null, context);  // 登录获取品牌列表
      var data = json.decode(result.toString())['results'];
      companyBrands = data.map((item) => CompanyBrands.fromJson(item)).toList();
    }

  }

}