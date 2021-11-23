// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_delete_model_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreDeleteReq _$StoreDeleteReqFromJson(Map<String, dynamic> json) =>
    StoreDeleteReq(
      storeId: json['storeId'] as String,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$StoreDeleteReqToJson(StoreDeleteReq instance) =>
    <String, dynamic>{
      'storeId': instance.storeId,
      'password': instance.password,
    };
