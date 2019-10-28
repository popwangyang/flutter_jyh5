import 'package:flutter/material.dart';
import '../../common/components/BottomBar.dart';
import '../shanghu/index.dart';
import '../KTVPage/ktvPage.dart';
import 'components/add.dart';
import 'package:provider/provider.dart';
import 'package:jy_h5/store/model/loginModel.dart';

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
//    Login login = Provider.of<Login>(context);
//    login.getLoginInfo(context);
    return Scaffold(
     body: BottomBar(
       page: IndexedStack(
         index: _index,
         children: pages,
       ),
       index: _index,
       onChange: (index){
         print(index);
         if(index != 2){
           _index = index;
           setState(() {});
         }else{
           Add.foo(context);
         }

       },
     )
    );
  }

  @override
  void initState() {
    super.initState();
  }
  
}


