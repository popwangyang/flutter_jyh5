import 'package:flutter/material.dart';
import '../../common/components/Appbar.dart';
import '../../common/components/Search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ShanghuPage extends StatefulWidget {
  @override
  _ShanghuPageState createState() => _ShanghuPageState();
}

class _ShanghuPageState extends State<ShanghuPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            AppTitle(
              title: '商户管理',
            ),
            Search(
              plplaceholder: '请输入商户名称',
            ),
            _divider(),
            Expanded(
              flex: 1,
              child: Container(
                child: ListView.builder(
                    padding: EdgeInsets.only(top: 0),
                    itemCount: 100,
                    itemBuilder: (BuildContext context, int index) {
                      return _listItemWidget();
                    }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _divider(){
    return Divider(
      height: 1,
      color: Color.fromRGBO(246, 246, 246, 1),
    );
  }

  Widget _listItemWidget(){
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("商户名称A", style: TextStyle(
              fontSize: ScreenUtil.getInstance().setSp(14),
              color: Color.fromRGBO(68, 68, 68, 1),
              fontWeight: FontWeight.w400
            ),),
            subtitle: Text("5家厂所", style: TextStyle(
              color: Color.fromRGBO(153, 153, 153, 1),
              fontSize: ScreenUtil.getInstance().setSp(10),
              fontWeight: FontWeight.w400,

            ),),
            trailing: Icon(Icons.arrow_forward_ios, size: ScreenUtil.getInstance().setSp(16), color: Color.fromRGBO(153, 153, 153, 1),),
            onTap: (){
              print("丁阿基");
            },
          ),
          _divider(),
        ],
      ),
    );
  }
}

