import 'package:flutter/material.dart';
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/ListInput.dart';
import 'package:jy_h5/common/components/ListSelect.dart';
import 'package:jy_h5/common/components/PageContent.dart';
import 'package:jy_h5/api/ktv.api.dart';
import 'package:jy_h5/model/recharge.dart';
import 'package:jy_h5/common/ValueNotifier.dart';
import 'package:jy_h5/common/components/ListDateSelect.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/components/UploadFile.dart';
import 'package:jy_h5/common/components/Button.dart';
import 'package:jy_h5/libs/utils.dart';
import 'package:jy_h5/model/contract.dart';
import 'dart:convert';

import 'package:jy_h5/model/validate/rule.dart';
import 'package:toast/toast.dart';

class ContractEdited extends StatefulWidget {

  ContractEdited({
    Key key,
    this.ktvID,
    this.contractDetail
  }):super(key: key);

  final int ktvID;
  final ContractDetail contractDetail;

  @override
  _ContractEditedState createState() => _ContractEditedState();
}

class _ContractEditedState extends State<ContractEdited> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            AppTitle(
              hasBack: true,
              title: '新增合同信息',
            ),
            Expanded(
              flex: 1,
              child: PageContent(
                pageStatues: pageStatues,
                content: _content,
                reload: getData,
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _content(){
    return Container(
      child: Column(
        children: <Widget>[
          ListInput(
            title: '合同编号',
            value: fromData['number'],
            onChange: (e){
              fromData['number'] = e;
            },
          ),
          ListSelected(
            title: '套餐类型',
            data: arr,
            initValue: rechargeType,
            onChange: _rechargeType,
          ),
          ListSelected(
            title: '套餐名称',
            data: brr.map((item){
              return item.name;
            }).toList(),
            initValue: rechargeName,
            onChange: (e){
              fromData['recharge_package'] = brr[e].name;
            },
            vn: vn,
          ),
          ListInput(
            title: '包厢数量',
            value: fromData['box_count'],
            onChange: (e){
              fromData['box_count'] = e;
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(10)
            ),
            child: DatePick(
              title: '合同起始日期',
              value: fromData['begin_date'],
              onChang: (date){
                fromData['begin_date'] = date.toString();
                setState(() {});
              },
            ),
          ),
          UploadFile(
            title: '合同文件',
            value: fromData['annex'],
            maxLength: 30,
            onChange: (data){
              fromData['annex'] = data;
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(10),
              vertical: ScreenUtil().setHeight(30)
            ),
            child: Button(
              text: '保存',
              onChange: (e){
                _onBtn();
              },
            ),
          )
        ],
      ),
    );
  }

  int pageStatues = 1;

  List arr = [
    '一次性充值',
    '包厢套餐'
  ];
  List brr = [];
  String rechargeType;
  String rechargeName;
  List rechargeList1 = [];
  List rechargeList2 = [];
  ValueNotifierData vn = ValueNotifierData('0');

  Map<String, dynamic> fromData = {
    'number': null,
    'recharge_package':null,
    'box_count':null,
    'begin_date':null,
    'annex':[],
    'chargeable_time':null,
    'ktv': null
  };

  Map rule = {
    'number': [
      Rule(require: true, message: '合同编号不能为空')
    ],
    'recharge_package': [
      Rule(require: true, message: '请选择套餐名称')
    ],
    'box_count': [
      Rule(require: true, message: '包厢数不能为空'),
      Rule(message: '包厢数格式不正确', type: ruleType.Number)
    ],
    'begin_date': [
      Rule(require: true, message: '合同起始日期不能为空')
    ],
    'annex': [
      Rule(require: true, message: '请上传合同文件', type: ruleType.Array)
    ]
  };

  getData() async{
    setState(() {
      pageStatues = 1;
    });
    try{
      var sendData = {
        'page':1,
        'page_size': 100000,
        'initiate_state': 1
      };
      var res = await getRechargeList(sendData, context);
      List result = json.decode(res.toString())['results'];
      pageStatues = 2;
      result.forEach((item){
        RechargeModel rechargeModel = RechargeModel.fromJson(item);
        if(rechargeModel.packageType == 1){
          rechargeList1.add(rechargeModel);
        }else{
          rechargeList2.add(rechargeModel);
        }
      });
      if(widget.contractDetail != null){
        brr = widget.contractDetail.packageType == '1'?rechargeList1:rechargeList2;
      }else{
        brr = rechargeList1;
      }
      setState(() {});
    }catch(err){
      print(err);
      setState(() {
        pageStatues = 3;
      });
    }
  }

  _rechargeType(e){
    vn.value = '1';
    if(e == 1){
      brr = rechargeList1;
    }else{
      brr = rechargeList2;
    }
    fromData['recharge_package'] = null;
    setState(() {});
  }

  _onBtn() async{
    bool validateState = Utils.validate(fromData, rule, context);
    if(validateState){
      List annexList = fromData['annex'].map((item){
        return item.id;
      }).toList();
      int recharge;
      brr.forEach((item){
        if(item.name == fromData['recharge_package']){
            recharge = item.id;
          }
      });
      var sendData = {
        'number': fromData['number'],
        'recharge_package': recharge,
        'box_count': fromData['box_count'],
        'begin_date': fromData['begin_date'],
        'annex': annexList.join(','),
        'chargeable_time': fromData['chargeable_time'],
        'ktv': widget.ktvID,
      };
      print(sendData);
      try{
        if(widget.contractDetail == null){
          await addContract(sendData, context);
          Toast.show('创建成功', context, duration: 1, gravity: 1);
        }else{
          await putContract(widget.contractDetail.id, sendData, context);
          Toast.show('修改成功', context, duration: 1, gravity: 1);
        }
        Navigator.pop(context, true);
      }catch(err){
        print(err);

      }
    }
  }

  @override
  void initState() {
    getData();
    if(widget.contractDetail != null){
      fromData['number'] = widget.contractDetail.number;
      fromData['box_count'] = widget.contractDetail.boxCount.toString();
      fromData['annex'] = widget.contractDetail.annex;
      fromData['begin_date'] = widget.contractDetail.beginDate;
      fromData['recharge_package'] = widget.contractDetail.packageName;
      rechargeType = widget.contractDetail.packageType == '1'? '包厢套餐':'一次性充值';
      rechargeName = widget.contractDetail.packageName;
    }
    super.initState();
  }
}
