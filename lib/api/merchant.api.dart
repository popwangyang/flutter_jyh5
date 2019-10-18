

import 'package:dio/dio.dart';
import '../libs/api.request.dart';

Future<Response> getMerchantList(data, context){

  return ajax.request(
    context,
    '/copyright/ktv/merchant',
    queryParameters: data,
    options: Options(method: 'get'),
  );
}

Future<Response> getMerchantDetail(id, context){
  return ajax.request(
      context,
      '/copyright/ktv/merchant/$id',
      options: Options(method: 'get'),
     );
}

Future<Response> getCompanyBrandList(data, context){
  return ajax.request(
    context,
    '/copyright/rbac/company-brands',
    options: Options(method: 'get'),
  );
}

// 创建商户
Future<Response> createMerchantDetail(data, context){
  return ajax.request(
    context,
    '/copyright/ktv/merchant',
    data: data,
    options: Options(method: 'post'),
  );
}

// 商户信息修改

Future<Response> putMerchantDetail(id, data, context){
  return ajax.request(
    context,
    '/copyright/ktv/merchant/$id',
    data: data,
    options: Options(method: 'PUT'),
  );
}