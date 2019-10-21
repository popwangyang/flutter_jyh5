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
      _user = User.fromJson(userData);
      await Utils.setToken(res.data['token']);

      await Utils.setLocalData('user', json.encode(_user.toJson()));
      var result = await getCompanyBrandList(null, context);  // 登录获取品牌列表
      var data = json.decode(result.toString())['results'];
      companyBrands = data.map((item) => CompanyBrands.fromJson(item)).toList();
      completer.complete(_user);
    }catch(err){
      completer.completeError(err);
    }
    return completer.future;
  }

  initUser() async{
    var user = await Utils.getLocalData('user');
    _user = User.fromJson(json.decode(user));
  }

}