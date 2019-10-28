import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Ktv with ChangeNotifier{
  int _ktvID;

  int get ktvID => _ktvID;

  void setKtvID(int id){
    _ktvID = id;
  }

}