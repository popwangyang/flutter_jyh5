import 'package:dio/dio.dart';
import '../libs/api.request.dart';

Future<Response> login(data){

  return ajax.request(
    '/copyright/api-token-auth/',
    data: data,
    options: Options(method: 'post'),
  );
}