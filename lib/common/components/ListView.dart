import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum LoadStatus{
  // 正在加载
  STATUS_LOADING,
  // 数据加载完成
  STATUS_COMPLETED,
  // 空闲状态
  STATUS_IDEL
}

class ListWidget extends StatefulWidget {

  final int total;
  final List results;
  final Function refresh;
  final Function loadMore;
  final Function itemWidget;

  ListWidget({
    Key key,
    @required this.total,
    @required this.results,
    this.refresh,
    this.itemWidget,
    this.loadMore
  }):super(key: key);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {

  List _results;
  LoadStatus _loadStatus = LoadStatus.STATUS_IDEL;
  String _loadText = '空闲状态';
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child:RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.only(top: 0),
            itemCount: _results.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if(index < _results.length){
                return widget.itemWidget(index, _results);
              }else{
                return Container(
                  height: ScreenUtil().setHeight(50),
                  child: Center(
                    child: Text("$_loadText", style: Theme.of(context).textTheme.display4,),
                  ),
                );
              }
            }
        ),
      ),
    );
  }

  // 刷新函数
  Future _refresh(){

    return widget.refresh().then((val){
      print(val);
      setState(() {
        setState(() {
          _results = val;
        });

      });
    });
  }
  _getMoreDate() async{
    print("数组长${_results.length}总数有${widget.total}");
    if(_results.length < widget.total && _loadStatus != LoadStatus.STATUS_LOADING){
      print("加载中...");
      setState(() {
        _loadStatus = LoadStatus.STATUS_LOADING;
        _loadText = "加载中...";
      });
      var result = await widget.loadMore();

      setState(() {
        _results.addAll(result);
        _loadStatus = LoadStatus.STATUS_IDEL;
        _loadText = "空闲状态";
      });
    }else if(_results.length == widget.total && _loadStatus != LoadStatus.STATUS_LOADING){
      print("没有更多数据了");
      setState(() {
        _loadStatus = LoadStatus.STATUS_IDEL;
        _loadText = "没有更多数据了";
      });
    }
  }

  @override
  void initState() {
    setState(() {
      _results = widget.results;
    });
    _scrollController.addListener((){
      if(_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - ScreenUtil().setHeight(50)) {
        _getMoreDate();
      }
    });
    super.initState();
  }
}
