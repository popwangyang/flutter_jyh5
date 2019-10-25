import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import '../../api/ktv.api.dart';
import '../../common/components/Appbar.dart';
import '../../common/components/Search.dart';
import '../../common/components/ListView.dart';
import 'package:jy_h5/common/components/loading.dart';
import 'package:jy_h5/common/components/Error.dart';
import '../../model/ktv.dart';
import 'components/ktvDetail/ktvDetail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




class KtvPage extends StatefulWidget {
  @override
  _KtvPageState createState() => _KtvPageState();
}

class _KtvPageState extends State<KtvPage>  with AutomaticKeepAliveClientMixin  {

  List dataList = [];
  int total;
  int page = 1;
  int pageSize = 20;

  int pageStatues = 1;  // 页面状态 1为加载中，2为加载成功，3为加载失败，4为数据为空

  @override
  bool get wantKeepAlive =>true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            AppTitle(
              title: 'KTV管理',
            ),
            Search(
              placeholder: '请输入KTV名称',
            ),
            _divider(),
            Expanded(
              flex: 1,
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
                  return Center(
                    child: Text("数据为空"),
                  );
                }
              }(),
            )
          ],
        ),
      ),
    );
  }

  Widget _divider(){
    return Divider(
      height: 1,
      color: Color.fromRGBO(246, 246, 246, 1),
    );
  }

  Widget _itemWidget(index, list){
    return ItemWidget(ktv: list[index],);
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  _reload() async{
    setState(() {
      pageStatues = 1;
    });
    await getData();
  }

  Future _refresh() async{
    Completer completer = Completer();
    try{
      page = 1;
      KtvList ktvList = await getData();
      setState(() {
        dataList = ktvList.data;
      });
      completer.complete(ktvList.data);
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
          'name': ''
        };
        var results = await getKTVList(sendData, context);
        var data = json.decode(results.toString());
        KtvList ktvList  = KtvList.fromJson(data['results']);
        setState(() {
          dataList.addAll(ktvList.data);
        });
        completer.complete(ktvList.data);
      }else{
        completer.complete([]);
      }
    }catch(err){
      page--;
      completer.completeError(err);
    }
    return completer.future;
  }

  initData() async{
    try{
      KtvList ktvList = await getData();
      dataList = ktvList.data;
    }catch(err){
      print(err);
    }
  }

  Future getData() async{
    Completer completer = Completer();
    var sendData = {
      'page': page,
      'page_size': pageSize,
      'name': ''
    };
    try{
      var results = await getKTVList(sendData, context);
      var data = json.decode(results.toString());
      KtvList ktvList = KtvList.fromJson(data['results']);
      if(ktvList.data.length > 0){
        pageStatues = 2;
      }else{
        pageStatues = 4;
      }
      setState(() {});
      total = data['count'];
      completer.complete(ktvList);
    }catch(err){
      setState(() {
        pageStatues = 3;
      });
      completer.completeError(err);
    }
    return completer.future;
  }
}

class ItemWidget extends StatelessWidget {

  final KTV ktv;
  ItemWidget({Key key, this.ktv}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        title: Text('${ktv.name}',style: TextStyle(
            fontSize: ScreenUtil.getInstance().setSp(14),
            color: Color.fromRGBO(68, 68, 68, 1),
            fontWeight: FontWeight.w400
        ),),
        trailing: Icon(Icons.arrow_forward_ios, size: ScreenUtil.getInstance().setSp(16), color: Color.fromRGBO(153, 153, 153, 1),),
        onTap: (){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_){
                  return KtvDetail(ktv: ktv,);
                })
          );
        },
        subtitle:  _subtitle(),
      ),
    );
  }

  Widget _subtitle(){

    TextStyle textStyle = TextStyle(
      fontSize: ScreenUtil().setSp(8),
      color: Colors.white,
      fontWeight: FontWeight.w400,
    );

    return Container(
      child: Row(
        children: <Widget>[
          (){
            if(ktv.type == 1){
              return Container(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(4), right: ScreenUtil().setWidth(4)),
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(8)),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color.fromRGBO(241, 194, 135, 1), Color.fromRGBO(204, 152, 88, 1)])
                ),
                child: Text("量贩",style: textStyle,),
              );
            }else{
              return Container(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(4), right: ScreenUtil().setWidth(4)),
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(8)),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Color.fromRGBO(41, 241, 245, 1), Color.fromRGBO(43, 196, 211, 1)])
                ),
                child: Text("夜总会",style: textStyle,),
              );
            }
          }(),
          Container(
            width: ScreenUtil().setWidth(100),
            child: Text("${ktv.merchant_name}", style: TextStyle(
              color: Color.fromRGBO(153, 153, 153, 1),
              fontSize: ScreenUtil.getInstance().setSp(10),
              fontWeight: FontWeight.w400,
            ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          )
          
        ],
      ),
    );
  }
}

