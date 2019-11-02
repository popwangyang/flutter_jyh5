import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/ListInput.dart';
import 'package:jy_h5/common/components/UploadFile.dart';
import 'package:jy_h5/common/components/Button.dart';
import 'package:jy_h5/model/validate/rule.dart';
import 'package:jy_h5/libs/utils.dart';
import 'package:jy_h5/api/ktv.api.dart';
import 'package:toast/toast.dart';

class SupplementContract extends StatefulWidget {
  SupplementContract({
    Key key,
    this.contractID,
  }):super(key: key);
  final int contractID;
  @override
  _SupplementContractState createState() => _SupplementContractState();
}

class _SupplementContractState extends State<SupplementContract> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            AppTitle(
              hasBack: true,
              title: '新增补充合同',
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListInput(
                      title: '包厢数',
                      value: fromData['box_count'],
                      onChange: (e){
                        fromData['box_count'] = e;
                      },
                    ),
                    UploadFile(
                      title: '合同文件',
                      value: [],
                      isLast: true,
                      onChange: (data){
                        fromData['annex'] = data;
                      },
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(30),
                          horizontal: ScreenUtil().setWidth(10)
                      ),
                      child: Button(
                        text: "保存",
                        onChange: (e){
                          _btn();
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Map fromData = {
    'annex': [],
    'box_count': null,
  };

  Map rule = {
    'box_count': [
      Rule(require: true, message: '包厢数不能为空'),
      Rule(message: '包厢数格式不正确', type: ruleType.Number)
    ],
    'annex': [
      Rule(require: true, message: '请上传合同附件', type: ruleType.Array)
    ]
  };

  _btn() async{

    bool validateState = Utils.validate(fromData, rule, context);

    if(validateState){


      List arr = fromData['annex'].map((item){
        return item.id;
      }).toList();

      var sendData = {
        'contract': widget.contractID,
        'annex': arr.join(','),
        'box_count': fromData['box_count'].toString(),
        'category': '1'
      };
      print(sendData);
      try{
        await addSupplementContract(sendData, context);
        Toast.show('合同补充成功', context, duration: 1, gravity: 1);
        Navigator.of(context).pop();
      }catch(err){
        Toast.show('合同补充失败', context, duration: 1, gravity: 1);
        print(err);
      }
    }
  }
}
