import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/Empty.dart';
import 'package:jy_h5/common/components/ListView.dart';
import 'package:jy_h5/common/components/loading.dart';
import 'package:jy_h5/common/components/Error.dart';
import 'package:jy_h5/common/components/ListItem.dart';
import 'package:jy_h5/model/ktv.dart';
import 'package:jy_h5/api/ktv.api.dart';


class RecordUpgrade extends StatefulWidget {

  RecordUpgrade({Key key, this.ktvID}):super(key: key);

  final int ktvID;

  @override
  _RecordUpgradeState createState() => _RecordUpgradeState();
}

class _RecordUpgradeState extends State<RecordUpgrade> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AppTitle(
            hasBack: true,
            title: '升级记录',
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: (){
                if(pageStatues == 1){
                  return Center(
                    child: Loading(),
                  );
                }else if(pageStatues == 2){
                  return ListWidget(
                    total: total,
                    results: dataList,
                    refresh: _refresh,
                    itemWidget: _itemWidget,
                    loadMore: _loadMore,
                  );
                }else if(pageStatues == 3){
                  return Center(
                    child: Error(
                      reload: _reload,
                    ),
                  );
                }else{
                  return _emptyWidget();
                }
              }(),
            ),
          )
        ],
      ),
    );
  }

  Widget _itemWidget(index, list){
    return ItemWidget(vodUpgradeRecord: list[index],);
  }

  Widget _emptyWidget(){
    return Empty(
      text: '暂无升级记录',
    );
  }


  int pageStatues = 1;
  int page = 1;
  int pageSize = 20;
  int total = 0;
  List dataList = [];




  Future getData() async{
    Completer completer = Completer();
    var sendData = {
      'page': page,
      'page_size': pageSize,
      'vod_ktv': widget.ktvID
    };
    try{
      var results = await upgradeRecord(sendData, context);
      var data = json.decode(results.toString())['results'].map((item){
        return VodUpgradeRecord.fromJson(item);
      }).toList();
      if(data.length > 0){
        pageStatues = 2;
      }else{
        pageStatues = 4;
      }
      setState(() {});
      total = json.decode(results.toString())['count'];
      print(total);
      completer.complete(data);
    }catch(err){
      setState(() {
        pageStatues = 3;
      });
      completer.completeError(err);
    }
    return completer.future;
  }

  initData() async{
    try{
      dataList = await getData();
    }catch(err){
      print(err);
    }
  }

  Future _refresh() async{
    Completer completer = Completer();
    try{
      page = 1;
      var data = await getData();
      completer.complete(data);
      setState(() {
        dataList = data;
      });
    }catch(err){
      completer.completeError(err);
    }
    return completer.future;
  }


  Future _loadMore() async{
    Completer completer = Completer();

    try{
      if(page * pageSize <= total){
        page++;
        var sendData = {
          'page': page,
          'page_size': pageSize,
          'vod_ktv': widget.ktvID
        };
        var results = await upgradeRecord(sendData, context);
        var data = json.decode(results.toString())['results'].map((item){
          return VodUpgradeRecord.fromJson(item);
        }).toList();

        setState(() {
          dataList.addAll(data);
        });
        completer.complete(data);
      }else{
        completer.complete(null);
      }
    }catch(err){
      page--;
      setState(() {
        pageStatues = 3;
      });
      completer.completeError(err);
    }

    return completer.future;
  }

  _reload() async{
    setState(() {
      pageStatues = 1;
    });
    dataList = await getData();
  }

  @override
  void initState() {
    initData();
    super.initState();
  }
}

class ItemWidget extends StatelessWidget {

  ItemWidget({
    Key key,
    this.vodUpgradeRecord
  }):super(key: key);

  final VodUpgradeRecord vodUpgradeRecord;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListItem(
        title: vodUpgradeRecord.newVersion,
        label: vodUpgradeRecord.updateDate,
      ),
    );
  }
}

