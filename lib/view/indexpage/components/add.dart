import 'package:flutter/material.dart';
import 'package:jy_h5/common/components/ListPicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/view/shanghu/components/detail/edited.dart';
import 'package:jy_h5/view/KTVPage/components/ktvEdite/ktvEdite.dart';

class Add {

  static foo(BuildContext context){
    Widget box(String url, String title, Function foo){
      return InkWell(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                url,
                width: ScreenUtil().setWidth(60),
                height: ScreenUtil().setHeight(60),
                fit: BoxFit.contain,
              ),
              Text(title,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  decoration:TextDecoration.none,
                ),
              )
            ],
          ),
        ),
        onTap: foo,
      );
    }

    ListPicker.pickerList(
      context,
      height: ScreenUtil().setHeight(190),
      child: Material(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(120),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    box(
                        'lib/assets/image/addmerchant.png',
                        "新建商户",
                        (){
                          Navigator.pop(context);
                          Future.delayed(Duration(milliseconds: 200), (){
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) {
                                  return MerchantEdited(
                                    isEdited: false,
                                  );
                                })
                            );
                          });
                        }
                    ),
                    box(
                        'lib/assets/image/addktv.png',
                        "新建KTV",
                         (){
                           Navigator.pop(context);
                           Future.delayed(Duration(milliseconds: 200), (){
                             Navigator.of(context).push(
                                 MaterialPageRoute(builder: (_) {
                                   return KtvEdited();
                                 })
                             );
                           });
                        }
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: InkWell(
                    child: Icon(
                      Icons.close,
                      color: Color.fromRGBO(0, 0, 0, 0.16),
                      size: ScreenUtil().setSp(32),
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      )
     );
    }

}