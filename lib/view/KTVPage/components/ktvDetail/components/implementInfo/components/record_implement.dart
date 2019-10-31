import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/Empty.dart';
import 'package:jy_h5/common/components/ListView.dart';
import 'package:jy_h5/common/components/loading.dart';
import 'package:jy_h5/common/components/Error.dart';
import 'package:jy_h5/model/ktv.dart';
import 'package:jy_h5/api/ktv.api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImplementRecord extends StatefulWidget {

  ImplementRecord({Key key, this.ktvID}):super(key: key);

  final int ktvID;

  @override
  _ImplementRecordState createState() => _ImplementRecordState();
}

class _ImplementRecordState extends State<ImplementRecord> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            AppTitle(
              hasBack: true,
              title: '实施记录',
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
      ),
    );
  }

  Widget _itemWidget(index, list){
    return ItemWidget(implement: list[index],);
  }

  Widget _emptyWidget(){
    return Empty(
      text: '暂无实施记录',
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
      'ktv': widget.ktvID
    };
    try{
      var results = await getImplementList(sendData, context);
      total = json.decode(results.toString())['count'];
      var data = json.decode(results.toString())['results'].map((item){
        return Implement.fromJson(item);
      }).toList();
      if(data.length > 0){
        pageStatues = 2;
      }else{
        pageStatues = 4;
      }
      setState(() {});
      completer.complete(data);
    }catch(err){
      setState(() {
        pageStatues = 3;
      });
      completer.completeError(err);
    }
    return completer.future;
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
        var data = await getData();
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

  initData() async{
    try{
      dataList = await getData();
    }catch(err){
      print(err);
    }
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
    this.implement
  }):super(key: key);

  final Implement implement;


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(10)
      ),
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(12)
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(implement.brand, style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: ScreenUtil().setSp(14),
                color: Colors.black
              ),),
              Text(implement.implementBoxCount, style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenUtil().setSp(16),
                  color: Colors.black
              ),)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(implement.vodVersion, style: TextStyle(
                fontSize: ScreenUtil().setSp(12),
                color: Colors.grey
              ),),
              Text("包厢数", style: TextStyle(
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey
              ),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("vod场所ID:${implement.vodKtvId}",style: TextStyle(
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey
              ),),
              Text("实施时间：${implement.updateDate}",style: TextStyle(
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.grey
              ),)
            ],
          ),
        ],
      ),
    );
  }
}
