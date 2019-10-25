import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 自定义组件类
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/Strip.dart';
import 'package:jy_h5/common/components/ListDateSelect.dart';
import 'package:jy_h5/common/style.dart';
import 'package:jy_h5/common/components/Button.dart';
import 'package:jy_h5/libs/utils.dart';
import 'package:toast/toast.dart';
import 'package:jy_h5/model/validate/rule.dart';
import 'package:jy_h5/model/ktv.dart';



class KtvTime extends StatefulWidget {

  final BusinessHours businessHours;

  KtvTime({
    Key key,
    this.businessHours
  }):super(key: key);

  @override
  _KtvTimeState createState() => _KtvTimeState();
}

class _KtvTimeState extends State<KtvTime> {


  Map fromData = {
    'start': null,
    'end': null,
    'days':[]
  };

  Map rule = {
    'start': [
      Rule(require: true, message: '开始时间不能为空',)
    ],
    'end': [
      Rule(require: true, message: '结束时间不能为空',)
    ],
    'days':[
      Rule(require: true, message: '请选择工作日', type: ruleType.Array),
    ]
  };

  List weekList = [
    {
      'title': '全部',
      'value': false,
      'index': 0
    },
    {
      'title': '星期一',
      'value': false,
      'index': 1
    },
    {
      'title': '星期二',
      'value': false,
      'index': 2
    },
    {
      'title': '星期三',
      'value': false,
      'index': 3
    },
    {
      'title': '星期四',
      'value': false,
      'index': 4
    },
    {
      'title': '星期五',
      'value': false,
      'index': 5
    },
    {
      'title': '星期六',
      'value': false,
      'index': 6
    },
    {
      'title': '星期日',
      'value': false,
      'index': 7
    }
  ];




  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              AppTitle(
                hasBack: true,
                title: '营业时间',
              ),
              Strip(
                title: '营业时间',
              ),
              _radioWidget(),
              Expanded(
                flex: 1,
                child: PageView.builder(
                    itemCount: 2,
                    itemBuilder: _pageItemBuilder,
                    controller: pageController,
                    onPageChanged: (index){
                      print(index);
                      setState(() {
                        radio = index;
                      });
                    }
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(10),
                    bottom: ScreenUtil().setHeight(10)
                ),
                child: Button(
                  text: '保存',
                  onChange: (e){
                    _btnOK();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  int radio;
  PageController pageController;
  Duration duration = Duration(milliseconds: 200);
  Curve curve = Curves.easeOut;

  @override
  void initState() {
    pageController = PageController(initialPage: int.parse(widget.businessHours.flag));
    radio = int.parse(widget.businessHours.flag);
    fromData['start'] = widget.businessHours.start;
    fromData['end'] = widget.businessHours.end;
    print(widget.businessHours.start);
    for(var i = 0; i < widget.businessHours.days.length; i++){
      weekList[widget.businessHours.days[i]]['value'] = true;
    }
    super.initState();
  }

  Widget _radioWidget(){
    return Column(
      children: <Widget>[
        Container(
          width: ScreenUtil().width,
          height: ScreenUtil().setHeight(40),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              InkWell(
                child: Row(
                  children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: this.radio,
                      onChanged: (e){ move(0);},
                    ),
                    Text("全部时段", style: Style.listTitle(),)
                  ],
                ),
                onTap: (){
                  move(0);
                },
              ),
              SizedBox(
                width: ScreenUtil().setWidth(40),
              ),
              InkWell(
                child: Row(
                  children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: this.radio,
                      onChanged: (e){  move(1);},
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    Text("部分时段", style: Style.listTitle())
                  ],
                ),
                onTap: (){
                  move(1);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _pageItemBuilder(context,index){
    if(index == 0){
      return Container();
    }else{
      return _boxContent();
    }
  }

  Widget _boxContent(){
    return Container(
      child: Column(
        children: <Widget>[
          Strip(
            title: '选择工作时间',
          ),
          DatePick(
            title: '开始时间',
            type: DateType.TIME,
            value: fromData['start'],
            onChang: _startBtn,
          ),
          DatePick(
            title: '结束时间',
            type: DateType.TIME,
            value: fromData['end'],
            onChang: _endBtn,
          ),

          Strip(
            title: '选择工作日',
          ),
          Expanded(
            child:  _weekList(),
          )
        ],
      ),
    );
  }

  Widget _weekList(){
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: weekList.map((item){
            return _weekItem(item);
          }).toList(),
        ),
      ),
    );
  }

  Widget _weekItem(Map item){
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(item['title'], style: Style.listTitle(),),
              Checkbox(
                value: item['value'],
                activeColor: Colors.blue, //选中时的颜色
                onChanged:(val){
                  weekBtn( item['index'], val);
                } ,
              )
            ],
          ),
        ),
        Divider(
          height: 1,
          color: Color.fromRGBO(235, 237, 240, 1),
        )
      ],
    );
  }

  void move(int index){
    pageController.animateToPage(index, duration: duration, curve: curve);
    setState(() {
      this.radio = index;
    });
  }

  void weekBtn(int index, bool value){
    if(index == 0){
      setState(() {
        for(var i = 0; i < weekList.length; i++){
          weekList[i]['value'] = value;
        }
      });
    }else{
      setState(() {
        weekList[index]['value'] = value;
        bool flag = true;
        for(var i = 1; i < weekList.length; i++){
          if(!weekList[i]['value']){
            flag = false;
          }
        }
        weekList[0]['value'] = flag;
      });
    }
    for(var i = 1; i < weekList.length; i++){
      if(weekList[i]['value']){
        fromData['days'].add(i);
      }
    }
  }

  _startBtn(date){
    if(fromData['end'] != null && fromData['end'] != ''){
      if(!_differ(date, fromData['end'])){
        Toast.show('请选择正确的区间范围', context, duration: 2, gravity: 1);
      }else{
        setState(() {
          fromData['start'] = date;
        });
      }
    }else{
      setState(() {
        fromData['start'] = date;
      });
    }
  }

  _endBtn(date){
    if(fromData['start'] != null && fromData['start'] != ''){
      if(!_differ(fromData['start'], date)){
        Toast.show('请选择正确的区间范围', context, duration: 2, gravity: 1);
      }else{
        setState(() {
          fromData['end'] = date;
        });
      }
    }else{
      setState(() {
        fromData['end'] = date;
      });
    }
  }

  bool _differ(String dateA, String dateB){
    DateTime now = DateTime.now();
    List arr1 = dateA.split(':');
    List arr2 = dateB.split(':');
    DateTime a = DateTime(now.year, now.month, now.day, int.parse(arr1[0]), int.parse(arr1[1]), int.parse(arr1[2]));
    DateTime b = DateTime(now.year, now.month, now.day, int.parse(arr2[0]), int.parse(arr2[1]), int.parse(arr2[2]));
    return a.isBefore(b);
  }

  _btnOK(){
    if(this.radio == 0){
      Map result = {
        'flag': 0,
        'days': [1,2,3,4,5,6,7],
        'start': '',
        'end': ''
      };
      Navigator.pop(context, result);
    }else{
    bool validateState = Utils.validate(fromData, rule, context);
    if(validateState){
      Map result = {
        'flag': 1,
        'days': fromData['days'],
        'start': fromData['start'],
        'end': fromData['end']
      };
      Navigator.pop(context, result);
     }
    }
  }





}


