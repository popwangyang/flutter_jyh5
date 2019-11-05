import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/Button.dart';
import 'package:jy_h5/common/components/ListItem.dart';

class RechargeSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              child: _context(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _context(BuildContext context){
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: ScreenUtil().width,
            height: ScreenUtil().setHeight(200),
            color: Colors.white,
            margin: EdgeInsets.only(
              bottom: ScreenUtil().setHeight(10)
            ),
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(50)
            ),
            child: Column(
              children: <Widget>[
                Image.asset(
                    'lib/assets/image/rechargeSuccess.png',
                  width: ScreenUtil().setWidth(52),
                  height: ScreenUtil().setHeight(52),
                ),
                Text("提交充值成功", style: TextStyle(
                  fontSize: ScreenUtil().setSp(24),
                  color: Colors.black,
                  fontWeight: FontWeight.w400
                ),),
                Text("我们将尽快为您完成充值", style: TextStyle(
                  fontSize: ScreenUtil().setSp(12),
                  color: Color(0xff999999)
                ),)
              ],
            ),
          ),
          ListItem(
            title: '支付金额',
            label: '20.0元',
          ),
          ListItem(
            title: '实际到账',
            label: '20.0元',
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(30),
              horizontal: ScreenUtil().setWidth(10)
            ),
            child: Button(
              text: '完成',
              onChange: (e){
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}
