import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../store/model/loginModel.dart';
import '../libs/utils.dart';
import '../common/components/Input.dart';
import 'package:toast/toast.dart';
import '../common/components/Button.dart';
import '../common/ValueNotifier.dart';
import '../model/validate/rule.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String userName;
  String passWorld;
  ValueNotifierData vn = ValueNotifierData('');
  bool loading = false;
  Login login;


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375, height: 667)..init(context);


    login = Provider.of<Login>(context);

    return Listener(
      child: Container(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child:  Stack(
                children: <Widget>[
                  _bgWidget(),
                  _inputWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
      onPointerDown: (onPointerDown){
        vn.value = Utils.getRandomNumber();
      },
      behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
    );
  }


  // 输入框小部件
  Widget _inputWidget(){
    return Positioned(
      left: ScreenUtil.getInstance().setWidth(26),
      top: ScreenUtil.getInstance().setHeight(160),
      child: Container(
        width: ScreenUtil.getInstance().setWidth(322),
        height: ScreenUtil.getInstance().setHeight(330),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  offset: Offset(2.0,2.0),
                  blurRadius: 20.0
              )
            ],
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                width: ScreenUtil.getInstance().setWidth(128),
                height: ScreenUtil.getInstance().setHeight(79),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/image/loginInputBGLeft.png'),
                    fit: BoxFit.cover
                  )
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: ScreenUtil.getInstance().setWidth(47),
                height: ScreenUtil.getInstance().setHeight(87),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/image/loginInputBGRight.png'),
                      fit: BoxFit.cover
                  )
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: ScreenUtil.getInstance().setWidth(322),
                height: ScreenUtil.getInstance().setHeight(330),
                child: _inputContentWidget(),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Input表单小部件
  Widget _inputContentWidget(){
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(21)),
        ),
        Text("账号登录", style: TextStyle(
          color: Colors.black,
          fontSize: ScreenUtil.getInstance().setSp(16),
          fontWeight: FontWeight.w500,
        ),),
        InputForm(onChange: inputUserChange, placeholder: '请输入邮箱', vn: vn,),
        InputForm(onChange: inputPassWordChange, placeholder: '请输入密码', inputType: 'password', vn: vn,),
        Container(
          margin: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(20)),
          child: _loginBtn(),
        ),
        Container(
          margin: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(10)),
          child: InkWell(
            child: Text("忘记密码", style: TextStyle(
              fontSize: ScreenUtil.getInstance().setSp(12),
              color: Colors.blue,
            ),),
            onTap: _goforgetPasswordPage,
          ),
        )
      ],
    );
  }

  // 背景图片小部件
  Widget _bgWidget(){
    return Container(
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: ScreenUtil.getInstance().setHeight(408),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/assets/image/loginBGup.png'),
                    fit: BoxFit.fill
                )
            ),
            child: Container(
              child: _logoWidget(),
              padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(80.0)),
            ),

          ),
          Container(
            width: double.infinity,
            height: ScreenUtil.getInstance().setHeight(57),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/assets/image/loginBGdown.png'),
                    fit: BoxFit.fill
                )
            ),
          )
        ],
      ),
    );
  }

  // logo小部件
  Widget _logoWidget(){
    return SizedBox(
      width: ScreenUtil.getInstance().setWidth(96),
      height: ScreenUtil.getInstance().setHeight(56),
      child: Column(
        children: <Widget>[
          Container(
            width: ScreenUtil.getInstance().setWidth(96),
            height: ScreenUtil.getInstance().setHeight(28),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/assets/image/loginLogo.png'),
                    fit: BoxFit.fitWidth
                )
            ),
          ),
          Container(
            height: ScreenUtil.getInstance().setHeight(28),
            child: Center(
              child: Text('管理端', style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil.getInstance().setSp(12),
                fontWeight: FontWeight.w500,
              ),),
            ),
          )
        ],
      ),
    );
  }

  // 确定按钮
  Widget _loginBtn(){
    return Button(text: '登录',isLoading: loading, onChange: _login,);
  }


  Map fromData = {
    'username': 'admin@hlchang.cn',
    'password': 'abc12345'
  };

  Map rule = {
    'username': Rule(require: true, message: '用户名不能为空', type: ruleType.Email),
    'password': Rule(require: true, message: '请输入密码', type: ruleType.Password),
  };


  void inputUserChange(val){
    fromData['username'] = val;
  }

  void inputPassWordChange(val){
    fromData['password'] = val;
  }

  void _goforgetPasswordPage(){
    Navigator.of(context).pushNamed('forgetPasswordPage');
  }
  void _login(val){
    bool validateState = Utils.validate(fromData, rule, context);
    if(validateState){
      setState(() {
        loading = val;
      });
    login.getLogin(fromData, context).then((val) {
      setState(() {
        loading = false;
        Navigator.of(context).pushNamed('indexPage');
      });
    }).catchError((err){
      setState(() {
        loading = false;
      });
      print(err);
    });
    }
  }
}


