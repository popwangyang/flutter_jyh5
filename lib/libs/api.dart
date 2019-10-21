
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:jy_h5/libs/utils.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class HttpRequest {

  HttpRequest({this.baseUrl});

  final String baseUrl;

  BaseOptions getInsideConfig () {

    BaseOptions config = new BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: 10000,
      connectTimeout: 10000,
      headers: {
        'Content-Type': 'application/json;'
      }
    );

    return config;
  }

  InterceptorsWrapper _wrapper(BuildContext context){
    return InterceptorsWrapper(onRequest: (RequestOptions options) async{
      var token = await Utils.getToken();
      if(token != null){
        options.headers['Authorization'] = 'Bearer ' + token;
      }
      return options; //continue
    }, onResponse: (Response response) {
      print("响应之前");
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) {
      print("错误之前");
      // Do something with response error
      int stateCode = e.response.statusCode;
      print(e.response.data['message']);
      if(stateCode == 401){
        Navigator.pushNamed(context, 'error_404');
      }else if(stateCode == 400){
        Toast.show(e.response.data['message'], context, duration: 2, gravity: 1);
      }
      return e; //continue
    });
  }

  Future<Response> request (
    BuildContext context,
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
      }) {
    Dio instance = new Dio(getInsideConfig());
    instance.interceptors.add(_wrapper(context));
    return instance.request(
        path,
        options: options,
        queryParameters: queryParameters,
        data: data,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress
    );
  }

}

