import 'package:flutter/material.dart';
// 自定义组件
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/components/ListItem.dart';
import 'components/system_upgrade.dart';
import 'package:jy_h5/common/components/ListPicker.dart';
import 'package:jy_h5/common/components/Dialog.dart';

class ImplementDetail extends StatefulWidget {
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
          label: 'ppp',
        ),
        ListItem(
          title: '系统版本号',
          label: 'ppp',
        ),
        ListItem(
          title: 'vod场所ID',
          label: 'ppp',
        ),
        ListItem(
          title: '实施包厢数',
          label: '12',
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
    }
  }

  _upgrade(){

    SystemUpgrade.show(
        context,
        initValue: 'v1.2.0'
    ).then((val){
      print(val);
    });

  }

  _upRecord(){

    DialogWidget.loading(context);
  }



}
