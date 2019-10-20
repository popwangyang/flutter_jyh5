import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../style.dart';

class ListPicker {

  static pickerList(
      BuildContext context,
      {
        List data,
        Function onSelected,
        String initValue,
        Widget child,
        double height
      }){

//    int index = 0;
//    FixedExtentScrollController scrollController = FixedExtentScrollController(
//        initialItem: data.indexOf(initValue) == -1 ? 0:data.indexOf(initValue)
//    );


//    final picker  = CupertinoPicker.builder(
//        itemExtent: 40,
//        scrollController: scrollController,
//        backgroundColor: Colors.transparent,
//        onSelectedItemChanged: (position){
//          index = position;
//        },
//        childCount: data.length,
//        itemBuilder: (context, val){
//          return Center(
//            child: Text(
//              data[val],
//              style: Style.pickListText(),
//            ),
//          );
//    });

    showCupertinoModalPopup(context: context, builder: (context){
      return Container(
        color: Colors.white,
        height: height,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromRGBO(235, 237, 240, 1),
                    width: 1,
                    style: BorderStyle.solid
                  )
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    child: Text("取消", style: Style.buttonText(),),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("确定", style: Style.buttonText(),),
                    onPressed: (){
                      Navigator.of(context).pop();
                      onSelected();
                    },
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: child,
            )
          ],
        ),
      );
    });
  }

}