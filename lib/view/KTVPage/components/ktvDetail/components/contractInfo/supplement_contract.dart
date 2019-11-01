import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/ListInput.dart';

class SupplementContract extends StatefulWidget {
  SupplementContract({
    Key key,
    this.ktvID,
  }):super(key: key);
  final int ktvID;
  @override
  _SupplementContractState createState() => _SupplementContractState();
}

class _SupplementContractState extends State<SupplementContract> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            AppTitle(
              hasBack: true,
              title: '新增补充合同',
            ),
            ListInput(
              title: '包厢数',
              value: null,
              onChange: (e){

              },
            ),

          ],
        ),
      ),
    );
  }

}
