import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/api/ktv.api.dart';
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/Button.dart';
import 'package:jy_h5/common/components/ListInput.dart';
import 'package:jy_h5/common/components/ListSelect.dart';
import 'package:jy_h5/common/style.dart';
import 'package:jy_h5/libs/utils.dart';
import 'package:jy_h5/model/account.dart';
import 'package:jy_h5/model/validate/rule.dart';
import 'package:provider/provider.dart';
import 'package:jy_h5/store/model/loginModel.dart';
import 'package:jy_h5/store/model/ktvModel.dart';

class EditedAccountPage extends StatefulWidget {

  EditedAccountPage({
    Key key,
    this.accountDetail,
  }):super(key: key);

  final AccountDetail accountDetail;

  @override
  _EditedAccountPageState createState() => _EditedAccountPageState();
}

class _EditedAccountPageState extends State<EditedAccountPage> {
  @override
  Widget build(BuildContext context) {

    dataList = Provider.of<Login>(context).companyBrands;
    print(dataList);

    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            AppTitle(
              hasBack: true,
              title: titleText,
            ),
            ListInput(
              title: '账号',
              placeholder: '请输入手机号',
              value: fromData['phone'],
              onChange: (e){
                fromData['phone'] = e;
              },
            ),
            ListInput(
              title: '邮箱号',
              isRequired: false,
              placeholder: '请输入邮箱号',
              value: fromData['email'],
              onChange: (e){
                fromData['email'] = e;
              },
            ),
            (){
              if(widget.accountDetail == null){
                return  ListInput(
                  title: '初始密码',
                  value: fromData['password'],
                  onChange: (e){
                    fromData['password'] = e;
                  },
                );
              }else{
                return Container();
              }
            }(),
            ListSelected(
              title: '所属品牌',
              data: dataList.map((item){
                return item.name;
              }).toList(),
              initValue: fromData['brand'],
              onChange: (e){
                fromData['brand'] = Provider.of<Login>(context).companyBrands[e].name;
                fromData['brand_id'] = Provider.of<Login>(context).companyBrands[e].id;
              },
            ),
            _switch(),
            Container(
              margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(30)
              ),
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(10)
              ),
              child: Button(
                text: buttonText,
                onChange: (e){
                  _saveBtn();
                },
              ),
            )
          ],
        ),
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
            value: fromData['is_active'],
            onChanged: (value){
              setState(() {
                fromData['is_active'] = value;
              });
            },
          )
        ],
      ),
    );
  }

  Map fromData = {
    'phone': null,
    'email':null,
    'brand':null,
    'password':null,
    'is_active': true,
    'brand_id': null,
  };

  Map rule = {
    'phone':[
      Rule(require: true, message: '账号不能为空',),
      Rule(message: '请输入正确的手机号', type: ruleType.Phone)
    ],
    'email':[
      Rule(require: false, message: '邮箱格式不正确'),
      Rule(message: '请输入正确的邮箱号', type: ruleType.Email)
    ],
    'password':[
      Rule(require: true, message: '初始密码不能为空',),
      Rule(message: '请输入长度为8-16位之间的数字和字母组合', type: ruleType.Password)
    ],
    'brand':[
      Rule(require: true, message: '所属品牌不能为空')
    ]
  };

  List dataList;

  String buttonText;

  String titleText;

  _saveBtn() async{

    if(widget.accountDetail != null){
      rule.remove('password');
    }

    bool validateState = Utils.validate(fromData, rule, context);
    if(validateState){
      var sendData = {
        'nickname': 'username',
        'phone': fromData['phone'],
        'email': fromData['email'] == null ? '':fromData['email'],
        'brand_id': fromData['brand_id'],
        'ktv_id': Provider.of<Ktv>(context).ktvID,
        'is_active': fromData['is_active'] ? 1:2,
        'group': [2],
        'password': fromData['password']
      };
      if(widget.accountDetail != null){
        sendData.remove('password');
        print(sendData);
        await putAccountKTV(widget.accountDetail.id, sendData, context);
      }else{
        await createAccountKTV(sendData, context);
      }
      Navigator.of(context).pop(sendData);
    }
  }

  @override
  void initState() {
    if(widget.accountDetail != null){
      fromData['phone'] = widget.accountDetail.phone;
      fromData['email'] = widget.accountDetail.email;
      fromData['brand'] = widget.accountDetail.brand.name;
      fromData['brand_id'] = widget.accountDetail.brand.id;
      fromData['is_active'] = widget.accountDetail.isActive;
      fromData['phone'] = widget.accountDetail.phone;
      buttonText = '保存';
      titleText = '编辑账号';
    }else{
      buttonText = '新建试用账号';
      titleText = '新建账号';
    }
    super.initState();
  }
}
