import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/components/Appbar.dart';
import 'components/searchComponent.dart';
import 'package:jy_h5/api/ktv.api.dart';
import 'package:jy_h5/model/ktv.dart';

class Search extends StatefulWidget {
  final String pageTitle;
  final String placeholder;
  final Function searchFun;

  Search({
    Key key,
    this.pageTitle,
    this.placeholder,
    this.searchFun
  }): super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  bool isLoading;
  List dataList;
  int pageStatues;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            AppTitle(
              title: widget.pageTitle,
              hasBack: true,
            ),
            SearchWidget(
              placeHolder: widget.placeholder,
              onChange: search,
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: contentWidget(),
              ),
            )
          ],
        ),
      ),
    );
  }

  // 加载内容
  Widget contentWidget(){
    return (){
      if(pageStatues == 0){
        return Container();
      }else if(pageStatues == 1){
        return Container(
          margin: EdgeInsets.only(top: 120),
          child: Text("加载中..."),
        );
      }else if(pageStatues == 2){
        return Container(
          margin: EdgeInsets.only(top: 120),
          child: Text("暂无内容"),
        );
      }else{
        return Container(
          color: Colors.white,
          child: Column(
            children: dataList.map((item){
              return itemWidget(item);
            }).toList(),
          ),
        );
      }
    }();
  }

  // 加载子项
  Widget itemWidget(item){
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          FlatButton(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(15),
                right: ScreenUtil().setWidth(15),
                top: ScreenUtil().setHeight(14),
                bottom: ScreenUtil().setHeight(14),
              ),
              child: Text(
                item['name'],
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(14),
                  color: Color.fromRGBO(102, 102, 102, 1),
                ),
              ),
            ),
            onPressed: (){
              print(item);
              Navigator.of(context).pop(item);
            },
          ),
          Divider(
            height: 1,
            color: Color.fromRGBO(246, 246, 246, 1),
          )
        ],
      ),
    );
  }

  search(e) async{
    print(e);
    if(e != ''){
      var sendData = {
        'name': e
      };
      setState(() {
        pageStatues = 1;
      });

      var data = await widget.searchFun(sendData);
      if(data.length > 0){
        setState(() {
          pageStatues = 3;
          dataList = data;
        });
      }else{
        setState(() {
          pageStatues = 2;
        });
      }
    }else{
      setState(() {
        pageStatues = 0;
      });
    }
  }

  @override
  void initState() {
    isLoading = true;
    pageStatues = 0;
    super.initState();
  }
}
