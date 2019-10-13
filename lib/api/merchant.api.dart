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