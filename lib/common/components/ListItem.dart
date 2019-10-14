import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListItem extends StatelessWidget {

  final String title;
  final String label;
  final bool isLast;

  ListItem({Key key, this.title, this.label, this.isLast = false}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(10, 16, 10, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text("$title", style: TextStyle(
                      color: Color.fromRGBO(68, 68, 68, 1),
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil().setSp(14)
                  ),),
                ),
                Expanded(
                  flex: 1,
                  child: Text("$label", textAlign: TextAlign.right, style: TextStyle(
                      color: Color.fromRGBO(160, 160, 160, 1),
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.w400
                  ),),
                )
              ],
            ),
          ),
          Opacity(
            opacity: isLast ? 0:1,
            child: Divider(
              indent: 16,
              height: 1,
              color: Colors.grey,
            ),
          )

        ],
      ),
    );
  }
}