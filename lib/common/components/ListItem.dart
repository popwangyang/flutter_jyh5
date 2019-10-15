import 'package:flutter/material.dart';
import 'package:jy_h5/common/style.dart';

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
                  child: Text("$title", style: Style.listTitle(),),
                ),
                (){
                  if(label != null){
                    return Expanded(
                      flex: 1,
                      child: Text("$label",
                          textAlign: TextAlign.right,
                          style: Style.listLabel()
                      ),
                    );
                  }else{
                    return Container();
                  }
                }()

              ],
            ),
          ),
          Opacity(
            opacity: isLast ? 0:1,
            child: Divider(
              indent: 16,
              height: 2,
              color: Color.fromRGBO(235, 237, 240, 1),
            ),
          )

        ],
      ),
    );
  }
}