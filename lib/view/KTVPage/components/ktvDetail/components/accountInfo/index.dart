import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jy_h5/api/ktv.api.dart';
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/PageContent.dart';
import 'package:jy_h5/common/components/Empty.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/components/Button.dart';
import 'package:jy_h5/model/account.dart';
import 'package:jy_h5/common/components/ListItem.dart';
import 'package:jy_h5/common/components/ToastWidget.dart';

class AccountPage extends StatefulWidget {

  AccountPage({
    Key key,
    this.ktvID,
    this.balance,
    this.accountStatus
  }):super(key: key);

  final int ktvID;
  final String balance;  // ktv账户余额
  final int accountStatus; // 账户状态

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            AppTitle(
              hasBack: true,
              title: '账号信息',
            ),
            Expanded(
              flex: 1,
              child:PageContent(
                pageStatues: pageStatues,
                content: _content,
                reload: getData,
                emptyWidget: _emptyWidget(),
              ),
            ),
            (){
              if(pageStatues == 2){
                return _bottomWidget();
              }else{
                return Container();
              }
            }()
          ],
        ),
      ),
    );
  }

  int pageStatues = 1;

  AccountDetail accountDetail;


  Widget _content(){
    return Container(
      child: Column(
        children: <Widget>[
          ListItem(
            title: '登录账号',
            label: accountDetail.phone,
          ),
          ListItem(
            title: '邮箱号',
            label: accountDetail.email == ''? '暂无':accountDetail.email,
          ),
          ListItem(
            title: '所属品牌',
            label: accountDetail.brand.name,
          ),
          ListItem(
            title: '余额',
            label: widget.balance + '元',
          ),
          ListItem(
            title: '创建日期',
            label: accountDetail.createDate,
            isLast: true,
          ),
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(10)
            ),
            child:  ListItem(
              title: '状态',
              label: accountDetail.isActive ? '已启用':'已禁用',
            ),
          ),
          ListItem(
            title: '性质',
            label: widget.accountStatus == 1 ? '试用账号':'正式账号',
            isLast: true,
          )
        ],
      ),
    );
  }

  Widget _emptyWidget(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Empty(
            text: '暂无账号信息',
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(10)
            ),
            child:  ButtonCircle(
              text: '新建试用账号',
              onClick: () async{},
            ),
          )
        ],
      ),
    );
  }

  Widget _bottomWidget(){
    return Container(
      width: ScreenUtil().width,
      height: ScreenUtil().setHeight(40),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            offset: Offset(0, -5),
            spreadRadius: -1,
            blurRadius: 5,
          )
       ]
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child:FlatButton(
              textColor: Color(0xff999999),
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Color(0xfff3f5f7)
                      )
                    )
                  ),
                  child: Text("禁用账号",)
              ),
              onPressed: (){

              },
            ),
          ),
          Expanded(
            flex: 1,
            child: FlatButton(
              textColor: Color(0xff458cf4),
              child: Container(
                  alignment: Alignment.center,
                  child: Text("正式启用",)
              ),
              onPressed: (){
                ToastWidget.clear();
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: FlatButton(
              color: Color(0xff458cf4),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)
              ),
              child: Container(
                  alignment: Alignment.center,
                  child: Text("编辑",)
              ),
              onPressed: (){
                ToastWidget.loading(context, message: '加载中...', duration: 2);
              },
            ),
          ),
        ],
      ),
    );
  }

  getData() async{
    setState(() {
      pageStatues = 1;
    });
    try{
      var sendData = {
        'code': 'K',
        'ktv_id': widget.ktvID
      };
      var res = await getAccountInfo(sendData, context);
      var result = json.decode(res.toString())['results'];
      if(result.length > 0){
        pageStatues = 2;
        accountDetail = AccountDetail.fromJson(result[0]);
      }else{
        pageStatues = 4;
      }
      setState(() {
        pageStatues = 2;
      });
    }catch(err){
      setState(() {
        pageStatues = 3;
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }
}

