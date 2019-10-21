import 'package:flutter/material.dart';
import 'package:jy_h5/store/model/loginModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login.dart';
import 'indexpage/IndexPage.dart';
import '../libs/utils.dart';


class InitPage extends StatefulWidget {
  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> with TickerProviderStateMixin{

  AnimationController _logoController;
  Tween _scaleTween;
  CurvedAnimation _logoAnimation;



  @override
  void initState() {
    _scaleTween = Tween(begin: 0, end: 1);
    _logoController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )
      ..drive(_scaleTween);
    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOutQuart
    );
    _logoController.addStatusListener((status){
      if(status == AnimationStatus.completed){
        goPage();
      }
    });
    Future.delayed(Duration(milliseconds: 500), () {
      _logoController.forward();
    });
    super.initState();
  }

  void goPage() async{
    Login _login = Provider.of<Login>(context);
    await _login.initUser();

    if(_login.user == null){
      Navigator.of(context).push(
          MaterialPageRoute(builder: (_) {
            return LoginPage();
          })
      );
    }else{
      Navigator.of(context).push(
          MaterialPageRoute(builder: (_) {
            return IndexPage();
          })
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375, height: 667)..init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ScaleTransition(
          scale: _logoAnimation,
          child: Container(
            width: ScreenUtil().setWidth(60),
            height: ScreenUtil().setHeight(60),
            child: Hero(
              tag: "logo",
              child: Image.asset(
                  "lib/assets/image/logo.png"
              ),
            ),
          ),
        ),
      ),
    );
  }
}
