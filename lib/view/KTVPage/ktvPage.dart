import 'dart:convert';

import 'package:flutter/material.dart';
import '../../api/ktv.api.dart';
import '../../common/components/Appbar.dart';
import '../../common/components/Search.dart';
import '../../common/components/ListView.dart';
import '../../common/components/FutureBuilder.dart';
import '../../model/ktv.dart';


class KtvPage extends StatefulWidget {
  @override
  _KtvPageState createState() => _KtvPageState();
}

class _KtvPageState extends State<KtvPage> {
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
              plplaceholder: '请输入KTV名称',
            ),
            _divider(),
            Expanded(
              flex: 1,
              child: FutureBuilderWidget(
                future: _future,
                body: (AsyncSnapshot snapshot){
                  print(snapshot.data);
                  var data = json.decode(snapshot.data.toString());
                  KtvList ktvList = KtvList.fromJson(data['results']);

                  print(ktvList.data.length);

                  return Text("我是新数据");
                },
              ),
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

  @override
  void initState() {
    // TODO: implement initState
    _future();
    super.initState();
  }

  Future _future(){
    var sendData = {
      'page': 1,
      'page_size': 10,
    };
    return getKTVList(sendData, context);
  }
}
