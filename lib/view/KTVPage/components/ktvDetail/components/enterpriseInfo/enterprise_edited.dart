import 'package:flutter/material.dart';

import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/Strip.dart';
import 'package:jy_h5/common/components/ListInput.dart';
import 'package:jy_h5/common/components/UploadFile.dart';
import 'package:jy_h5/common/components/Button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/api/ktv.api.dart';
import 'package:provider/provider.dart';
import 'package:jy_h5/store/model/ktvModel.dart';
import 'package:toast/toast.dart';

// 表单验证
import 'package:jy_h5/libs/utils.dart';
import 'package:jy_h5/model/validate/rule.dart';


class EnterpriseEdited extends StatefulWidget {
  @override
  _EnterpriseEditedState createState() => _EnterpriseEditedState();
}

class _EnterpriseEditedState extends State<EnterpriseEdited> {
  @override
  Widget build(BuildContext context) {

    ktvID = Provider.of<Ktv>(context).ktvID;

    return Scaffold(
      body: Column(
        children: <Widget>[
          AppTitle(
            hasBack: true,
            title: '新建企业信息',
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Strip(
                    title: '企业信息',
                  ),
                  ListInput(
                    title: '企业注册名称',
                    onChange: (e){
                      fromData['company_name'] = e;
                    },
                  ),
                  ListInput(
                    title: '营业执照编号',
                    onChange: (e){
                      fromData['license_number'] = e;
                    },
                  ),
                  UploadFile(
                    isLast: true,
                    title: '营业执照照片',
                    isRequired: false,
                    onChange: (e){
                      fromData['license_photo'] = e;
                    },
                  ),
                  Strip(
                    title: '法人信息',
                  ),
                  ListInput(
                    title: '法人名称',
                    onChange: (e){
                      fromData['legal_representative'] = e;
                    },
                  ),
                  ListInput(
                    title: '身份证号',
                    onChange: (e){
                      fromData['legal_representative_card'] = e;
                    },
                    isRequired: false,
                  ),
                  UploadFile(
                    title: '身份证照片',
                    isLast: true,
                    isRequired: false,
                    onChange: (e){
                      fromData['identity_card_photo'] = e;
                    },
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(20)
                    ),
                    child: Button(
                      text: '保存',
                      onChange: (e){
                       _submitBtn();
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // 表单；
  Map fromData = {
    'license_number': null,
    'company_name': null,
    'license_photo': null,
    'legal_representative': null,
    'legal_representative_card': null,
    'identity_card_photo': null,
  };

  Map rule = {
    'company_name': [
      Rule(require: true, message: '企业注册名称不能为空',)
    ],
    'license_number': [
      Rule(require: true, message: '营业执照编号不能为空',),
    ],
    'legal_representative': [
      Rule(require: true, message: '法人名称不能为空',),
    ],
    'legal_representative_card':[
      Rule(message: '身份证格式不正确', type: ruleType.IDCard)
    ],
  };


  int ktvID; // 获取存在全局的KTVID；

  @override
  void initState() {
    super.initState();
  }

  _submitBtn() async{
    fromData['ktv'] = ktvID;

    bool validateState = Utils.validate(fromData, rule, context);

    if(validateState){
      print(fromData);
     await addEnterprise(fromData, context);

     Toast.show('创建成功', context, duration: 2, gravity: 1);
    }

  }


}
