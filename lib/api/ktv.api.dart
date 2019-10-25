

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