import 'package:flutter/material.dart';
import 'dart:convert';

// 自定义组件
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/ListInput.dart';
import 'package:jy_h5/common/components/ListSelect.dart';
import 'package:jy_h5/common/components/Button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:jy_h5/store/model/ktvModel.dart';
import 'package:jy_h5/api/ktv.api.dart';
import 'package:jy_h5/model/ktv.dart';

// 表单验证
import 'package:jy_h5/libs/utils.dart';
import 'package:jy_h5/model/validate/rule.dart';
import 'package:toast/toast.dart';

class ImplementEdited extends StatefulWidget {

  ImplementEdited({Key key,
    this.implementDetail
  }):super(key: key);

  final Implement implementDetail;

  @override
  _ImplementEditedState createState() => _ImplementEditedState();
}

class _ImplementEditedState extends State<ImplementEdited> {
  @override
  Widget build(BuildContext context) {
    vod = Provider.of<Ktv>(context).vodList;
    List data = vod.map((item){
      return item.brand;
    }).toList();
    ktvID = Provider.of<Ktv>(context).ktvID;
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            AppTitle(
              hasBack: true,
              title: '新建实施信息',
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      ListSelected(
                        title: 'vod品牌',
                        data: data,
                        initValue: fromData['vod_brand'],
                        onChange: (e){
                          fromData['vod_brand'] = vod[e].brand;
                        },
                      ),
                      ListInput(
                        title: '系统版本号',
                        value: fromData['vod_version'],
                        onChange: (e){
                          fromData['vod_version'] = e;
                        },
                      ),
                      ListInput(
                        title: 'vod场所ID',
                        value: fromData['vod_ktv_id'],
                        onChange: (e){
                          fromData['vod_ktv_id'] = e;
                        },
                      ),
                      ListInput(
                        title: '实施包厢数',
                        value: fromData['implement_box_count'],
                        onChange: (e){
                          fromData['implement_box_count'] = e;
                        },
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(40)
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(10)
                        ),
                        child: Button(
                          text: '保存',
                          onChange: (e){
                            _saveBtn();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  String title = '新增实施信息';
  List vod;
  int ktvID;
  Map fromData = {
    'vod_ktv_id': null,
    'vod_version': null,
    'vod_brand': null,
    'implement_box_count': null,
    'ktv': null,
  };

  Map rule = {
    'vod_ktv_id': [
      Rule(require: true, message: 'VOD场所ID不能为空',)
    ],
    'vod_version': [
      Rule(require: true, message: 'VOD系统版本号不能为空',),
    ],
    'vod_brand': [
      Rule(require: true, message: 'vod品牌不能为空',),
    ],
    'implement_box_count':[
      Rule(require: true, message: '实施包厢数不能为空',),
    ],
  };

  _saveBtn() async{
    bool validateState = Utils.validate(fromData, rule, context);
    if(validateState){
      int vodBrandId;
      vod.forEach((item){
        if(item.brand == fromData['vod_brand']){
          vodBrandId = item.id;
          return;
        }
      });

      var sendData = {
        'vod_ktv_id': fromData['vod_ktv_id'],
        'vod_version': fromData['vod_version'],
        'vod_brand': vodBrandId,
        'implement_box_count': fromData['implement_box_count'],
        'ktv': ktvID
      };
      print(sendData);

      try{
        var result = await addImplement(sendData, context);
        if(widget.implementDetail == null){
          Toast.show('创建成功', context, duration: 2, gravity: 1);
        }else{
          Toast.show('修改成功', context, duration: 2, gravity: 1);
        }
        var data = json.decode(result.toString());
        data['brand'] = fromData['vod_brand'];
        Implement res = Implement.fromJson(data);
        Navigator.of(context).pop(res);

      }catch(err){
        print(err);
      }
    }
  }

  @override
  void initState() {
    if(widget.implementDetail != null){
      title = '编辑实施信息';
      fromData['vod_ktv_id'] = widget.implementDetail.vodKtvId;
      fromData['vod_version'] = widget.implementDetail.vodVersion;
      fromData['vod_brand'] = widget.implementDetail.brand;
      fromData['implement_box_count'] = widget.implementDetail.implementBoxCount;
    }
    super.initState();
  }



}
