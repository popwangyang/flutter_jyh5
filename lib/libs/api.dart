
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jy_h5/libs/utils.dart';
import 'package:flutter/material.dart';

class HttpRequest {

  HttpRequest({this.baseUrl});

  final String baseUrl;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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

  InterceptorsWrapper _wrapper(){
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
      return e; //continue
    });
  }

  Future<Response> request (
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
      }) {
    Dio instance = new Dio(getInsideConfig());
    instance.interceptors.add(_wrapper());
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

