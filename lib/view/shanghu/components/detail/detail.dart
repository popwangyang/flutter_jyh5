import 'package:flutter/material.dart';
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/model/merchant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/components/ListItem.dart';
import 'package:jy_h5/api/merchant.api.dart';
import 'package:jy_h5/common/components/PageContent.dart';
import 'package:jy_h5/common/style.dart';
import 'package:jy_h5/common/components/Strip.dart';
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
                    left: ScreenUtil().setWidth(10),
                    right: ScreenUtil().setWidth(10),
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
      height: ScreenUtil().setHeight(50),
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(10),
          right: ScreenUtil().setWidth(10)
      ),
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
          InkWell(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors:[
                          Color.fromRGBO(61, 158, 255, 1),
                          Color.fromRGBO(24, 82, 243, 1)
                        ]
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [ //阴影
                      BoxShadow(
                          color:Colors.black45,
                          offset: Offset(1.0,1.0),
                          blurRadius: 2.0
                      )
                    ]//背景渐变
                ),
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
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return MerchantEdited(
                        merchantDetailModel: merchantDetailModel,
                      );
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
          Strip(
            title: "关联场所：${merchantDetailModel.ktvList.length}",
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




