import 'package:flutter/material.dart';
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/model/merchant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/components/ListItem.dart';
import 'package:jy_h5/api/merchant.api.dart';
import 'package:jy_h5/common/components/PageContent.dart';
import 'package:jy_h5/common/style.dart';
import 'edited.dart';
import 'dart:convert';



class MerchantDetail extends StatefulWidget {

  final Merchant merchant;

  MerchantDetail({Key key, this.merchant}):super(key: key);

  @override
  _MerchantDetailState createState() => _MerchantDetailState();
}

class _MerchantDetailState extends State<MerchantDetail> {

  int pageStatues = 1;
  MerchantDetailModel merchantDetailModel;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            AppTitle(hasBack: true, title: '${widget.merchant.name}',),
            Expanded(
              flex: 1,
              child: Container(
                color: Color.fromRGBO(246, 246, 246, 1),
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(15),
                    right: ScreenUtil().setWidth(15),
                    top: ScreenUtil().setHeight(10),
                    bottom: ScreenUtil().setHeight(10)
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child:PageContent(
                        pageStatues: pageStatues,
                        content: _content,
                        reload: getData,
                      ),
                    ),
                  ],
                ) ,
              ),
            )
          ],
        ),
      ),
    );
  }


  //页面标体
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
            child: Text("${widget.merchant.name}", style: TextStyle(
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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) {
                    return MerchantEdited();
                  })
              );
            }
          )
        ],
      ),
    );
  }

  //页面内容
  Widget _content(){
    return Container(
      child: Column(
        children: <Widget>[
          _title(),
          ListItem(
            title: '商户ID',
            label: '${merchantDetailModel.merchantID}',
          ),
          ListItem(
            title: '账号',
            label: '${merchantDetailModel.phone}',
          ),
          ListItem(
            title: '品牌名称',
            label: '${merchantDetailModel.brandName}',
          ),
          ListItem(
            title: '邮箱账号',
            label: '${merchantDetailModel.email == null ? '暂无':merchantDetailModel.email}',
          ),
          ListItem(
            title: '账号状态',
            label: '${merchantDetailModel.accountStatues ? '已启用':'已禁用'}',
          ),
          ListItem(
            title: '创建日期',
            label: '${merchantDetailModel.createDate}',
            isLast: true,
          ),
          Container(
            height: ScreenUtil().setHeight(40),
            width: ScreenUtil().width,
            alignment: Alignment.centerLeft,
            child: Text("关联场所：${merchantDetailModel.ktvList.length}", style: Style.navTitle()),
          ),
          Container(
            child: Column(
              children: merchantDetailModel.ktvList.map((item){
                index++;
                return ListItem(
                  title: '${item.name}',
                  isLast: index == merchantDetailModel.ktvList.length,
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }


  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async{
    setState(() {
      pageStatues = 1;
    });
    try{
      var result = await getMerchantDetail(widget.merchant.id, context);
      print(result);
      merchantDetailModel = MerchantDetailModel.fromJson(json.decode(result.toString()));
      print("${merchantDetailModel.merchantID}");
      setState(() {
        pageStatues = 2;
      });
    }catch(err){
      print(err);
      setState(() {
        pageStatues = 3;
      });
    }
  }



}




