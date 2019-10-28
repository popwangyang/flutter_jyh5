import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jy_h5/common/style.dart';
import 'package:jy_h5/common/components/ListPicker.dart';
import 'dart:io';
import 'package:jy_h5/api/ktv.api.dart';
import 'package:jy_h5/model/ktv.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:math' as math;

class UploadFile extends StatefulWidget {


  UploadFile({
    Key key,
    this.title,
    this.isRequired = true,
  }):super(key: key);
  final String title;
  final bool isRequired;

  @override
  _UploadFileState createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: ScreenUtil().width,
          padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
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
              Container(
                color: Color(0xfff6f6f6),
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(10)
                ),
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(20),
                    top: ScreenUtil().setHeight(20),
                    bottom: ScreenUtil().setHeight(20)
                ),
                width: ScreenUtil().width,
                alignment: Alignment.centerLeft,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: files.map((item){
                          return ImageUpload(
                            file: item,
                          );
                        }).toList(),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        width: ScreenUtil().setWidth(78),
                        height: ScreenUtil().setHeight(78),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.black45,
                                width: 0.2,
                                style: BorderStyle.solid
                            )
                        ),
                        child: Icon(
                          Icons.add,
                          size: ScreenUtil().setSp(30),
                          color: Colors.grey,
                        ),
                      ),
                      onTap: _showPicker,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Opacity(
          opacity: 1,
          child: Divider(
            height: 2,
            color: Color.fromRGBO(235, 237, 240, 1),
          ),
        )
      ],
    );
  }

  Widget _picker(){
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20)
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.album,
                        size: ScreenUtil().setSp(16),
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("相册")
                    ],
                  ),
                ),
                onTap: (){
                  getImage(1);
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20)
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.camera_alt,
                        size: ScreenUtil().setSp(16),
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("拍照")
                    ],
                  ),
                ),
                onTap: (){
                  getImage(2);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showPicker(){
    ListPicker.pickerList(
        context,
        child: _picker(),
        height: 100,
        isShowTitle: false
    );
  }

  List<File> files = [];

  Future getImage(int index) async {
    File image;
    Navigator.of(context).pop();
    if(index == 1){
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }else{
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    }
    int length = await image.length();

    String type = image.path.split('.').last;


    FileStat fileStat = await image.stat();

    setState(() {
      files.add(image);
    });

    print(type);
  }
}

class ImageUpload extends StatefulWidget {

  ImageUpload({
    Key key,
    this.file,
    this.filePath,
    this.fileType,
  }):super(key: key);

  final File file;
  final String filePath;
  final String fileType;

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(78),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: .5,
        )
      ),
      margin: EdgeInsets.only(
          bottom: ScreenUtil().setHeight(20)
      ),
      child: Transform.rotate(
        alignment: Alignment.center,
        angle: 0,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
             (){
              if(widget.file != null){
                return Image.file(
                  widget.file,
                  width: ScreenUtil().setWidth(78),
                  fit: BoxFit.fitWidth,
                );
              }else{
                return Image.network(
                  widget.filePath,
                  width: ScreenUtil().setWidth(78),
                  fit: BoxFit.fitWidth,
                );
              }
            }(),
            (){
              if(uploadStatues != 1){
                return Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: ScreenUtil().setHeight(78),
                    height: ScreenUtil().height,
                    color: Colors.black.withOpacity(0.7),
                  ),
                );
              }else{
                return Container();
              }
            }(),
            (){
              if(uploadStatues == 0){
                return Container(
                  width: ScreenUtil().setWidth(30),
                  height: ScreenUtil().setHeight(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Center(
                    child: Text('${(percentage * 100).toStringAsFixed(0)}%',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(10),
                          color: Colors.grey
                      ),
                    ),
                  ),
                );
              }else{
                return Container();
              }
            }(),
            (){
              if(uploadStatues == 0){
                return SizedBox(
                  width: ScreenUtil().setWidth(30),
                  height: ScreenUtil().setHeight(30),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                    value: percentage,
                  ),
                );
              }else{
                return Container();
              }
            }(),
            (){
              if(uploadStatues == 1){
                return Positioned(
                  right: ScreenUtil().setWidth(4),
                  bottom: ScreenUtil().setHeight(4),
                  child: Icon(
                    Icons.delete,
                    size: ScreenUtil().setSp(16),
                    color: Colors.grey,
                  ),
                );
              }else{
                return Container();
              }
            }()
          ],
        ),
      ),
    );
  }

  UploadToken _uploadToken;
  double percentage = 0;
  int uploadStatues = 0;  // 0为正在上传，1为上传完成，2上传失败。

  @override
  void initState() {
    // TODO: implement initState
    upload();
    super.initState();
  }

  upload() async{

    _uploadToken = await getToken();
    Response response;
    FormData formData = new FormData.from({
      "x:id": "",
      "key": _uploadToken.key,
      "file": new UploadFileInfo(new File(widget.file.path), widget.file.path.split('/').last),
      "token": _uploadToken.credential
    });
    response = await new Dio().post(
        "https://up-z1.qiniup.com/",
        data: formData,
        onSendProgress: progress,
    );
    print(response);
  }

  progress(int count, int total){
    setState(() {
      percentage = count / total;
      if(percentage == 1.0){
        uploadStatues = 1;
      }
    });

  }

  Future<UploadToken> getToken() async{  // 获取七牛云的上传凭证
    String path = widget.file.path;
    var sendData = {
      'name': path.split('/').last,
      'mimie': 'image/${path.split('.').last}',
      'size': widget.file.lengthSync()
    };
    var res = await getUploadToken(sendData, context);
    UploadToken uploadToken = UploadToken.fromJson(json.decode(res.toString()));
    return uploadToken;
  }


}


