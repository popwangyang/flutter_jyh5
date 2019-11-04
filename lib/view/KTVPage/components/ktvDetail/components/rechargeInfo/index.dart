import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/Button.dart';
import 'package:jy_h5/common/components/ListItem.dart';
import 'package:jy_h5/common/components/PageContent.dart';
import 'package:jy_h5/common/ValueNotifier.dart';
import 'package:jy_h5/model/recharge.dart';
import 'package:jy_h5/api/ktv.api.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:jy_h5/store/model/ktvModel.dart';


class RechargePage extends StatefulWidget {
  RechargePage({
    Key key,
    this.boxCount}):super(key: key);
  final int boxCount;
  @override
  _RechargePageState createState() => _RechargePageState();
}

class _RechargePageState extends State<RechargePage> {
  @override
  Widget build(BuildContext context) {
    ktvBalance = Provider.of<Ktv>(context).balance;
    ktvBoxCount = Provider.of<Ktv>(context).boxCount;
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            AppTitle(
              hasBack: true,
              title: '充值',
            ),
            Expanded(
              flex: 1,
              child: PageContent(
                pageStatues: pageStatues,
                reload: getData,
                content: _content,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _content(){

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: ScreenUtil().width,
            height: ScreenUtil().setHeight(140.0),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/image/offlineRechargeBG.png'),
                fit: BoxFit.fitHeight
              )
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("账户余额", style: TextStyle(
                      fontSize: ScreenUtil().setSp(16),
                      color: Colors.white,
                    ),),
                    Text("充值记录", style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      color: Colors.white
                    ),)
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(16)
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text.rich(TextSpan(
                          children: [
                            TextSpan(
                                text: '￥',
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(12),
                                    color: Colors.white
                                )
                            ),
                            TextSpan(
                                text: ktvBalance,
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(24),
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600
                                )
                            )
                          ]
                      ))
                  ),
                ),
                _tab(),
              ],
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(540),
            child: _tabContent(),
          )
        ],
      ),
    );
  }

  Widget _tab(){
    return Container(
      width: ScreenUtil().setWidth(340),
      height: ScreenUtil().setHeight(45),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(6.0)
        ),
        color: Colors.white
      ),
      child: TabButton(
        textRight: '一次性充值',
        textLeft: '包厢充值',
        onChang: (int state){
          pageController.animateToPage(
              state,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut
          );
        },
        vn:vn
      ),
    );
  }

  Widget _tabContent(){
    return PageView.builder(
        itemBuilder: ((context, index){
          if(index == 0){
            return boxRecharge();
          }else{
            return oneTimeRecharge();
          }
        }),
        controller: pageController,
        itemCount: 2,
        onPageChanged: (index){
          vn.value = index.toString();
        },
    );
  }

  Widget boxRecharge(){

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: ScreenUtil().width,
            height: ScreenUtil().setHeight(220),
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(10)
            ),
            child: SingleChildScrollView(
              child: Wrap(
                children: rechargeList1.map((item){
                  return RechargeBox(
                    recharge: item,
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(10)
            ),
            child: ListItem(
              title: '包厢数量',
              label: ktvBoxCount,
            ),
          ),
          ListItem(
            title: '支付金额',
            label: '0.00元',
          ),
          ListItem(
            title: '实际到账',
            label: '0.00元',
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.all(ScreenUtil().setHeight(10)),
            child: Text("注：支付金额=包厢数量*包厢充值单价"),
          ),
          Container(
            margin: EdgeInsets.only(
               left: ScreenUtil().setWidth(10),
               right: ScreenUtil().setWidth(10),
               top: ScreenUtil().setHeight(10)
            ),
            child: Button(
              text: '提交充值',
              onChange: (e){

              },
            ),
          )
        ],
      ),
    );
  }

  Widget oneTimeRecharge(){
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: ScreenUtil().width,
            height: ScreenUtil().setHeight(220),
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(10)
            ),
            child: SingleChildScrollView(
              child: Wrap(
                children: rechargeList2.map((item){
                  return RechargeBox(
                    recharge: item,
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(10)
            ),
            child: Column(
              children: <Widget>[
                ListItem(
                  title: '支付金额',
                  label: '2.00元',
                ),
                ListItem(
                  title: '实际到账',
                  label: '4.00元',
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(10),
            ),
            child: Button(
              text: '提交充值',
              onChange: (e){

              },
            ),
          )
        ],
      ),
    );
  }

  int pageStatues;
  String balance;
  ValueNotifierData vn = ValueNotifierData('0');
  PageController pageController = PageController(initialPage: 0);
  List rechargeList1 = [];
  List rechargeList2 = [];
  int ktvBoxCount;  // ktv包厢数；
  String ktvBalance; // ktv余额；

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
      setState(() {});
    }catch(err){
      setState(() {
        pageStatues = 3;
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

}

class AnimationButton extends AnimatedWidget{
  AnimationButton({
    Key key,
    Animation<double> animation,
    this.textLeft,
    this.textRight,
    this.onTap,
  }): super(key: key, listenable: animation);

  final String textLeft;
  final String textRight;
  final Function onTap;

  final Tween _bgTween = new ColorTween(
      begin: Color(0xff2350c1),
      end: Colors.white
  );

  final Tween _colorTween = ColorTween(
      begin: Colors.white,
      end: Colors.black
  );

  final Tween _bgTween1 = new ColorTween(
      begin: Colors.white,
      end: Color(0xff2350c1)
  );

  final Tween _colorTween1 = ColorTween(
      begin: Colors.black,
      end: Colors.white
  );

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: InkWell(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color:_bgTween.evaluate(animation),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6.0)
                    )
                ),
                child: Text(textLeft, style: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                    color: _colorTween.evaluate(animation)
                ),),
              ),
              onTap: (){
                onTap(0);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color:_bgTween1.evaluate(animation),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(6.0)
                    )
                ),
                child: Text(textRight, style: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                    color: _colorTween1.evaluate(animation)
                ),),
              ),
              onTap: (){
                onTap(1);
              },
            ),
          )
        ],
      ),
    );
  }
}

class TabButton extends StatefulWidget {
  TabButton({
    Key key,
    this.textLeft,
    this.textRight,
    this.onChang,
    this.vn
  }):super(key: key);

  final String textLeft;
  final String textRight;
  final Function onChang;
  final ValueNotifierData vn;

  @override
  _TabButtonState createState() => _TabButtonState();
}

class _TabButtonState extends State<TabButton> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimationButton(
      animation: animation,
      textLeft: widget.textLeft,
      textRight: widget.textRight,
      onTap: _onTap,
    );
  }

  @override
  void initState() {
    controller = new AnimationController(
        duration: const Duration(milliseconds: 160), vsync: this);
    animation = new Tween(begin: 0.0, end: 1.0).animate(controller);
    widget.vn.addListener(_vnChang);
    super.initState();
  }

  _vnChang(){
    if(widget.vn.value == '1'){
      controller.forward();
    }else{
      controller.reverse();
    }
  }

  _onTap(int state){
    widget.onChang(state);
    if(state == 0){
      controller.reverse();
    }else{
      controller.forward();
    }
  }
}

class RechargeBox extends StatelessWidget {

  RechargeBox({
    Key key,
    this.checked = false,
    this.recharge,
  }):super(key: key);

  final bool checked;
  final RechargeModel recharge;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = checked ? Color(0xff4479ef):Colors.white;
    final Color textColor = !checked ? Color(0xff4479ef):Colors.white;
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: ScreenUtil().setWidth(105),
          height: ScreenUtil().setHeight(80),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                  color: Color(0xff4479ef),
                  width: 1
              ),
              color: bgColor
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("${recharge.rechargeAmount}元", style: TextStyle(
                  fontSize: ScreenUtil().setSp(16.0),
                  fontWeight: FontWeight.w600,
                  color: textColor
              ),),
              Text(recharge.preferentialDetail,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(12),
                  color: textColor
              ),)
            ],
          ),
        ),
        (){
           if(recharge.tag != null && recharge.tag != ''){
             return _position(recharge.tag);
           }else{
             return Container();
           }
         }()
      ],
    );
  }

  Widget _position(String tag){
    return Positioned(
      right: 0,
      top: 0,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(8),
          vertical: ScreenUtil().setHeight(2)
        ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(17.0),
            topRight: Radius.circular(17.0),
            bottomRight: Radius.circular(17.0)
          )
        ),
        child: Text(tag, style: TextStyle(
          fontSize: ScreenUtil().setSp(12),
          color: Colors.white,
        ),),
      ),
    );
  }
}
