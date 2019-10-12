import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTitle extends StatelessWidget {

  final bool hasBack;
  final String title;
  AppTitle({Key key, this.hasBack = false, this.title}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color.fromRGBO(246, 246, 246, 1), width: 1,))
      ),

      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: ScreenUtil.getInstance().setHeight(50),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(10)),
              child: (){
                if(hasBack){
                  return InkWell(
                    child: Icon(Icons.arrow_back_ios, color: Color.fromRGBO(2, 2, 2, 1), size: ScreenUtil.getInstance().setSp(18),),
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                  );
                }else{
                  return SizedBox(
                    width: ScreenUtil.getInstance().setWidth(18),
                  );
                }
              }()
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromRGBO(2, 2, 2, 1), fontSize: ScreenUtil.getInstance().setSp(16)),),
              ),
            ),
            SizedBox(
              width: ScreenUtil.getInstance().setWidth(18),
            )
          ],
        ),
      ),
    );
  }
}