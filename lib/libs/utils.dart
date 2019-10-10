import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

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


}