import 'package:flutter/material.dart';
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/model/merchant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/components/ListItem.dart';
import 'package:jy_h5/api/merchant.api.dart';



class MerchantDetail extends StatefulWidget {
  @override
  _MerchantDetailState createState() => _MerchantDetailState();
}

class _MerchantDetailState extends State<MerchantDetail> {

  Merchant merchant;

  @override
  Widget build(BuildContext context) {
    merchant = ModalRoute.of(context).settings.arguments;
    getData();
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            AppTitle(hasBack: true, title: '${merchant.name}',),
            Expanded(
              flex: 1,
              child: Container(
                color: Color.fromRGBO(246, 246, 246, 1),
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(15),
                    right: ScreenUtil().setWidth(15),
                    top: ScreenUtil().setHeight(10)
                ),
                child: Column(
                  children: <Widget>[
                    _title(),
                    ListItem(
                      title: "账号",
                      label: "1375441740@qq.com",
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget _title(){
    return Container(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(10), right: ScreenUtil().setWidth(10)),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/image/detailtitleBG.png'),
          fit: BoxFit.fitWidth
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(250),
            child: Text("商户名称商户名称商商户名称", style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: ScreenUtil().setSp(16)
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            ),
          ),
          RaisedButton(
            color: Color.fromRGBO(24, 82, 243, 1),
            highlightColor: Color.fromRGBO(61, 158, 255, 1),
            colorBrightness: Brightness.dark,
            splashColor: Colors.grey,
            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
            child: Container(
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(12),
                    right: ScreenUtil().setWidth(12),
                    top: ScreenUtil().setWidth(2),
                    bottom: ScreenUtil().setWidth(2)),
                child: Text("编辑",style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(12)
                  ),
                ),
            ),
            onPressed: () {
              print('ppppppppppppp');
            }
          )
        ],
      ),
    );
  }

  @override
  void initState() {

    super.initState();
  }

  getData() async{
    print(merchant);
    var result = await getMerchantDetail(merchant.id, context);

    print(result);

  }


}


