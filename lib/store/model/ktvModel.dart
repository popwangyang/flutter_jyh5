import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jy_h5/model/vod.dart';
import 'package:jy_h5/api/ktv.api.dart';
import 'dart:async';

class Ktv with ChangeNotifier{
  int _ktvID;

  int get ktvID => _ktvID;

  List _vodList;

  List get vodList => _vodList;

  int _accountStatus;

  int get accountStatus => _accountStatus;

  String _chargeableTime;

  String get chargeableTime => _chargeableTime;

  int _boxCount;

  int get boxCount => _boxCount;

  String _balance;

  String get balance => _balance;

  void setKtvBalance(String balance){
    _balance = balance;
  }

  void setBoxCount(int count){
    _boxCount = count;
  }

  void setChargeableTime(String date){
    _chargeableTime = date;
  }

  void setKtvID(int id){
    _ktvID = id;
  }

  void setAccountStatus(int status){
    _accountStatus = status;
    notifyListeners();
  }

  Future getVod(params, context) async{
    Completer completer = new Completer();

    try{
      var res =  await getVodList(params, context);
      var data = json.decode(res.toString())['results'];
      _vodList = data.map((item){
        return VODProvider.fromJson(item);
      }).toList();
      print(_vodList);
      completer.complete(true);
    }catch(err){
      print(err);
      completer.complete(err);
    }
    return completer.future;
  }

}