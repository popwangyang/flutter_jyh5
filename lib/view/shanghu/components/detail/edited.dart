import 'package:flutter/material.dart';
import 'package:jy_h5/common/components/Appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/style.dart';
import 'package:jy_h5/common/components/ListSelect.dart';
import 'package:city_pickers/city_pickers.dart';


class MerchantEdited extends StatefulWidget {
  @override
  _MerchantEditedState createState() => _MerchantEditedState();
}

class _MerchantEditedState extends State<MerchantEdited> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            AppTitle(hasBack: true, title: '编辑商户',),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            ListInput(
              title: '商户名称',
              placeholder: '请输入商户名称',
            ),
            ListInput(
              title: '账号',
              placeholder: '请输入账号',
            ),
            ListInput(
              title: '邮箱号',
              placeholder: '请输入邮箱号',
              isRequired: false,
            ),
            ListSelected(),
          ],
        ),
      ),
    );
  }

}

class ListInput extends StatefulWidget {

  final bool isLast;
  final bool isRequired;
  final String placeholder;
  final String title;


  ListInput({
    Key key,
    this.isRequired = true,
    this.isLast = false,
    this.placeholder = '请输入',
    @required this.title,

  }):super(key: key);

  @override
  _ListInputState createState() => _ListInputState();
}

class _ListInputState extends State<ListInput> {

  FocusNode _focusNode = FocusNode();  // 输入框焦点句柄
  TextEditingController _textEditingController = TextEditingController(); // 输入框控制器
  bool _cancelDisplay = false;
  String inputValue = '';  // 输入框内容

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Text.rich(TextSpan(
                      children: [
                        TextSpan(
                          text: widget.title,
                          style: Style.listTitle()
                        ),
                        (){
                          if(!widget.isRequired){
                            return TextSpan(
                                text: '(选填)',
                                style: Style.placeHolder()
                            );
                          }else{
                            return TextSpan();
                          }
                        }()
                      ]
                  )),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.white30,
                  child: TextField(
                    controller: _textEditingController,
                    onChanged: _onChanged,
                    focusNode: _focusNode,
                    style: TextStyle(
                        color: Color.fromRGBO(102, 102, 102, 1)
                    ),
                    cursorWidth: 1,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: widget.placeholder,
                        hintStyle: Style.placeHolder()
                    ),
                  ),
                ),
              ),
              Opacity(
                opacity: _cancelDisplay ? 1:0,
                child: InkWell(
                  child: Icon(
                    Icons.cancel,
                    size: ScreenUtil().setSp(20),
                    color: Color.fromRGBO(150, 151, 153, 1),
                  ),
                  onTap: (){
                    if(_cancelDisplay){
                      _cancelBtn();
                    }
                  },
                ),
              )
            ],
          ),
        ),
        Opacity(
          opacity: widget.isLast ? 0:1,
          child: Divider(
            height: 2,
            color: Colors.grey,
            indent: 20,
          ),
        )

      ],
    );
  }

  _onChanged(e){
    inputValue = e;
    _showCancel();
  }

  _showCancel(){
    if(inputValue != '' && _focusNode.hasFocus){
      _cancelDisplay = true;
    }else{
      _cancelDisplay = false;
    }
    setState(() {});
  }

  _cancelBtn(){
    _textEditingController.text = '';
    _cancelDisplay = false;
    setState(() {});
  }

  @override
  void initState() {
    _focusNode.addListener((){
      _showCancel();
    });
    super.initState();
  }
}

class ListSelected extends StatefulWidget {
  final bool isRequired;

  ListSelected({
    Key key,
    this.isRequired = true
  }):super(key: key);

  @override
  _ListSelectedState createState() => _ListSelectedState();
}

class _ListSelectedState extends State<ListSelected>{

  OverlayEntry _overlayEntry;
  Result result = new Result();
  double customerItemExtent = 40;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text.rich(TextSpan(
                    children: [
                      TextSpan(
                          text: 'vod品牌',
                          style: Style.listTitle()
                      ),
                          (){
                        if(!widget.isRequired){
                          return TextSpan(
                              text: '(选填)',
                              style: Style.placeHolder()
                          );
                        }else{
                          return TextSpan();
                        }
                      }()
                    ]
                )),

              ),
              Expanded(
                flex: 4,
                child: InkWell(
                  child: Text(
                    "请选择",
                    style: Style.placeHolder(),
                  ),
                  onTap: overlyBtn,
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(20),
                height: ScreenUtil().setHeight(20),
              )
            ],
          ),
        )
      ],
    );
  }

  overlyBtn() async{
//    _overlayEntry = OverlayEntry(
//      builder: (context){
//        return Popup(
//          remove: _remove,
//        );
//      }
//    );
//
//    Overlay.of(context).insert(_overlayEntry);
    Result tempResult = await CityPickers.showCityPicker(
      context: context,
//      itemExtent: customerItemExtent,
//      itemBuilder: this.getItemBuilder());

    );
    print(tempResult);
    if (tempResult == null) {
      return;
    }
    this.setState(() {
      result = tempResult;
    });
  }

//  getItemBuilder() {
//    if (customerItemBuilder) {
//      return (item, list, index) {
//        return Center(
//            child: Text(item, maxLines: 1, style: TextStyle(fontSize: 55)));
//      };
//    } else {
//      return null;
//    }
//  }

  _remove(){

    _overlayEntry.remove();
  }


  @override
  void initState() {
    super.initState();
  }
}

class Popup extends StatefulWidget {

  final Function remove;

  Popup({Key key, this.remove}):super(key: key);

  @override
  _PopupState createState() => _PopupState();
}

class _PopupState extends State<Popup> with SingleTickerProviderStateMixin{

  Animation<double> animation;
  AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
          children: <Widget>[
            Listener(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Color.fromRGBO(0, 0, 0, 0.6),
              ),
              onPointerDown: (PointerDownEvent event){
                controller.reverse();
                Future.delayed(Duration(milliseconds: 350),(){
                  widget.remove();
                });
//
              },
            ),
            Positioned(
              bottom: animation.value,
              left: 0,
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(
                    Size(MediaQuery.of(context).size.width, 300)
                ),
                child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.blue)
                ),
              ),
            ),
          ]
      ),
    );
  }

  @override
  void initState() {
    double start = -300;
    double end = 0;
    controller = new AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    //图片宽高从0变到300
    //使用弹性曲线
    animation=CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    animation = new Tween(begin: start, end: end).animate(animation)
      ..addListener(() {
        print(animation.value);
        setState(()=>{});
      });
    //启动动画(正向执行)
    controller.forward();
    super.initState();
  }
}





