import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jy_h5/api/ktv.api.dart';
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:jy_h5/common/components/PageContent.dart';
import 'package:jy_h5/common/components/Empty.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/components/Button.dart';
import 'package:jy_h5/model/contract.dart';
import 'package:jy_h5/common/components/ListItem.dart';
import 'package:jy_h5/model/ktv.dart';
import 'package:jy_h5/common/style.dart';
import 'package:jy_h5/common/components/ListPicker.dart';
import 'package:toast/toast.dart';
import 'contract_edited.dart';
import 'supplement_contract.dart';
import 'contract._past.dart';


class ContractPage extends StatefulWidget {

  ContractPage({
    Key key,
    this.ktvID}):super(key: key);

  final int ktvID;
  @override
  _ContractPageState createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              AppTitle(
                hasBack: true,
                title: '合同信息',
              ),
              Expanded(
                flex: 1,
                child:PageContent(
                  pageStatues: pageStatues,
                  content: _content,
                  reload: getData,
                  emptyWidget: _emptyWidget(),
                ),
              ),
              (){
               if(pageStatues == 2){
                 return Container(
                   alignment: Alignment.centerRight,
                   padding: EdgeInsets.symmetric(
                     horizontal: ScreenUtil().setWidth(10)
                   ),
                   width: ScreenUtil().width,
                   height: ScreenUtil().setHeight(50),
                   decoration: BoxDecoration(
                     color: Colors.white,
                     border: Border(
                       top: BorderSide(
                         color: Color(0xffebedf0)
                       )
                     )
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: <Widget>[
                       _buttonWidget('更多', _moreBtn),
                       SizedBox(
                         width: 20,
                       ),
                       _buttonWidget('编辑', () async{
                         var result = await Navigator.of(context).push(
                           MaterialPageRoute(
                             builder: (_){
                               return ContractEdited(
                                 ktvID: widget.ktvID,
                                 contractDetail: contractDetail,
                               );
                             }
                           )
                         );
                         if(result != null){
                           getData();
                         }
                       }),
                     ],
                   ),
                 );
               }else{
                 return Container();
               }
              }()
            ],
          )
        ),
      ),
    );
  }

  Widget _content(){
    return  Container(
      child: Column(
        children: <Widget>[
          ListItem(
            title: '合同编号',
            label: contractDetail.number,
          ),
          ListItem(
            title: '套餐类型',
            label: contractDetail.packageType == '1' ? '包厢套餐':'一次性充值',
          ),
          ListItem(
            title: '套餐名称',
            label: contractDetail.packageName,
          ),
          ListItem(
            isLast: true,
            title: '包厢数量',
            label: contractDetail.boxCount,
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(10)
            ),
            child: ListItem(
              title: '合同起始日期',
              label: contractDetail.beginDate,
              isLast: true,
            ),
          ),
          ListItem(
            title: '合同状态',
            labelWidget: _stateWidget(contractDetail.chargeManage.state),
          ),
          ListItem(
            title: '到账状态',
            label: contractDetail.state == 1 ? '未到账':'已到账',
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(10)
            ),
            child: _box(
                '合同信息',
                contractDetail.annex
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyWidget(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Empty(
            text: '暂无签约信息',
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(10)
            ),
            child:  ButtonCircle(
              text: '新建签约信息',
              onClick: () async{
                var result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_){
                      return ContractEdited(
                        ktvID: widget.ktvID,
                      );
                    }
                  )
                );
                if(result != null){
                  getData();
                }
              },
            ),
          ),
          InkWell(
            child: Text('查看往期', style:  TextStyle(
                fontSize: ScreenUtil().setSp(12),
                color: Color(0xff4479ef)
            ),),
            onTap: (){
              print("ppppp");
            },
          )
        ],
      ),
    );
  }

  Widget _stateWidget(int state){
    Widget result;
    switch(state){
      case 1:
        result = Text("合同中", style: TextStyle(
          fontSize: ScreenUtil().setSp(14),
          color: Color(0xff01cca3)
        ),);
        break;
      case 2:
        result = Text("已过期", style: TextStyle(
            fontSize: ScreenUtil().setSp(14),
            color: Color.fromRGBO(160, 160, 160, 1)
        ),);
        break;
      case 3:
        result = Text("合同终止", style: TextStyle(
            fontSize: ScreenUtil().setSp(14),
            color: Colors.red
        ),);
        break;
    }

    return result;
  }

  Widget _box(String title, List<UploadResult> data){
    return Container(
      width: ScreenUtil().width,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setWidth(10),
          horizontal: ScreenUtil().setHeight(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Style.listTitle(),),
          Container(
            child: Column(
              children: (){
                return data.map((item){
                  return _boxItem(item);
                }).toList();
              }(),
            ),
          )
        ],
      ),
    );
  }

  Widget _boxItem(UploadResult data){
    return Container(
      color: Color(0xfff6f6f6),
      width: ScreenUtil().width,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(10)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            'lib/assets/image/imgBox.png',
            width: ScreenUtil().setWidth(22),
            height: ScreenUtil().setHeight(14),
            fit: BoxFit.contain,
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: ScreenUtil().setWidth(280),
            child: Text(
              data.name,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(14),
                color: Colors.black45,
              ),),
          )
        ],
      ),
    );
  }

  Widget _buttonWidget(String text, Function onBtn){
    return FlatButton(
      child: Text(text, style: TextStyle(
          fontSize: ScreenUtil().setSp(12)
      ),),
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 14,
      ),
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xffebedf0),
          ),
          borderRadius: BorderRadius.circular(20)
      ),
      onPressed: (){
        onBtn();
      },
    );
  }

  Widget _moreWidget(){
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            _moreItemWidget('新增合同', _addContract),
            _moreItemWidget('补充合同', _supplementContract),
            _moreItemWidget('查看往期', _lookPastContract),
            _moreItemWidget('终止合同', _stopContract, hasBorder: false),
            Container(
              height: ScreenUtil().setHeight(10),
              color: Color(0xffdcdcdc),
            ),
            _moreItemWidget('取消', (){
              Navigator.of(context).pop();
            }, hasBorder: false),
          ],
        ),
      ),
    );
  }

  Widget _moreItemWidget(String text, Function onBtn, {bool hasBorder = true}){
    return InkWell(
      child: Container(
        height: ScreenUtil().setHeight(45),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                  color: !hasBorder ? Colors.white : Color(0xffdcdcdc),
                )
            )
        ),
        child: Center(
          child: Text(text, style: TextStyle(
              fontSize: ScreenUtil().setSp(16),
              color: Colors.black
          ),),
        ),
      ),
      onTap: onBtn,
    );
  }


  ContractDetail contractDetail;

  int pageStatues = 1;

  getData() async{
    setState(() {
      pageStatues = 1;
    });
    var sendData = {
      'ktv': widget.ktvID,
      'state': 1
    };
    try{
      var res = await getContract(sendData, context);
      var data = json.decode(res.toString())['results'];
      print(data);
      if(data.length > 0){
        pageStatues = 2;
        contractDetail = ContractDetail.fromJson(data[0]);
        print(contractDetail);
      }else{
        pageStatues = 4;
      }
      setState(() {});
    }catch(err){
      print(err);
      setState(() {
        pageStatues = 3;
      });
    }
  }

  _moreBtn(){
    ListPicker.pickerList(
        context,
      child: _moreWidget(),
      height: ScreenUtil().setHeight(235)
    );
  }

  Future _pop(){
    Navigator.pop(context);
    return Future.delayed(Duration(milliseconds: 200));
  }

  _addContract() async{
    await _pop();
    if(contractDetail.state == 1){
      Toast.show(
          '请先终止当前合同',
          context,
          duration: 2,
          gravity: 1
      );
      return;
    }
   var result =  await Navigator.of(context).push(MaterialPageRoute(
        builder: (_){
          return ContractEdited(
            ktvID: widget.ktvID,
          );
        }
    ));
    if(result != null){
      getData();
    }
  }
  _supplementContract() async{
    await _pop();
    if(contractDetail.chargeManage.state == 2){
      Toast.show(
          '合同为未到账状态, 无法补充合同',
          context,
          duration: 2,
          gravity: 1
      );
      return;
    }
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_){
              return SupplementContract(
                contractID: contractDetail.id,
              );
            }
        )
    );
  }
  _lookPastContract() async{
    await _pop();
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_){
              return PastContract(
                ktvID: widget.ktvID,
              );
            }
        )
    );
  }

  _stopContract() async{
    await _pop();
    try{
      var sendData = {
        'state': '3'
      };
      DateTime dateTime = DateTime.now();
      if(dateTime.weekday != 1){
        Toast.show('请在周一进行该操作', context, duration: 1, gravity: 1);
        return;
      }
      await stopContract(contractDetail.id, sendData, context);
      setState(() {
        contractDetail.state = 3;
      });
      Toast.show('合同已终止', context, duration: 1, gravity: 1);
    }catch(err){
      print(err);
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }
}
