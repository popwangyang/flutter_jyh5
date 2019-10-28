// 依赖包
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

// 自定义组件
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/PageContent.dart';
import 'package:jy_h5/common/components/Empty.dart';
import 'package:jy_h5/common/components/Button.dart';
import 'enterprise_edited.dart';



class EnterprisePage extends StatefulWidget {
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

  Widget _content(){
    return Container(
      color: Colors.white,
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
    Future.delayed(Duration(seconds: 1), (){
      setState(() {
        pageStatues = 4;
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }
}
