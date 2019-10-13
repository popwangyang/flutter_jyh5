import 'package:flutter/material.dart';
import 'loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FutureBuilderWidget extends StatefulWidget {
  final Function future;
  final Function body;
  final Widget loading;
  final Widget error;

  FutureBuilderWidget({
    Key key,
    @required this.future,
    @required this.body,
    this.loading,
    this.error
  }):super(key: key);

  @override
  _FutureBuilderWidgetState createState() => _FutureBuilderWidgetState();
}

class _FutureBuilderWidgetState extends State<FutureBuilderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: widget.future(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          // 请求已结束
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // 请求失败，显示错误
              return (){
                if(widget.error == null){
                  return _futureError();
                }else{
                  return widget.error;
                }
              }();
            } else {
              // 请求成功，显示数据
              return widget.body(snapshot);
            }
          } else {
            // 请求未结束，显示loading
            return (){
              if(widget.loading == null){
                return _futureLoading();
              }else{
                return widget.loading;
              }
            }();
          }
        },
      ),
    );
  }

  Widget _futureLoading(){
    return Center(
      child: Loading(
        size: 30,
      ),
    );
  }

  Widget _futureError(){

    ThemeData themeData = Theme.of(context);

    return Center(
      child: Container(
        width: ScreenUtil.getInstance().setWidth(135),
        height: ScreenUtil.getInstance().setHeight(208),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset('lib/assets/image/error.png',
              width: ScreenUtil.getInstance().setWidth(135),
              fit: BoxFit.fitWidth,
            ),
            Positioned(
              top: ScreenUtil.getInstance().setHeight(120),
              child: Text("加载失败", style: themeData.textTheme.display4,),
            )
          ],
        ),
      ),
    );
  }

}




