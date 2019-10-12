import 'package:flutter/material.dart';

class ForgetPassWord extends StatefulWidget {
  @override
  _ForgetPassWordState createState() => _ForgetPassWordState();
}

class _ForgetPassWordState extends State<ForgetPassWord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("忘记密码"),
      ),
      body: Text("忘记密码"),
    );
  }
}
