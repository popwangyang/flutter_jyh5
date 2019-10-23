import 'package:flutter/material.dart';

// 自定义组件类
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/PageContent.dart';
import '../widgets.dart';
import 'package:jy_h5/common/components/ListItem.dart';
import 'package:jy_h5/common/components/Strip.dart';
import 'package:jy_h5/common/components/ListSelect.dart';
import 'package:jy_h5/common/components/ListInput.dart';
import 'package:jy_h5/common/components/ListDateSelect.dart';
import 'ktvBusunessTime.dart';

// 工具类
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jy_h5/api/ktv.api.dart';
import 'package:jy_h5/model/ktv.dart';
import 'package:jy_h5/libs/utils.dart';
import 'dart:convert';

class KtvEdited extends StatefulWidget {
  @override
  _KtvEditedState createState() => _KtvEditedState();
}

class _KtvEditedState extends State<KtvEdited> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            AppTitle(hasBack: true, title: 'ktv编辑',),
            Expanded(
              child: _content(),
            )
          ],
        ),
      ),
    );
  }

  // 内容区域
  Widget _content(){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Strip(
              title:'KTV信息'
          ),
          ListInput(
            title: '场所名称',
            placeholder: '请输入',
            value: fromData['name'],
            onChange: (e){
              print(e);
              fromData['name'] = e;
            },
          ),
          ListSelected(
              title: '场所类型',
              data: ktvType,
              onChange: (index){
                fromData['type'] = ktvType[index];
              },
              initValue: fromData['type'],
              isLast: true,
          ),
          Strip(
              title:'联系人信息'
          ),
          ListInput(
            title: '联系人名称',
            placeholder: '请输入',
            value: fromData['contact'],
            onChange: (e){
              print(e);
              fromData['contact'] = e;
            },
          ),
          ListInput(
            title: '手机号 ',
            placeholder: '请输入',
            value: fromData['phone_number'],
            onChange: (e){
              print(e);
              fromData['phone_number'] = e;
            },
          ),
          ListInput(
            title: '场所电话',
            placeholder: '请输入',
            value: fromData['place_contact'],
            onChange: (e){
              print(e);
              fromData['place_contact'] = e;
            },
            isLast: true,
          ),
          Strip(
              title:'营业信息'
          ),
          DateSelect(
            title: '开业时间',
            onChang: (date){
              fromData['opening_hours'] = date;
            },
          ),
          ListSelected(
            title: '营业状态',
            data: businessStateList,
            onChange: (index){
              fromData['business_state'] = businessStateList[index];
            },
            initValue: fromData['business_state'],
          ),
          ListSelected(
            title: '营业时间',
            data: ktvType,
            initValue: fromData['business_hours'],
            btn: (){
              print("btn");
              Navigator.push(context, MaterialPageRoute(
                builder: (_){
                  return KtvTime();
                }
              ));
            },
          ),
//          ListSelected(
//            title: '地址',
//            data: ktvType,
//            onChange: (index){
//              fromData['address'] = ktvType[index];
//            },
//            initValue: fromData['address'],
//          ),



        ],
      ),
    );
  }

  Map fromData = {
    'name': null,  // 场所名称
    'type':null,  // 场所类型
    'contact': null,  // 联系人
    'province_code': null, // 省代码
    'city_code': null,  // 市代码
    'county_code': null,  // 区代码
    'address': null,  // 详细地址
    'place_contact': null,  //场所联系方式
    'phone_number': null,  //手机号码
    'opening_hours': null,  //开业时间
    'business_hours': null,  //营业时间
    'business_state': null  //营业状态
  };

  List ktvType = [
    '量贩',
    '夜总会'
  ];

  List businessStateList = [
    '正常',
    '停业',
    '暂停营业'
  ];


}
