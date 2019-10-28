// 依赖包
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

// 自定义组件
import 'package:jy_h5/common/components/Strip.dart';
import 'package:jy_h5/common/components/ListItem.dart';
import 'package:jy_h5/model/ktv.dart';
import 'package:jy_h5/common/style.dart';

class EnterpriseDetail extends StatelessWidget {

  EnterpriseDetail({
    Key key,
    this.enterprise
  }): super(key: key);
  final Enterprise enterprise;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Strip(
                title: '企业信息',
              ),
              ListItem(
                title: '企业注册名称',
                label: enterprise.companyName,
              ),
              ListItem(
                title: '营业执照编号',
                label: enterprise.licenseNumber,
                isLast: true,
              ),
                  (){
                if(enterprise.licensePhoto !=null){
                  return _box(
                      '营业执照照片',
                      enterprise.licensePhoto
                  );
                }else{
                  return Container();
                }
              }(),
              Strip(
                title: '法人信息',
              ),
              ListItem(
                title: '法人名称',
                label: enterprise.legalRepresentative,
              ),
              Opacity(
                opacity: enterprise.legalRepresentativeCard == null ? 0:1,
                child: ListItem(
                  title: '身份证号',
                  label: enterprise.legalRepresentativeCard,
                ),
              ),
                  (){
                if(enterprise.identityCardPhoto !=null){
                  return _box(
                      '身份证照片',
                      enterprise.identityCardPhoto
                  );
                }else{
                  return Container();
                }
              }(),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: ScreenUtil().width,
            height: ScreenUtil().setHeight(50),
            color: Colors.white,
            child: Text("pppppp"),
          ),
        )
      ],
    );
  }


  Widget _box(String title, UploadResult data){
    return Container(
      width: ScreenUtil().width,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setWidth(10),
        horizontal: ScreenUtil().setHeight(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Style.listTitle(),),
          Container(
            color: Color(0xfff6f6f6),
            width: ScreenUtil().width,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(10)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'lib/assets/image/imgBox.png',
                  width: ScreenUtil().setWidth(18),
                  height: ScreenUtil().setHeight(14),
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(data.name, style: TextStyle(
                  fontSize: ScreenUtil().setSp(14),
                  color: Colors.black45,
                ),)
              ],
            ),
          )
        ],
      ),
    );
  }

}
