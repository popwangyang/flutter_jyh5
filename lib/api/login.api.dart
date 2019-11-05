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

// 获取邮箱验证码
Future<Response> getVerificationCode(params, context){
  return ajax.request(
    context,
    '/copyright/rbac/verification-code',
    queryParameters: params,
    options: Options(method: 'get'),
  );
}

// 验证邮箱验证码
Future<Response> verificationCode(data, context){
  return ajax.request(
    context,
    '/copyright/rbac/verification-code',
    data: data,
    options: Options(method: 'post'),
  );
}

// 重置密码
Future<Response> resetPassword(data, context){
  return ajax.request(
    context,
    '/copyright/rbac/password-reset-self',
    data: data,
    options: Options(method: 'put'),
  );
}