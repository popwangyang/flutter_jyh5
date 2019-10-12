import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Search extends StatelessWidget {

  final String plplaceholder;
  Search({
    Key key,
    this.plplaceholder = "请输入"
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: ScreenUtil.getInstance().setHeight(58),
      padding: EdgeInsets.only(left: 15, right: 15),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: ScreenUtil.getInstance().setWidth(295),
            height: ScreenUtil.getInstance().setHeight(35),
            decoration: BoxDecoration(
              color: Color.fromRGBO(239, 238, 243, 1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: _searchContent(),
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                      color:Color.fromRGBO(0, 0, 0, 0.05),
                      offset: Offset(0,0),
                      blurRadius: 4.0,
                      spreadRadius: 3.0
                  )
                ],
              ),
              child: Image.asset('lib/assets/image/indexUS.png', width: 16, height: 16,fit: BoxFit.contain,),
            ),
            onTap: (){
              print("ppppp");
            },
            highlightColor: Colors.blue
          )
        ],
      ),
    );
  }
  Widget _searchContent(){
    return Container(
      padding: EdgeInsets.only(left: 12),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 4),
            child:Icon(Icons.search, size: ScreenUtil.getInstance().setSp(16), color: Color.fromRGBO(204, 204, 204, 1),),
          ),
          Text(plplaceholder, style: TextStyle(
            fontSize: ScreenUtil.getInstance().setSp(12),
            color: Color.fromRGBO(204, 204, 204, 1),
            fontWeight: FontWeight.w400,
          ),)
        ],
      ),
    );
  }
  

}
