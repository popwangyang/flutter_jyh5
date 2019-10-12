import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class BottomBar extends StatefulWidget {

  List<ItemIcon> bottomBars = [
    ItemIcon(
      selectedUrl: 'lib/assets/image/bottomBarIconA1.png',
      lostUrl: 'lib/assets/image/bottomBarIconA2.png',
      text: '商户管理'
    ),
    ItemIcon(
      selectedUrl: 'lib/assets/image/bottomBarIconB1.png',
      lostUrl: 'lib/assets/image/bottomBarIconB2.png',
      text: 'KTV管理',
    ),
  ];
  final ValueChanged onChange;
  final int index;
  Widget page;

  BottomBar({Key key, this.onChange, this.index = 0, this.page});


  @override
  _BottomBarState createState() => _BottomBarState();
}


class _BottomBarState extends State<BottomBar> {



  @override
  Widget build(BuildContext context) {
    widget.bottomBars[widget.index].isSelected = true;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 59,
            color: Colors.white,
            child: widget.page,
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: ScreenUtil.getInstance().setHeight(75),
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255,255,255,1),
//                 color: Colors.yellow,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, -1),
                            blurRadius: 5,
                            spreadRadius: -1,
                            color: Color.fromRGBO(0,0,0,0.16),
                          )
                        ]
                    ),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            child: widget.bottomBars[0],
                            onTap: (){
                              _btn(0);
                            },
                          )
                          ,
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            child: widget.bottomBars[1],
                            onTap: (){
                              _btn(1);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width/2 - 20,
                    top: 0,
                    child: Container(
                      child: AddIcon(),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

   _btn(index){
    widget.onChange(index);
  }
}



class ItemIcon extends StatelessWidget {

  bool isSelected;
  final String selectedUrl;
  final String lostUrl;
  final String text;
  ItemIcon({
    Key key,
    this.isSelected = false,
    this.lostUrl,
    this.selectedUrl,
    this.text
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = isSelected ? Color.fromRGBO(25, 84, 243, 1):Color.fromRGBO(216, 216, 216, 1);
    String imgSrc = isSelected ? selectedUrl:lostUrl;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            imgSrc,
            width: ScreenUtil.getInstance().setWidth(20),
            height: ScreenUtil.getInstance().setHeight(20),
            fit: BoxFit.contain,
          ),
          Text(text, style: TextStyle(
              fontSize: ScreenUtil.getInstance().setSp(10),
              color: color
          ),)
        ],
      ),
    );
  }
}

class AddIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(50),
      height: ScreenUtil.getInstance().setHeight(40),
      child: Stack(
        children: <Widget>[
          Container(
            width: ScreenUtil.getInstance().setWidth(40),
            height: ScreenUtil.getInstance().setHeight(40),
            margin: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(5)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(250),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0,0,0,0.16),
                    offset: Offset(0, -1),
                    blurRadius: 5,
                    spreadRadius: -1,
                  )
                ]
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: ScreenUtil.getInstance().setWidth(50),
              height: ScreenUtil.getInstance().setHeight(24),
              color: Colors.white,
            ),
          ),
          Positioned(
            left: ScreenUtil.getInstance().setWidth(9),
            top: 4,
            child: Image.asset('lib/assets/image/bottomBarAdd.png',
              width: ScreenUtil.getInstance().setWidth(32),
              height: ScreenUtil.getInstance().setHeight(32),
            ),
          ),
        ],
      ),
    );
  }
}
