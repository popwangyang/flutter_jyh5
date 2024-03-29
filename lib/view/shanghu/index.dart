import 'dart:async';
import 'package:flutter/material.dart';
import '../../common/components/Appbar.dart';
import '../../common/components/Search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/components/ListView.dart';
import '../../api/merchant.api.dart';
import '../../model/merchant.dart';
import 'components/detail/detail.dart';
import 'package:jy_h5/common/components/loading.dart';
import 'package:jy_h5/common/components/Error.dart';
import 'package:jy_h5/view/Search/search.dart' as SearchPage;
import 'dart:convert';
import '../../api/ktv.api.dart';

class ShanghuPage extends StatefulWidget {
  @override
  _ShanghuPageState createState() => _ShanghuPageState();
}

class _ShanghuPageState extends State<ShanghuPage>  with AutomaticKeepAliveClientMixin {


  int page = 1;
  int pageSize = 10;
  int total = 0;
  List dataList = [];

  int pageStatues = 1;  // 页面状态 1为加载中，2为加载成功，3为加载失败，4为数据为空

  @override
  bool get wantKeepAlive =>true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            AppTitle(
              title: '商户管理',
            ),
            Search(
              placeholder: '请输入商户名称',
              inputBtn: () async{
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return SearchPage.Search(
                        placeholder: '请输入商户名称',
                        pageTitle: '',
                        searchFun: _searchFun,
                        btnItemFun: _btnItemFun,
                      );
                    })
                );
              },
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






  Widget _itemWidget(index, list){
    return ItemWidget(merchant: list[index],);
  }



  Widget _divider(){
    return Divider(
      height: 1,
      color: Color.fromRGBO(246, 246, 246, 1),
    );
  }

  _btnItemFun(data){
    print(data);
    Navigator.of(context).pushReplacement( // pushReplacement 指把当前页面在栈中的位置替换成跳转的页面
        MaterialPageRoute(builder: (_) {
          return MerchantDetail(
            merchant: Merchant.fromJson(data),
          );
        })
    );
  }

  _searchFun(data) async{
    Completer completer = Completer();
    try{
      var result = await getMerchantList(data, context);
      var dataList = json.decode(result.toString())['results'];
      completer.complete(dataList);
    }catch(err){
      completer.completeError(err);
    }
    return completer.future;
  }


  Future _refresh() async{
    Completer completer = Completer();
    try{
      page = 1;
      MerchantList merchantList = await getData();
      completer.complete(merchantList.data);
      setState(() {
        dataList = merchantList.data;
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
          'name': ''
        };
        var results = await getMerchantList(sendData, context);
        var data = json.decode(results.toString());
        MerchantList merchantList = MerchantList.fromJson(data['results']);
        setState(() {
          dataList.addAll(merchantList.data);
        });
        completer.complete(merchantList.data);
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
    MerchantList merchantList = await getData();
    dataList = merchantList.data;
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async{
    try{
      MerchantList merchantList = await getData();
      dataList = merchantList.data;
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
      var results = await getMerchantList(sendData, context);
      var data = json.decode(results.toString());
      MerchantList merchantList = MerchantList.fromJson(data['results']);
      if(merchantList.data.length > 0){
          pageStatues = 2;
      }else{
        pageStatues = 4;
      }
      setState(() {});
      total = data['count'];
      completer.complete(merchantList);
    }catch(err){
      print("$err+++++++++++++++");
      setState(() {
        pageStatues = 3;
      });
      completer.completeError(err);
    }
    return completer.future;
  }


}

class  ItemWidget extends StatelessWidget {

  final Merchant merchant;

  ItemWidget({Key key, this.merchant}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(merchant.name, style: TextStyle(
                fontSize: ScreenUtil.getInstance().setSp(14),
                color: Color.fromRGBO(68, 68, 68, 1),
                fontWeight: FontWeight.w400
            ),),
            subtitle: Text("${merchant.merchantAmount}家厂所", style: TextStyle(
              color: Color.fromRGBO(153, 153, 153, 1),
              fontSize: ScreenUtil.getInstance().setSp(10),
              fontWeight: FontWeight.w400,
            ),),
            trailing: Icon(Icons.arrow_forward_ios, size: ScreenUtil.getInstance().setSp(16), color: Color.fromRGBO(153, 153, 153, 1),),
            onTap: (){
              _goDetail(merchant, context);
            },
          ),
          _divider(),
        ],
      ),
    );
  }

  Widget _divider(){
   return Divider(
      height: 1,
      color: Color.fromRGBO(246, 246, 246, 1),
     );
  }


  _goDetail(merchant, context){
    Navigator.of(context).push(
        new MaterialPageRoute(builder: (_) {
           return MerchantDetail(merchant: merchant,);
        }));
  }
}


