import 'package:flutter/material.dart';

// 自定义组件类
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/PageContent.dart';
import '../widgets.dart';
import 'package:jy_h5/common/components/ListItem.dart';
import 'package:jy_h5/view/KTVPage/components/ktvEdite/ktvEdite.dart';

// 工具类
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jy_h5/api/ktv.api.dart';
import 'package:jy_h5/model/ktv.dart';
import 'package:jy_h5/libs/utils.dart';
import 'dart:convert';


class KtvDetail extends StatefulWidget {

  final KTV ktv;
  KtvDetail({Key key, this.ktv}): super(key: key);

  @override
  _KtvDetailState createState() => _KtvDetailState();
}

class _KtvDetailState extends State<KtvDetail> {

  int pageStatues = 1;

  List tabList = [
    {
      'imgUrl': 'lib/assets/image/qiye.png',
      'title': '企业信息'
    },
    {
      'imgUrl': 'lib/assets/image/shishi.png',
      'title': '实施信息'
    },
    {
      'imgUrl': 'lib/assets/image/qianyue.png',
      'title': '签约信息'
    },
    {
      'imgUrl': 'lib/assets/image/zhanghao.png',
      'title': '账号信息'
    },
    {
      'imgUrl': 'lib/assets/image/xianxia.png',
      'title': '线下充值'
    },
  ];

  KtvDetailModel ktvDetailModel;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       child: Column(
         children: <Widget>[
           AppTitle(hasBack: true, title: widget.ktv.name,),
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
               child:PageContent(
                 pageStatues: pageStatues,
                 content: _content,
                 reload: getData,
               ),
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
      width: ScreenUtil().width,
      height: ScreenUtil().setWidth(55),
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(10), right: ScreenUtil().setWidth(10)),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('lib/assets/image/ktvDetailTitle.png'),
              fit: BoxFit.fitWidth
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(260),
                  child: Text(widget.ktv.name, style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: ScreenUtil().setSp(16)
                  ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    (){
                      if(widget.ktv.type == 1){
                        return LF();
                      }else{
                        return YZH();
                      }
                    }(),
                    Text(widget.ktv.merchant_name,style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(12)
                    ))
                  ],
                )
              ],
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
                Navigator.push(context, MaterialPageRoute(builder: (_){
                  return KtvEdited(ktv: ktvDetailModel,);
                }));
              }
          )
        ],
      ),
    );
  }

  // 页面内容
  Widget _content(){

    return Container(
      child: Column(
        children: <Widget>[
          _title(),
          ListItem(
            title: '联系人',
            label: ktvDetailModel.contact,
          ),
          ListItem(
            title: '手机号',
            label: ktvDetailModel.phoneNumber,
          ),
          ListItem(
            title: '场所电话',
            label: ktvDetailModel.placeContact,
          ),
          ListItem(
            title: '商户地址',
            label: ktvDetailModel.detailAddress,
          ),
          InkWell(
            child: Container(
              height: ScreenUtil().setHeight(48),
              color: Color.fromRGBO(239, 238, 243, 1),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.phone_in_talk,
                    size: ScreenUtil().setSp(20),
                    color: Color(0xff2bc8d6),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "联系商家",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),)
                ],
              ),
            ),
            onTap: (){
              _launchURL('102301293');

            },
          ),
          Container(
            height: ScreenUtil().setHeight(40),
            width: ScreenUtil().width,
            alignment: Alignment.centerLeft,
            child: Text("营业时间", style: Style.navTitle()),
          ),
          ListItem1(
            title: '开业时间',
            label: Utils.dateChang(ktvDetailModel.openingHours),
          ),
          ListItem1(
            isLast: true,
            title: '营业时间',
            label: ktvDetailModel.businessHours.toString(),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          _tabList(),

        ],
      ),
    );
  }

  // 详情页tab列表
  Widget _tabList(){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(10, 16, 10, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tabList.map((item){
          return _itemTabList(item['imgUrl'], item['title']);
        }).toList(),
      ),
    );
  }


  // 详情子项
  Widget _itemTabList(String imgUrl, String title){

    return Container(
      child:  Column(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(52),
            height: ScreenUtil().setHeight(52),
            child: Image.asset(
              imgUrl,
              width: ScreenUtil().setWidth(50),
              height: ScreenUtil().setHeight(50),
              fit: BoxFit.contain,
            ),
          ),
          Text(title, style: TextStyle(
            fontSize: ScreenUtil().setSp(12),
            color: Colors.black,
          ),)
        ],
      ),
    );
  }


  @override
  void initState() {
    getData();
    super.initState();
  }

  // 打电话
  void _launchURL(String phone) async {
    String url = 'tel:'+phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getData() async{
    setState(() {
      pageStatues = 1;
    });
    try{
      var data = await getKTVDetail(widget.ktv.id, context);
      ktvDetailModel = KtvDetailModel.fromJson(json.decode(data.toString()));
      print(ktvDetailModel);
      setState(() {
        pageStatues = 2;
      });
    }catch(err){
      setState(() {
        pageStatues = 3;
      });
    }
  }
}
