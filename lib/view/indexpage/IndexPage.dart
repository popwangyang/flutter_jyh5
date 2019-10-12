import 'package:flutter/material.dart';
import '../../common/components/BottomBar.dart';
import '../shanghu/index.dart';
import '../KTVPage/ktvPage.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  List<Widget> pages = [
    ShanghuPage(),
    KtvPage(),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: BottomBar(
       page: pages[_index],
       index: _index,
       onChange: (index){
         print(index);
         _index = index;
         setState(() {});
       },
     )
    );
  }
  
}


