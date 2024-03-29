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

  static Future getLocalData(String key) async{
    Completer completer = new Completer();
    try{
      SharedPreferences prefs = await _prefs;
      print('getLocalData');
      completer.complete(prefs.getString(key));
    }catch(err){
      completer.completeError(err);
    }
    return completer.future;
  }

  static Future setLocalData(String key, String value) async{
    Completer completer = new Completer();
    try{
      SharedPreferences prefs = await _prefs;
      print('setLocalData');
      completer.complete(prefs.setString(key, value));
    }catch(err){
      completer.completeError(err);
    }
    return completer.future;
  }

  static Future removeLocalData(String key) async{
    Completer completer = new Completer();
    try{
      SharedPreferences prefs = await _prefs;
      print('removeLocalData');
      prefs.remove(key);
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

     List ruleList = rules[item];

     for(var i = 0; i < ruleList.length; i++){
       if(!ruleList[i].validate(fromData[item])){
         result[item] = ruleList[i].message;
         return;
       }
     }

    });
    print(result);
    String errorMsg;
    result.forEach((key, value){
      if(errorMsg == null){
        errorMsg = value;
      }
    });
    if(errorMsg != null){
      Toast.show(errorMsg, context, gravity: 1);
    }

    return errorMsg == null ? true:false;

  }

  // 将2019-8-9的时间格式转为2019年8月9日
  static String dateChang(String date){

    List<String> arr = date.split('-');

    return "${arr[0]}年${arr[1]}月${arr[2]}日";

  }

  // 将数组的每一天转换为星期天对应的日期

  static String weekChang(int number){

    var result;
    switch(number){
      case 1:
        result = "星期一";
        break;
      case 2:
        result = '星期二';
        break;
      case 3:
        result = '星期三';
        break;
      case 4:
        result = '星期四';
        break;
      case 5:
        result = '星期五';
        break;
      case 6:
        result = '星期六';
        break;
      case 7:
        result = '星期日';
        break;
    }

    return result;
  }



}