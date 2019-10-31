// 依赖包
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

// 自定义组件
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/PageContent.dart';
import 'package:jy_h5/common/components/Empty.dart';
import 'package:jy_h5/common/components/Button.dart';
import 'package:jy_h5/api/ktv.api.dart';
import 'package:jy_h5/model/ktv.dart';

import 'package:provider/provider.dart';
import 'package:jy_h5/store/model/ktvModel.dart';

import 'implement_edited.dart';
import 'implement_detail.dart';

class ImplementPage extends StatefulWidget {

  ImplementPage({Key key, this.ktvID}):super(key: key);

  final int ktvID;

  @override
  _ImplementPageState createState() => _ImplementPageState();
}

class _ImplementPageState extends State<ImplementPage> {
  @override
  Widget build(BuildContext context) {
    ktv = Provider.of<Ktv>(context);
    init();
    return Scaffold(
      body: Column(
        children: <Widget>[
          AppTitle(
            hasBack: true,
            title: '实施信息',
          ),
          Expanded(
            flex: 1,
            child: PageContent(
              pageStatues: pageStatues,
              content: _content,
              reload: getData,
              emptyWidget: _emptyWidget(),
            ),
          )
        ],
      ),
    );
  }

  int pageStatues = 1;
  Ktv ktv;
  Implement _implementDetail;  // 实施信息

  Widget _emptyWidget(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Empty(
            text: '暂无实施信息',
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(10)
            ),
            child:  ButtonCircle(
              text: '新建实施信息',
              onClick: () async{
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_){
                      return ImplementEdited();
                    }
                  )
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _content(){
    return Container(
      child: ImplementDetail(
        implement: _implementDetail,
        ktvID: widget.ktvID,
      ),
    );
  }

  @override
  void initState(){
    // TODO: implement initState
    getData();
    super.initState();
  }

  init() async{
    var sendData = {
      'state': 1
    };
    await ktv.getVod(sendData, context);
  }

  getData() async{
    setState(() {
      pageStatues = 1;
    });
    try{
      var res = await getImplement(widget.ktvID, context);
      var result = json.decode(res.toString())['results'];
      print(result);
      if(result.length > 0){
        pageStatues = 2;
        _implementDetail = Implement.fromJson(result[0]);
      }else{
        pageStatues = 4;
      }
      setState(() {});
    }catch(err){
      setState(() {
        pageStatues = 3;
      });
    }
  }



}
