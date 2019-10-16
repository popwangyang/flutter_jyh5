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
  User user;
  List  companyBrands;

  Future getLogin(Map fromData, BuildContext context) async{
    Completer completer = new Completer();

    var params = {
      'username': fromData['username'],
      'password': fromData['password'],
      'terminal_type': "jingyi"
    };
    try{
      var res = await login(params, context,);
      print(params);
      user = User.fromJson(res.data);
      await Utils.setToken(user.token);
      var result = await getCompanyBrandList(null, context);  // 登录获取品牌列表
      var data = json.decode(result.toString())['results'];
      companyBrands = data.map((item) => CompanyBrands.fromJson(item)).toList();
      completer.complete(user);
    }catch(err){
      completer.completeError(err);
    }
    return completer.future;
  }

}