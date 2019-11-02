import 'package:flutter/material.dart';

class ToastWidget{

  ToastWidget(BuildContext context, String text){
    ToastWidgetView.dismiss();
    ToastWidgetView.createView(context, Container(
      child: Text(text, style: TextStyle(
        color: Colors.white
      ),),
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 6.0
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(4.0)
      ),
    ));
  }

  static void loading(BuildContext context, { String message, int duration }){
    ToastWidgetView.dismiss();
    ToastWidgetView.createView(context, Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(4.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              bottom: 10
            ),
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                strokeWidth:2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
          Text(message, style: TextStyle(
            color: Colors.white
          ),)
        ],
      ),
    ), duration: duration);
  }

  static void success(BuildContext context, { String message }){
    ToastWidgetView.dismiss();
    ToastWidgetView.createView(context, BoxWidget(icon:Icons.check, message: message,));
  }

  static void fail(BuildContext context, { String message}){
    ToastWidgetView.dismiss();
    ToastWidgetView.createView(context, BoxWidget(icon:Icons.error_outline, message: message,));
  }

  static void clear(){
    ToastWidgetView.dismiss();
  }

}

class BoxWidget extends StatelessWidget {

  BoxWidget({
    Key key,
    this.message,
    this.icon
  }):super(key: key);

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(4.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                bottom: 0
            ),
            child: Icon(icon, size: 50, color: Colors.white,),
          ),
          Text(message, style: TextStyle(
              color: Colors.white
          ),)
        ],
      ),
    );
  }
}

class ToastWidgetView {

  static OverlayState overlayState;
  static OverlayEntry _overlayEntry;
  static bool _isVisible = false;

  static void createView(BuildContext context, Widget widget, {
    int duration = 2
  }) async{

    overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
        builder:  (BuildContext context){
        return ToastWidgetBox(
          widget: widget,
        );
    });
    _isVisible = true;
    overlayState.insert(_overlayEntry);
    if(duration != 0){
      await new Future.delayed(Duration(seconds: duration));
      dismiss();
    }
  }

  static dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }
}

class ToastWidgetBox extends StatelessWidget {

  ToastWidgetBox({
    Key key,
    this.widget
  }):super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: widget,
    ),
    );
  }
}
