

import 'package:flutter/material.dart';
import 'loading.dart';
import 'Error.dart';
import 'Empty.dart';

class PageContent extends StatelessWidget {

  PageContent({
    Key key,
    @required this.content,
    this.reload,
    this.pageStatues = 1,
    this.emptyWidget,

  }):super(key: key);

  final int pageStatues;
  final Function content;
  final Function reload;
  final Widget emptyWidget;

  @override
  Widget build(BuildContext context) {
    return (){
      if(pageStatues == 1){
        return Center(
          child: Loading(),
        );
      }else if(pageStatues == 2){
        return SingleChildScrollView(
//          physics: BouncingScrollPhysics(),
          child: content(),
        );
      }else if(pageStatues == 3){
        return Center(
          child: Error(
            reload: reload,
          ),
        );
      }else{
        return Center(
          child: (){
            if(emptyWidget != null){
              return emptyWidget;
            }else{
              return Empty();
            }
          }(),
        );
      }
    }();
  }
}