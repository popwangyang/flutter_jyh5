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
import 'package:jy_h5/common/components/Dialog.dart';
import 'package:jy_h5/view/KTVPage/components/ktvDetail/components/accountInfo/edited_account.dart';
import 'package:jy_h5/view/KTVPage/components/ktvDetail/components/accountInfo/enable_account.dart';
import 'package:provider/provider.dart';
import 'package:jy_h5/store/model/ktvModel.dart';

class AccountPage extends StatefulWidget {

  AccountPage({
    Key key,
    this.ktvID,
    this.balance,
  }):super(key: key);

  final int ktvID;
  final String balance;  // ktv账户余额

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
  String enableText = '启用账号后, 将可以登录，确定启用吗？';
  String prohibitText = '禁用账号后，将无法登录，确定禁用吗？';

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
            label: Provider.of<Ktv>(context).accountStatus == 1 ? '试用账号':'正式账号',
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
              onClick: () async{
                var result = Navigator.of(context).push(MaterialPageRoute(
                  builder: (_){
                    return EditedAccountPage();
                  }
                ));
                if(result != null){
                  getData();
                }
              },
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
                  child: Text(accountDetail.isActive ? "禁用账号":"启用账号",)
              ),
              onPressed: (){
                DialogWidget.confirm(
                    context,
                    message: accountDetail.isActive ? prohibitText:enableText,
                    title: accountDetail.isActive ? '禁用账号':'启用账号'
                ).then((val){
                  if(val == 'ok'){
                    _accountStatues(accountDetail.isActive);
                  }
                });
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
                int statue = Provider.of<Ktv>(context).accountStatus;
                if(statue == 2){
                  ToastWidget(context, '当前账号为正式账号，不可进行该操作');
                  return;
                }
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_){
                    return EnablePage(
                      ktvId: widget.ktvID,
                    );
                  }
                ));
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
              onPressed: () async{
                var result = await Navigator.of(context).push(MaterialPageRoute(
                    builder: (_){
                      return EditedAccountPage(
                        accountDetail: accountDetail,
                      );
                    }
                ));
                if(result != null){
                  getData();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  _accountStatues(bool state) async{
    ToastWidget.loading(
        context, message: state ? '启用中':'禁用中',
        duration: 2
    );
    var sendData = {
      'area_code_list': accountDetail.areaCodeList,
      'is_active': state ? 0 : 1
    };

    try{
      await changAccountStatues(accountDetail.id, sendData, context);
      ToastWidget.success(context, message: '启用成功');
      setState(() {
        accountDetail.isActive = !state;
      });
    }catch(err){
      ToastWidget.fail(context, message: '操作失败');
    }
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
      print(result);
      if(result.length > 0){
        pageStatues = 2;
        accountDetail = AccountDetail.fromJson(result[0]);
      }else{
        pageStatues = 4;
      }
      setState(() {});
    }catch(err){
      print(err);
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

