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
      '/copyright/ktv/merchant/${id}',
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