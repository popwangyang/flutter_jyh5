import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/api/ktv.api.dart';
import 'package:jy_h5/common/components/loading.dart';
import 'package:jy_h5/common/components/Error.dart';
import 'package:jy_h5/common/components/Empty.dart';
import 'package:jy_h5/common/components/ListView.dart';
import 'package:jy_h5/model/contract.dart';
import 'dart:async';
import 'dart:convert';

class PastContract extends StatefulWidget {

  PastContract({
    Key key,
    this.ktvID
  }):super(key: key);

  final int ktvID;

  @override
  _PastContractState createState() => _PastContractState();
}

class _PastContractState extends State<PastContract> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            AppTitle(
              hasBack: true,
              title: '往期合同',
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
    return ItemWidget(contractDetail: list[index],);
  }

  Widget _emptyWidget(){
    return Empty(
      text: '暂无往期合同',
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
      'ktv': widget.ktvID,
      'state': '2,3'
    };
    try{
      var results = await getContract(sendData, context);
      total = json.decode(results.toString())['count'];
      var data = json.decode(results.toString())['results'].map((item){
        return ContractDetail.fromJson(item);
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
    this.contractDetail
  }):super(key: key);

  final ContractDetail contractDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text("合同编号"),
        subtitle: Text('2019-10-1 ~ 2020-10-1'),
        trailing: Container(
          child: Row(
            children: <Widget>[
              Text("已终止"),
              Icon(Icons.keyboard_arrow_right)
            ],
          ),
        ),
      ),
    );
  }
}

