import 'package:flutter/material.dart';
// 自定义组件
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/components/ListItem.dart';
import 'package:toast/toast.dart';

import 'package:jy_h5/common/components/ListPicker.dart';
import 'package:jy_h5/common/components/Dialog.dart';
import 'dart:async';
import 'package:jy_h5/api/ktv.api.dart';
import 'package:jy_h5/model/ktv.dart';

import 'components/system_upgrade.dart';
import 'components/record_upgrade.dart';
import 'components/record_implement.dart';
import 'implement_edited.dart';

class ImplementDetail extends StatefulWidget {

  ImplementDetail({
    Key key,
    this.implement,
    this.ktvID
  }):super(key: key);

  final Implement implement;
  final int ktvID;

  @override
  _ImplementDetailState createState() => _ImplementDetailState();
}

class _ImplementDetailState extends State<ImplementDetail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListItem(
          title: 'vod品牌',
          label: _implement.brand,
        ),
        ListItem(
          title: '系统版本号',
          label: _implement.vodVersion,
        ),
        ListItem(
          title: 'vod场所ID',
          label: _implement.vodKtvId,
        ),
        ListItem(
          title: '实施包厢数',
          label: _implement.implementBoxCount.toString(),
        ),
        _tabList()
      ],
    );
  }
  
  Widget _tabList(){
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(10)
      ),
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: tabList.map((item){
          return _tabItem(item);
        }).toList(),
      ),
    );
  }
  
  Widget _tabItem(data){
    return FlatButton(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset(
                data['imgUrl'],
                width: ScreenUtil().setWidth(56),
                height: ScreenUtil().setHeight(56),
                fit: BoxFit.contain,
              ),
            ),
            Text(data['title'], style: TextStyle(
                fontSize: ScreenUtil().setSp(12),
                color: Colors.black,
                fontWeight: FontWeight.w600
            ),)
          ],
        ),
      ),
      onPressed: (){
        _tabBtn(data['index']);
      },
    );
  }

  Implement _implement;
  List tabList = [
    {
      'index': 0,
      'title': '升级系统',
      'imgUrl': 'lib/assets/image/implement_upXT.png',
    },
    {
      'index': 1,
      'title': '升级记录',
      'imgUrl': 'lib/assets/image/implement_upJL.png'
    },
    {
      'index': 2,
      'title': '编辑',
      'imgUrl': 'lib/assets/image/implement_edited.png'
    },
    {
      'index': 3,
      'title': '新增实施',
      'imgUrl': 'lib/assets/image/implement_add.png'
    },
    {
      'index': 4,
      'title': '实施记录',
      'imgUrl': 'lib/assets/image/implement_record.png'
    },
  ];

  _tabBtn(int index){
    switch(index){
      case 0:
        _upgrade();
        break;
      case 1:
        _upRecord();
        break;
      case 2:
        _edited();
        break;
      case 3:
        _add();
        break;
      case 4:
        _impRecord();
        break;
    }
  }

  _upgrade(){
    print(_implement.vodVersion);

    SystemUpgrade.show(
        context,
        initValue: _implement.vodVersion
    ).then((val){
      if(val != null && val != ''){
        var sendData = {
          'original_version': _implement.vodVersion,
          'new_version': val,
          'vod_ktv': widget.ktvID
        };
        print(sendData);
        upgradeVod(sendData, context).then((res){
          setState(() {
            _implement.vodVersion = val;
          });
          Toast.show('升级成功', context, duration: 1, gravity: 1);
        });
      }
    });

  }

  _upRecord(){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_){
        return RecordUpgrade(
          ktvID: widget.ktvID,
        );
      }
    ));
  }

  _edited() async{
   Implement result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (_){
        return ImplementEdited(
          implementDetail: _implement,
        );
      }
    ));
   if(result != null){
     setState(() {
       _implement = result;
     });
   }

  }

  _add(){
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_){
              return ImplementEdited();
            }
        )
    );
  }

  _impRecord(){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_){
          return ImplementRecord(
            ktvID: widget.ktvID,
          );
        }
    ));
  }

  @override
  void initState() {
    _implement = widget.implement;
    super.initState();
  }


}
