import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/api/ktv.api.dart';
import 'package:jy_h5/common/components/loading.dart';
import 'package:jy_h5/common/components/Error.dart';
import 'package:jy_h5/common/components/Empty.dart';
import 'package:jy_h5/common/components/ListView.dart';
import 'package:jy_h5/model/contract.dart';
import 'package:jy_h5/model/recharge.dart';
import 'dart:async';
import 'dart:convert';

class RechargeRecord extends StatefulWidget {

  RechargeRecord({
    Key key,
    this.ktvID
  }):super(key: key);

  final int ktvID;

  @override
  _RechargeRecordState createState() => _RechargeRecordState();
}

class _RechargeRecordState extends State<RechargeRecord> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            AppTitle(
              title: '充值列表',
              hasBack: true,
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
    return ItemWidget(
      rechargeRecordModal: list[index],
      isLast: list.length == (index + 1) ? true:false,
    );
  }

  Widget _emptyWidget(){
    return Empty(
      text: '暂充值信息',
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
      'place_id': widget.ktvID,
      'order': 'create_date',
      'platform': 3
    };
    try{
      var results = await getRechargeRecord(sendData, context);
      total = json.decode(results.toString())['count'];
      var data = json.decode(results.toString())['results'].map((item){
        return RechargeRecordModal.fromJson(item);
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
    this.rechargeRecordModal,
    this.isLast = false
  }):super(key: key);

  final RechargeRecordModal rechargeRecordModal;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    TextStyle style1 = TextStyle(
      fontSize: ScreenUtil().setSp(14),
      color: Color(0xff323233)
    );
    TextStyle style2 = TextStyle(
      fontSize: ScreenUtil().setSp(16),
      fontWeight: FontWeight.w600,
      color: Colors.red
    );
    TextStyle style3 = TextStyle(
        fontSize: ScreenUtil().setSp(14),
        color: Color(0xff969799)
    );
    TextStyle style4 = TextStyle(
        fontSize: ScreenUtil().setSp(12),
        color: Color(0xff969799)
    );
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(10),
              vertical: ScreenUtil().setHeight(10)
          ),
          child:Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(6)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(rechargeRecordModal.packageName, style: style1,),
                    Text("+${rechargeRecordModal.arrivalAmount}", style: style2,)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(0)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("包厢数：${rechargeRecordModal.boxCount}", style: style4,),
                    Text(rechargeRecordModal.rechargeStatus, style: style3,)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(4)
                ),
                alignment: Alignment.centerLeft,
                child: Text('套餐类型：${rechargeRecordModal.packageTypeDisplay}', style: style4,),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(3)
                ),
                alignment: Alignment.centerLeft,
                child: Text(rechargeRecordModal.createDate, style: style4,),
              )
            ],
          ),
        ),
        Opacity(
          opacity: isLast ? 0:1,
          child: Divider(
            height: 1,
            color: Color(0xffF6F6F6),
            indent: ScreenUtil().setWidth(10),
          ),
        )
      ],
    );
  }
}