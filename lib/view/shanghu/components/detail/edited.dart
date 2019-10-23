import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/components/ListSelect.dart';
import 'package:jy_h5/common/components/ListInput.dart';
import 'package:jy_h5/api/merchant.api.dart';
import 'package:jy_h5/model/brand.dart';
import 'package:jy_h5/common/style.dart';
import 'package:jy_h5/model/merchant.dart';
import 'package:provider/provider.dart';
import 'package:jy_h5/store/model/loginModel.dart';
import 'package:jy_h5/model/ktv.dart';
import 'package:jy_h5/libs/utils.dart';
import 'package:jy_h5/model/validate/rule.dart';
import 'package:jy_h5/view/Search/search.dart';
import 'package:jy_h5/api/ktv.api.dart';
import 'package:jy_h5/model/ktv.dart';
import 'package:toast/toast.dart';
import 'package:jy_h5/common/components/Strip.dart';



class MerchantEdited extends StatefulWidget {

  final MerchantDetailModel merchantDetailModel;
  final bool isEdited;

  MerchantEdited({
    Key key,
    this.merchantDetailModel,
    this.isEdited = true
  }):super(key: key);

  @override
  _MerchantEditedState createState() => _MerchantEditedState();
}

class _MerchantEditedState extends State<MerchantEdited> {

  List names = [];
  String vodName;
  Login loginData;
  String name; // 商户名称
  String phone; // 账号;
  String email;  // 邮箱
  String password; // 密码
  String brandName;  // 品牌名称
  bool accountStatues;   // 是否启用
  List ktvList;  // 商户门店列表

  Map<String, dynamic> fromData = {
    'name': null,
    'phone': null,
    'email': null,
    'password': null,
    'brandName': null,
    'accountStatues': true,
    'ktvList': [],
  };

  Map rule = {
    'name': [
      Rule(require: true, message: '商户名称不能为空',)
    ],
    'phone': [
      Rule(require: true, message: '账号不能为空',),
      Rule(message: '账号格式不正确', type: ruleType.Phone),
    ],
    'email': [
      Rule(message: '邮箱格式不正确', type: ruleType.Email),
    ],
    'password': [
      Rule(require: true, message: '密码不能为空',),
    ],
    'brandName':[
      Rule(require: true, message: '品牌名不能为空',)
    ],
    'ktvList': [
      Rule(require: true, message: '请添加选择门店', type: ruleType.Array),
    ]
  };

  @override
  Widget build(BuildContext context) {

    loginData = Provider.of<Login>(context);
    names = loginData.companyBrands.map((item) => item.name).toList();


    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            AppTitle(hasBack: true, title: '编辑商户',),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            Expanded(
              flex: 1,
              child: _contentWidget(),
            )
          ],
        ),
      ),
    );
  }

  Widget _contentWidget(){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          ListInput(
            title: '商户名称',
            placeholder: '请输入商户名称',
            value: fromData['name'],
            onChange: (e){
              print(e);
              fromData['name'] = e;
            },
          ),
          ListInput(
            title: '账号',
            placeholder: '请输入账号',
            value: fromData['phone'],
            onChange: (e){
              print(e);
              fromData['phone'] = e;
            },
          ),
          ListInput(
            title: '邮箱号',
            placeholder: '请输入邮箱号',
            value: fromData['email'],
            isRequired: false,
            onChange: (e){
              print(e);
              fromData['email'] = e;
            },
          ),
          (){
            if(!widget.isEdited){
              return ListInput(
                title: '密码',
                placeholder: '请输入密码',
                value: fromData['password'],
                onChange: (e){
                  print(e);
                  fromData['password'] = e;
                },
              );
            }else{
              return Container();
            }
          }(),
          ListSelected(
              title: '品牌名称',
              data: names,
              onChange: (index){
                fromData['brandName'] = names[index];
              },
              initValue: fromData['brandName']
          ),
          _switch(),
          Strip(
            title: "关联场所：${fromData['ktvList'].length}",
          ),
          _selectBtnWidget(),
          _showPlaceListWidget(),
          _btnClickWidget(),
        ],
      ),
    );
  }

  Widget _switch(){
    return Container(
      padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("是否启用", style: Style.listTitle(),),
          Switch(
            value: fromData['accountStatues'],
            onChanged: (value){
              fromData['accountStatues'] = value;
            },
          )
        ],
      ),
    );
  }

  // 请选择按钮
  Widget _selectBtnWidget(){
    return InkWell(
      child: Container(
        color: Color.fromRGBO(239, 238, 243, 1),
        width: MediaQuery.of(context).size.width,
        height: ScreenUtil().setHeight(47),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(14),
                height: ScreenUtil().setHeight(14),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(43, 200, 214, 1),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Icon(Icons.add, size: ScreenUtil().setSp(14), color: Colors.white,),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(4),
              ),
              Text("请选择", style: TextStyle(
                color: Color.fromRGBO(68, 68, 68, 1),
                fontSize: ScreenUtil().setSp(14),
                fontWeight: FontWeight.w600
              ),)
            ],
          ),
        ),
      ),
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return Search(
                pageTitle: '选择门店',
                placeholder: '请输入门店信息',
                searchFun: _searchFun,
                btnItemFun: _btnItemFun,
              );
            })
        );
      },
    );
  }

  // 展示场所列表
  Widget _showPlaceListWidget(){
    return Container(
      color: Colors.white,
      child: Column(
        children: (fromData['ktvList'] as List).map((item){
          return _placeListItemWidget(item);
        }).toList(),
      ),
    );
  }

  // 展示场所子项
  Widget _placeListItemWidget(KTV ktv){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 6, top: 5),
                width: ScreenUtil().setWidth(14),
                height: ScreenUtil().setHeight(14),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 91, 63, 1),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: InkWell(
                  child: Icon(
                    Icons.remove,
                    size: ScreenUtil().setSp(14),
                    color: Colors.white,
                  ),
                  onTap: (){
                    _removeKtv(ktv);
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Text(
                    ktv.name,
                    style: Style.listTitle(),
                  ),
                ),
              )
            ],
          ),
        ),
        Divider(
          height: 1,
          indent: 16,
          color: Color.fromRGBO(235, 237, 240, 1),
        )
      ],
    );
  }

  // 确认按钮
  Widget _btnClickWidget(){
    return Container(
      width: ScreenUtil().width,
      margin: EdgeInsets.fromLTRB(16, 26, 16, 26),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors:[Color.fromRGBO(61, 158, 255, 1),Color.fromRGBO(24, 82, 243, 1)]),
        borderRadius: BorderRadius.circular(4),
      ),
      child: FlatButton(
        padding: EdgeInsets.only(top: 12, bottom: 12),
        child: Text("保存", style: TextStyle(
          color: Colors.white,
          fontSize: ScreenUtil().setSp(16)
        ),),
        onPressed: _fromBtn,
      ),
    );
  }

  _btnItemFun(data){

    Navigator.of(context).pop();
    _addKtv(KTV.fromJson(data));
  }

  _addKtv(KTV ktv){
    var flag;
    flag = fromData['ktvList'].indexWhere((item){
      return item.id == ktv.id;
    });
    if(flag == -1){
      setState(() {
        fromData['ktvList'].add(ktv);
      });
    }else{
      Toast.show('已存在门店,请勿重复添加', context, duration: 2, gravity: 1);
    }
  }

  _removeKtv(KTV ktv){
    setState(() {
      fromData['ktvList'].remove(ktv);
    });
  }

  _searchFun(data) async{
    Completer completer = Completer();
    try{
      var result = await getKTVList(data, context);
      var dataList = json.decode(result.toString())['results'];
      print('=======$dataList}========');
      completer.complete(dataList);
    }catch(err){
      completer.completeError(err);
    }
    return completer.future;
  }




  @override
  void initState() {
    if(!widget.isEdited){
      fromData['name'] = '';
      fromData['phone'] = '';
      fromData['email'] = '';
      fromData['brandName'] = '';
      fromData['isUsed'] = true;
      fromData['ktvList'] = [];
    }else{
      fromData['name'] = widget.merchantDetailModel.name;
      fromData['phone'] = widget.merchantDetailModel.phone;
      fromData['email'] = widget.merchantDetailModel.email;
      fromData['brandName'] = widget.merchantDetailModel.brandName;
      fromData['isUsed'] = widget.merchantDetailModel.accountStatues;
      fromData['ktvList'].addAll(widget.merchantDetailModel.ktvList);
    }

    super.initState();
  }

  _fromBtn() async{
    print(fromData);
    if(widget.isEdited){
      rule.remove('password');
    }
    bool validateState = Utils.validate(fromData, rule, context);
    print(validateState);
    if(validateState){


      var brand = loginData.companyBrands.firstWhere((item){
         return item.name == fromData['brandName'];
      });
      var ktvID = fromData['ktvList'].map((item) => item.id.toString()).toList();
      var sendData = {
        'brand': brand.id,
        'name': fromData['name'],
        'email': fromData['email'],
        'phone': fromData['phone'],
        'ktv': ktvID,
        'status': fromData['accountStatues'],
        'password': fromData['password']
      };
      try{
        if(widget.isEdited){
          sendData.remove('password');
          var id = widget.merchantDetailModel.id;
          await putMerchantDetail(id, sendData, context);
          Toast.show('修改成功', context, duration: 2, gravity: 1);
          Future.delayed(Duration(seconds: 1),(){
            Navigator.of(context).pushNamed('indexPage');
          });
        }else{
          print(sendData);
          await createMerchantDetail(sendData, context);
          Toast.show('创建成功', context, duration: 2, gravity: 1);
          Future.delayed(Duration(seconds: 1),(){
            Navigator.of(context).pushNamed('indexPage');
          });
        }
      }catch(err){
        print(err);
//        Toast.show('修改失败', context, duration: 2, gravity: 1);
      }
    }
  }

}







