import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

import 'package:toast/toast.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class Utils{

  static Future getToken() async{
    Completer completer = new Completer();
    try{
      SharedPreferences prefs = await _prefs;
      print('getToken');
      completer.complete(prefs.getString('token'));
    }catch(err){
      completer.completeError(err);
    }
    return completer.future;
  }

  static Future setToken(String token) async{
    Completer completer = new Completer();
    try{
      SharedPreferences prefs = await _prefs;
      print('setToken');
      completer.complete(prefs.setString('token', token));
    }catch(err){
      completer.completeError(err);
    }
    return completer.future;
  }

  static Future removeToken() async{
    Completer completer = new Completer();
    try{
      SharedPreferences prefs = await _prefs;
      print('removeToken');
      prefs.remove('token');
      completer.complete();
    }catch(err){
      completer.completeError(err);
    }
    return completer.future;
  }



  static String getRandomNumber(){
    String alphabet = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    int strLength = 30;
    String result = '';
    for(var i = 0; i < strLength; i++){
      result = result + alphabet[Random().nextInt(alphabet.length)];
    }
    return result;
  }

  static bool validate(Map fromData, Map rules, BuildContext context){
    Map result = {};
    rules.forEach((item, value){
      var rule = rules[item];
      if(rule.require){
        if(fromData[item] == ''){
          result[item] = false;
          return;
        }
      }
    });
    String name;
    result.forEach((key, value){
      if(name == null && !value){
        name = key;
      }
    });
    if(name != null){
      Toast.show(rules[name].message, context);
    }

    return name == null ? true:false;

  }


}