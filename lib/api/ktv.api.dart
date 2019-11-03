

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

// 实施信息记录
Future<Response> getImplementList(params, context){
  return ajax.request(
      context,
      '/copyright/ktv/implement',
      queryParameters: params,
      options: Options(method: 'get')
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

// 【KTV】vod升级
Future<Response> upgradeVod(data, context){
  return ajax.request(
      context,
      '/copyright/ktv/vod-upgrade',
      data: data,
      options: Options(method: 'post')
  );
}

//【KTV】vod升级记录
Future<Response> upgradeRecord(params, context){
  return  ajax.request(
      context,
      '/copyright/ktv/vod-upgrade',
      queryParameters: params,
      options: Options(method: 'get')
  );
}

// 【KTV】签约信息列表
Future<Response> getContract(params, context){
  return ajax.request(
      context,
      '/copyright/ktv/contract',
      queryParameters: params,
      options: Options(method: 'get')
  );
}

// 【KTV】新增签约信息
Future<Response> addContract(data, context){
  return ajax.request(
      context,
      '/copyright/ktv/contract',
      data: data,
      options: Options(method: 'post')
  );
}

// 【KTV】签约信息修改
Future<Response> putContract(id, data, context){
  return ajax.request(
      context,
      '/copyright/ktv/contract/$id',
      data: data,
      options: Options(method: 'put')
  );
}

// 【KTV】终止合同
Future<Response> stopContract(id,data, context){
  return ajax.request(
      context,
      '/copyright/ktv/contract/$id',
      data: data,
      options: Options(method: 'patch')
  );
}

// 【KTV】充值套餐列表
Future<Response> getRechargeList(params, context){
  return ajax.request(
      context,
      '/copyright/ktv/recharge-package',
      queryParameters: params,
      options: Options(method: 'get')
  );
}

// 【KTV】补充合同
Future<Response> addSupplementContract(data, context){
  return ajax.request(
      context,
      '/copyright/ktv/accessory',
      queryParameters: data,
      options: Options(method: 'post')
  );
}

// 【ktv】账户信息
Future<Response> getAccountInfo(params, context){
  return ajax.request(
      context,
      '/copyright/rbac/user',
      queryParameters: params,
      options: Options(method: 'get')
  );
}

// 【ktv】修改账户状态
Future<Response> changAccountStatues(id, data, context){
  return ajax.request(
      context,
      '/copyright/rbac/user/$id',
      data: data,
      options: Options(method: 'patch')
  );
}

// 【ktv】启用账号
Future<Response> enableAccount(id, data, context){
  return ajax.request(
      context,
      '/copyright/ktv/ktv-place/$id',
      data: data,
      options: Options(method: 'put')
  );
}

// 【ktv】创建账号
Future<Response> createAccountKTV(data, context){
  return ajax.request(
      context,
      '/copyright/rbac/user',
      data: data,
      options: Options(method: 'post')
  );
}

// 【ktv】修改账号
Future<Response> putAccountKTV(id, data, context){
  return ajax.request(
      context,
      '/copyright/rbac/user/$id',
      data: data,
      options: Options(method: 'put')
  );
}




