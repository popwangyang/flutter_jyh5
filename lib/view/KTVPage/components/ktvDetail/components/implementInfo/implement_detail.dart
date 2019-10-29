import 'package:flutter/material.dart';
// 自定义组件
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/components/ListItem.dart';
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

  Widget _pick(){
    return Material(
      child: Container(
        width: ScreenUtil().setHeight(375),
        height: ScreenUtil().setHeight(216),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(93.75 * 3),
              height: ScreenUtil().setHeight(216),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Wrap(
                    children: number.map((item){
                      return _pickItem1(item);
                    }).toList(),
                  ),
                  Row(
                    children: <Widget>[
                      FlatButton(
                        child: Container(
                          width: ScreenUtil().setWidth(187.5),
                          height: ScreenUtil().setHeight(54),
                          decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    width: 1,
                                    color: Color(0xffebedf0)
                                ),
                              )
                          ),
                          child: Center(
                            child: Text('0', style: TextStyle(
                                fontSize: ScreenUtil().setSp(24),
                                fontWeight: FontWeight.w600,
                                color: Colors.black
                            ),),
                          ),
                        ),
                        onPressed: (){

                        },
                      ),
                      FlatButton(
                        child: Container(
                          width: ScreenUtil().setWidth(93.75),
                          height: ScreenUtil().setHeight(54),
                          decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    width: 1,
                                    color: Color(0xffebedf0)
                                ),
                              )
                          ),
                          child: Center(
                            child: Text('.', style: TextStyle(
                                fontSize: ScreenUtil().setSp(24),
                                fontWeight: FontWeight.w600,
                                color: Colors.black
                            ),),
                          ),
                        ),
                        onPressed: (){

                        },
                      ),
                    ],
                  )
                ],
              )
              ),
            Container(
              width: ScreenUtil().setWidth(93.75),
              height: ScreenUtil().setHeight(216),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      color: Color(0xffebedf0),
                      child: Container(
                        width: ScreenUtil().setWidth(93.75),
                        child: Center(
                          child: Text(
                            '删除',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(16),
                                color: Colors.black
                            ),
                          ),
                        ),
                      ),
                      onPressed: (){

                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child:FlatButton(
                      color: Color(0xff1989fa),
                      child: Container(
                        width: ScreenUtil().setWidth(93.75),
                        child: Center(
                          child: Text(
                            '完成',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(16),
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      onPressed: (){

                      },
                    ) ,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pickItem1(String num){
    return FlatButton(
      child: Container(
        width: ScreenUtil().setWidth(93.75),
        height: ScreenUtil().setHeight(54),
        decoration: BoxDecoration(
            border: Border(
                right: BorderSide(
                    width: 1,
                    color: Color(0xffebedf0)
                ),
                bottom: BorderSide(
                    width: 1,
                    color: Color(0xffebedf0)
                )
            )
        ),
        child: Center(
          child: Text(num, style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),),
        ),
      ),
      onPressed: (){
        print(num);
      },
    );
  }

  Widget _messageWidget(){
    return Container(
      child: Column(
        children: <Widget>[
          Text.rich(TextSpan(
            children: [
              TextSpan(
                text: '当前版本',
              ),
              TextSpan(
                text: 'V1.0.1',
                style: TextStyle(
                  color: Colors.grey
                )
              )
            ]
          )),
          TextField(

          )
        ],
      ),
    );
  }

  List number = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];

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
    }
  }

  _upgrade(){

    DialogWidget.confirm(
        context,
      title: '升级系统',
      messageWidget: _messageWidget()
    );


  }


}
