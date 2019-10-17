import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/components/Appbar.dart';
import 'components/searchComponent.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            AppTitle(
              title: '选择门店',
              hasBack: true,
            ),
            SearchWidget(
              placeHolder: '请输入门店名称',
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
      if(isLoading){
        return Text("加载中...");
      }else{
        return Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              itemWidget(),
              itemWidget(),
              itemWidget(),
              itemWidget(),
              itemWidget(),
              itemWidget(),
              itemWidget(),
              itemWidget(),
              itemWidget(),
              itemWidget(),
              itemWidget(),
              itemWidget(),



            ],
          ),
        );
      }
    }();
  }

  // 加载子项
  Widget itemWidget(){
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(15),
              right: ScreenUtil().setWidth(15),
              top: ScreenUtil().setHeight(14),
              bottom: ScreenUtil().setHeight(14),
            ),
            child: Text(
              '杭州银乐迪西溪银泰店',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(14),
                color: Color.fromRGBO(102, 102, 102, 1),
              ),
            ),
          ),
          Divider(
            height: 1,
            color: Color.fromRGBO(246, 246, 246, 1),
          )
        ],
      ),
    );
  }

  search(e){
    print(e);
  }

  @override
  void initState() {
    isLoading = false;
    super.initState();
  }
}
