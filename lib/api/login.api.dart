import 'package:dio/dio.dart';
import '../libs/api.request.dart';

Future<Response> login(data, context){

  return ajax.request(
    context,
    '/copyright/api-token-auth/',
    data: data,
    options: Options(method: 'post'),
  );
}