import 'package:flutter/material.dart';
import 'package:jy_h5/router/router.dart';
import 'package:provider/provider.dart';
import 'store/provider.dart';
import 'router/router.dart';
import 'view/login.dart';
import 'common/theme.dart';

// 网络请求在浏览器中查看，需要翻墙
//import 'package:flutter_stetho/flutter_stetho.dart';

import 'view/initPage.dart';
void main() {
//  Stetho.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: providers,  // 状态管理模块；
      child: new MaterialApp(
          title: 'Flutter Demo',
          initialRoute:"/", //名为"/"的路由作为应用的home(首页)
          theme: appTheme,  // app主题
          //注册路由表
          routes: routes,
          home: new InitPage(),
      ),
    );
  }
}


