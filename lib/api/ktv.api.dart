

import 'package:dio/dio.dart';
import '../libs/api.request.dart';

Future<Response> getKTVList(data, context){

  return ajax.request(
    context,
    '/copyright/ktv/ktv',
    queryParameters: data,
    options: Options(method: 'get'),
  );
}

Future<Response> getKTVDetail(id, context){
  return ajax.request(
      context,
      '/copyright/ktv/ktv/$id',
      options: Options(method: 'get')
  );
}

Future<Response> createKTVDetail(data, context){
  return ajax.request(
      context,
      '/copyright/ktv/ktv',
      data: data,
      options: Options(method: 'post')
  );
}

Future<Response> putKTVDetail(id, data, context){
  return ajax.request(
      context,
      '/copyright/ktv/ktv/$id',
      data: data,
      options: Options(method: 'put')
  );
}

Future<Response> getUploadToken(data, context){
  return ajax.request(
      context,
      '/copyright/upload/upload',
      queryParameters: data,
      options: Options(method: 'get')
  );
}

//企业信息新增

Future<Response> addEnterprise(data, context){
  return ajax.request(
      context,
      '/copyright/ktv/enterprise',
      data: data,
      options: Options(method: 'post')
  );
}

//企业信息获取
Future<Response> getEnterprise(id, context){
  return ajax.request(
      context,
      '/copyright/ktv/enterprise?ktv=$id',
      options: Options(method: 'get')
  );
}

//企业信息修改
Future<Response> putEnterprise(id, data, context){
  return ajax.request(
      context,
      '/copyright/ktv/enterprise/$id',
      data: data,
      options: Options(method: 'put')
  );
}

// 实施信息获取
Future<Response> getImplement(id, context){
  return ajax.request(
      context,
      '/copyright/ktv/implement?ktv=$id',
      options: Options(method: 'get')
  );
}

// 实施信息新增
Future<Response> addImplement(data, context){
  return ajax.request(
      context,
      '/copyright/ktv/implement',
      data: data,
      options: Options(method: 'post')
  );
}

// 【VOD】品牌列表
Future<Response> getVodList(data, context){
  return ajax.request(
      context,
      '/copyright/ktv/vod-brand',
      queryParameters: data,
      options: Options(method: 'get')
  );
}
