import 'dart:async';

import 'package:flutter/material.dart';
import '../../common/components/Appbar.dart';
import '../../common/components/Search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/components/ListView.dart';
import '../../common/components/FutureBuilder.dart';
import '../../api/merchant.api.dart';
import '../../model/merchant.dart';
import 'dart:convert';


class ShanghuPage extends StatefulWidget {
  @override
  _ShanghuPageState createState() => _ShanghuPageState();
}

class _ShanghuPageState extends State<ShanghuPage>  with AutomaticKeepAliveClientMixin {


  int page = 1;
  int pageSize = 10;
  int total = 0;
  List result = [];

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
              plplaceholder: '请输入商户名称',
            ),
            _divider(),
            Expanded(
              flex: 1,
              child: FutureBuilderWidget(
                future: _future,
                body: (AsyncSnapshot snapshot){
                  var data = json.decode(snapshot.data.toString());
                  MerchantList merchantList = MerchantList.fromJson(data['results']);
                  result = merchantList.data;
                  total = data['count'];
                   return ListWidget(
                     total: total,
                     results: result,
                     refresh: _refresh,
                     itemWidget: _itemWidget,
                     loadMore: _loadMore,
                   );
                },
              ),
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

  Future _refresh() async{
    Completer completer = Completer();
    try{
      page = 1;
      var result = await _future();
      var data = json.decode(result.toString());
      MerchantList merchantList = MerchantList.fromJson(data['results']);
      print(merchantList.data.length);
      completer.complete(merchantList.data);
    }catch(err){
      completer.completeError(err);
    }
    return completer.future;
  }

  Future _loadMore() async{
    Completer completer = Completer();
    try{
      if(page * pageSize < total){
        page++;
        var result = await _future();
        var data = json.decode(result.toString());
        MerchantList merchantList = MerchantList.fromJson(data['results']);
        completer.complete(merchantList.data);
      }else{
        completer.complete([]);
      }
    }catch(err){
      completer.completeError(err);
    }

    return completer.future;
  }

  Future _future() async {
    var sendData = {
      'page': page,
      'page_size': pageSize,
      'name': ''
    };
    print('_future');
    return getMerchantList(sendData, context);
  }

  @override
  void initState() {
    print('initState');
    super.initState();
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
              print("丁阿基");
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
}


