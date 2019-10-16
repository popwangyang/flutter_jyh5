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



class MerchantEdited extends StatefulWidget {

  final MerchantDetailModel merchantDetailModel;

  MerchantEdited({Key key, this.merchantDetailModel}):super(key: key);

  @override
  _MerchantEditedState createState() => _MerchantEditedState();
}

class _MerchantEditedState extends State<MerchantEdited> {

  List names = [];
  String vodName;
  bool _switchSelected = true;
  Login loginData;
  String name; // 商户名称
  String phone; // 账号;
  String email;  // 邮箱
  String companyBrand;  // 品牌名称







  @override
  Widget build(BuildContext context) {

    loginData = Provider.of<Login>(context);
    names = loginData.companyBrands.map((item) => item.name).toList();

    companyBrand = widget.merchantDetailModel.brandName;

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
            value: widget.merchantDetailModel.name,
            onChange: (e){
              print(e);
              name = e;
            },
          ),
          ListInput(
            title: '账号',
            placeholder: '请输入账号',
            value: widget.merchantDetailModel.phone,
          ),
          ListInput(
            title: '邮箱号',
            placeholder: '请输入邮箱号',
            value: widget.merchantDetailModel.email,
            isRequired: false,
          ),
          ListSelected(
              title: '品牌名称',
              data: names,
              onChange: vodSelected,
              initValue: companyBrand
          ),
          _switch(),
          Container(
            height: ScreenUtil().setHeight(40),
            width: ScreenUtil().width,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16),
            child: Text("关联场所：${widget.merchantDetailModel.ktvList.length}", style: Style.navTitle()),
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
      padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("是否启用", style: Style.listTitle(),),
          Switch(
            value: _switchSelected,
            onChanged: (value){
              print(value);
              setState(() {
                _switchSelected = value;
              });
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
    );
  }

  // 展示场所列表
  Widget _showPlaceListWidget(){
    return Container(
      color: Colors.white,
      child: Column(
        children: widget.merchantDetailModel.ktvList.map((item){
          return _placeListItemWidget(item);
        }).toList(),
      ),
    );
  }

  // 展示场所子项
  Widget _placeListItemWidget(KtvDetailModel ktv){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 6, top: 4),
                width: ScreenUtil().setWidth(14),
                height: ScreenUtil().setHeight(14),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 91, 63, 1),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Icon(
                  Icons.remove,
                  size: ScreenUtil().setSp(14),
                  color: Colors.white,
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
      margin: EdgeInsets.fromLTRB(16, 30, 16, 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors:[Color.fromRGBO(61, 158, 255, 1),Color.fromRGBO(24, 82, 243, 1)]),
        borderRadius: BorderRadius.circular(4),
      ),
      child: FlatButton(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Text("保存", style: TextStyle(
          color: Colors.white,
          fontSize: ScreenUtil().setSp(16)
        ),),
        onPressed: (){
          print(name);

        },
      ),
    );
  }

  @override
  void initState() {
    name = widget.merchantDetailModel.name;



    super.initState();
  }

  vodSelected(index){
    print(index);
    setState(() {
      vodName = names[index];
    });
  }

}







