import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 自定义组件类
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/Strip.dart';
import 'package:jy_h5/common/components/ListDateSelect.dart';
import 'package:jy_h5/common/style.dart';

class KtvTime extends StatefulWidget {
  @override
  _KtvTimeState createState() => _KtvTimeState();
}

class _KtvTimeState extends State<KtvTime> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
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
                  reverse: false,
                  onPageChanged: (index){
                    print(index);
                    setState(() {
                      radio = index;
                    });
                  }

              ),
            )


          ],
        ),
      ),
    );
  }

  int radio = 1;
  PageController pageController = PageController(initialPage: 1);
  Duration duration = Duration(milliseconds: 200);
  Curve curve = Curves.easeOut;

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
          DateSelect(
            title: '开始时间',
            type: DateType.TIME,
            initValue: null,
            onChang: (date){
              print(date);
              fromData['start'] = date;
            },
          ),
          DateSelect(
            title: '结束时间',
            type: DateType.TIME,
            onChang: (date){
              fromData['end'] = date;
            },
          ),
          Strip(
            title: '选择工作日',
          ),
        ],
      ),
    );
  }

  void move(int index){
    pageController.animateToPage(index, duration: duration, curve: curve);
    setState(() {
      this.radio = index;
    });
  }


  Map fromData = {};
}


