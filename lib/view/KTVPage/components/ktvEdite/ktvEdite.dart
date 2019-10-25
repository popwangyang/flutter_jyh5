import 'dart:convert';

import 'package:flutter/material.dart';

// 自定义组件类
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/PageContent.dart';
import 'package:toast/toast.dart';
import '../widgets.dart';
import 'package:jy_h5/common/components/ListItem.dart';
import 'package:jy_h5/common/components/Strip.dart';
import 'package:jy_h5/common/components/ListSelect.dart';
import 'package:jy_h5/common/components/ListInput.dart';
import 'package:jy_h5/common/components/ListDateSelect.dart';
import 'ktvBusunessTime.dart';
import 'package:jy_h5/common/components/ListCity.dart';
import 'package:jy_h5/common/components/Button.dart';
import 'package:jy_h5/model/validate/rule.dart';

// 工具类
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/style.dart';
import 'package:jy_h5/api/ktv.api.dart';
import 'package:jy_h5/model/ktv.dart';
import 'package:jy_h5/libs/utils.dart';

class KtvEdited extends StatefulWidget {

  final KtvDetailModel ktv;
  KtvEdited({Key key, this.ktv}):super(key: key);

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
            AppTitle(hasBack: true, title: pageTitle,),
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
              fromData['contact'] = e;
            },
          ),
          ListInput(
            title: '手机号 ',
            placeholder: '请输入',
            value: fromData['phone_number'],
            onChange: (e){
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
          DatePick(
            title: '开业时间',
            value: fromData['opening_hours'],
            onChang: (date){
              setState(() {
                fromData['opening_hours'] = date;
              });
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
          YYTime(
            title: '营业时间',
            value: fromData['business_hours'],
            onBtn: () async{
              print("btn");
              var result = await Navigator.push(context, MaterialPageRoute(
                  builder: (_){
                    return KtvTime(
                      businessHours: widget.ktv.businessHours,
                    );
                  }
              ));
              if(result != null){
                setState(() {
                  fromData['business_hours'] = BusinessHours.fromJson(result);
                });
              }
            },
          ),
          CitySelected(
            title: '地址',
            value: fromData['PCC'],
            codeValue: fromData['county_code'],
            onChang: (result){
              setState(() {
                fromData['province_code'] = result.provinceId;
                fromData['city_code'] = result.cityId;
                fromData['county_code'] = result.areaId;
                fromData['PCC'] = '${result.provinceName}/${result.cityName}/${result.areaName}';
              });
            },
          ),
          Container(
            color: Colors.white,
            height: ScreenUtil().setHeight(100),
            padding: EdgeInsets.all(ScreenUtil().setHeight(10)),
            child: TextField(
              maxLines: 3,
              maxLength: 100,
              controller: controller,
              maxLengthEnforced: true,
              onChanged: (e){
                fromData['address'] = e;
              },
              decoration: InputDecoration(
                hintText: '请输入详细地址',
                hintStyle: Style.placeHolder()
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(20),
                bottom: ScreenUtil().setHeight(20),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(20)
            ),
            child: Button(
              text: '保存',
              onChange: _btnClick,
            ),
          )

        ],
      ),
    );
  }

  TextEditingController controller = TextEditingController();
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
    'business_state': null,  //营业状态
    'PCC': null,
  };

  Map rule = {
    'name': [
      Rule(require: true, message: '场所名称不能为空'),
    ],
    'type': [
      Rule(require: true, message: '场所类型不能为空'),
    ],
    'contact': [
      Rule(require: true, message: '联系人不能为空'),
    ],
    'phone_number': [
      Rule(require: true, message: '手机号码不能为空'),
      Rule( message: '手机号码格式不正确', type: ruleType.Phone),
    ],
    'place_contact': [
      Rule(require: true, message: '场所电话不能为空'),
    ],
    'place_contact': [
      Rule(require: true, message: '场所电话不能为空'),
    ],
    'opening_hours': [
      Rule(require: true, message: '开业时间不能为空'),
    ],
    'business_state': [
      Rule(require: true, message: '营业状态不能为空'),
    ],
    'business_hours': [
      Rule(require: true, message: '营业时间不能为空'),
    ],
    'PCC': [
      Rule(require: true, message: '地址不能为空'),
    ],
    'address': [
      Rule(require: true, message: '详细地址不能为空'),
    ],
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

  String pageTitle;

  @override
  void initState() {
    if(widget.ktv != null){
      pageTitle = 'KTV编辑';
      fromData['name'] = widget.ktv.name;
      fromData['type'] = ktvType[widget.ktv.type - 1];
      fromData['contact'] = widget.ktv.contact;
      fromData['phone_number'] = widget.ktv.phoneNumber;
      fromData['place_contact'] = widget.ktv.placeContact;
      fromData['opening_hours'] = widget.ktv.openingHours;
      fromData['business_state'] = businessStateList[widget.ktv.businessState - 1];
      fromData['business_hours'] = widget.ktv.businessHours;
      fromData['province_code'] = widget.ktv.provinceCode;
      fromData['city_code'] = widget.ktv.cityCode;
      fromData['county_code'] = widget.ktv.countyCode;
      fromData['address'] = widget.ktv.address;
      fromData['PCC'] = '${widget.ktv.province}/${widget.ktv.city}/${widget.ktv.county}';
      controller.text = widget.ktv.address;
    }else{
      pageTitle = 'KTV创建';
      Map result = {
        'flag': 0,
        'days': [1,2,3,4,5,6,7],
        'start': '',
        'end': ''
      };
      fromData['business_hours'] = BusinessHours.fromJson(result);
      controller.text = null;
    }
    super.initState();
  }

  _btnClick(e){
    bool validateState = Utils.validate(fromData, rule, context);
    print(validateState);
    if(validateState){


      Map sendData = {
        'name': fromData['name'],
        'type': fromData['type'] == '夜总会' ? '2':'1',
        'contact': fromData['contact'],
        'province_code': fromData['province_code'],
        'city_code': fromData['city_code'],
        'county_code': fromData['county_code'],
        'address': fromData['address'],
        'place_contact': fromData['place_contact'],
        'phone_number': fromData['phone_number'],
        'opening_hours':fromData['opening_hours'],
        'business_hours': json.encode(fromData['business_hours'].toJson()),
        'business_state': _businessState(fromData['business_state'])
      };
      print(sendData);
      if(widget.ktv != null){
        var id = widget.ktv.id;
        putKTVDetail(id, sendData, context).then((val){
          Toast.show('修改成功', context, duration: 1, gravity: 1);
          Navigator.pushNamed(context, 'indexPage');
        });
      }else{
        createKTVDetail(sendData, context).then((val){
          Toast.show('创建成功', context, duration: 1, gravity: 1);
          Navigator.pushNamed(context, 'indexPage');
        });
      }
    }
  }

  String _businessState(String val){

    return businessStateList.indexOf(val) == -1 ? '1':(businessStateList.indexOf(val)+1).toString();
  }


}

class YYTime extends StatelessWidget {

  final String title;
  final BusinessHours value;
  final Function onBtn;

  YYTime({
    Key key,
    this.title,
    this.value,
    this.onBtn
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: <Widget>[
        InkWell(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(10, 14, 10, 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text("营业时间",  style: Style.listTitle()),
                ),
                Expanded(
                  flex: 4,
                  child: (){
                    if(value != null){
                      return Text(value.toString(), style: Style.inputText(),);
                    }else{
                      return Text('请选择', style: Style.placeHolder());
                    }
                  }(),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(20),
                  height: ScreenUtil().setHeight(20),
                )
              ],
            ),
          ),
          onTap: onBtn,
        ),
        Divider(
          height: 1,
          color: Color.fromRGBO(235, 237, 240, 1),
          indent: 16,
        )
      ],
    );
  }
}

