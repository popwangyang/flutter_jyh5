import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../api/login.api.dart';
import '../../model/user.dart';
import 'dart:async';
import '../../libs/utils.dart';

class Login with ChangeNotifier {
  User user;

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
      completer.complete(user);
    }catch(err){
      completer.completeError(err);
    }
    return completer.future;
  }

}