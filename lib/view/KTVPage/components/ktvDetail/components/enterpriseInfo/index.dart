// 依赖包
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

// 自定义组件
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/PageContent.dart';
import 'package:jy_h5/common/components/Empty.dart';
import 'package:jy_h5/common/components/Button.dart';
import 'enterprise_edited.dart';
import 'enterprise_detail.dart';

// api
import 'package:jy_h5/api/ktv.api.dart';

// 企业模型
import 'package:jy_h5/model/ktv.dart';

// provider组件
import 'package:provider/provider.dart';
import 'package:jy_h5/store/model/ktvModel.dart';



class EnterprisePage extends StatefulWidget {

  EnterprisePage({
    Key key,
    this.ktvID}):super(key: key);

  final int ktvID;

  @override
  _EnterprisePageState createState() => _EnterprisePageState();
}

class _EnterprisePageState extends State<EnterprisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AppTitle(
            hasBack: true,
            title: '企业信息',
          ),
          Expanded(
            flex: 1,
            child: PageContent(
              pageStatues: pageStatues,
              content: _content,
              reload: getData,
              emptyWidget: _emptyWidget(),
            ),
          )

        ],
      ),
    );
  }

  int pageStatues = 1;
  Enterprise enterprise;

  Widget _content(){
    return EnterpriseDetail(
      enterprise: enterprise,
    );
  }

  Widget _emptyWidget(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Empty(
            text: '暂无企业信息',
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(10)
            ),
            child:  ButtonCircle(
              text: '新建企业信息',
              onClick: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_){
                      return EnterpriseEdited();
                    }
                  )
                );
              },
            ),
          ),
        ],
      ),
    );
  }



  getData() async{
    setState(() {
      pageStatues = 1;
    });
    try{
      var res = await getEnterprise(widget.ktvID, context);
      List result = json.decode(res.toString())['results'];
      if(result.length > 0){
        pageStatues = 2;
        enterprise = Enterprise.fromJson(result[0]);
      }else{
        pageStatues = 4;
      }
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

