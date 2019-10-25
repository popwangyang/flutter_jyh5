import 'package:flutter/material.dart';

import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/Strip.dart';
import 'package:jy_h5/common/components/ListInput.dart';
import 'package:jy_h5/common/components/UploadFile.dart';


class EnterpriseEdited extends StatefulWidget {
  @override
  _EnterpriseEditedState createState() => _EnterpriseEditedState();
}

class _EnterpriseEditedState extends State<EnterpriseEdited> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AppTitle(
            hasBack: true,
            title: '新建企业信息',
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Strip(
                    title: '企业信息',
                  ),
                  ListInput(
                    title: '企业注册名称',
                    onChange: (e){
                      print(e);
                    },
                  ),
                  ListInput(
                    title: '营业执照编号',
                    onChange: (e){
                      print(e);
                    },
                  ),
                  UploadFile(
                    title: '营业执照照片',
                    isRequired: false,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
