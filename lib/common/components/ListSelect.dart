import 'package:flutter/material.dart';

class WangOverlay {

  static show(BuildContext context){
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context){
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color.fromRGBO(0, 0, 0, 0.7),
          child: RaisedButton(
            child: Text("点击"),
            onPressed: (){
              print("点击");
            },
          ),
        );
      }
    );
    Overlay.of(context).insert(overlayEntry);
  }


}

