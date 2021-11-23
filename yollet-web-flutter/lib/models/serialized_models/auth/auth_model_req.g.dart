// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthReq _$AuthReqFromJson(Map<String, dynamic> json) => AuthReq(
      id: json['id'] as String,
      password: json['password'] as String,
      domain: json['domain'] as String,
    );

Map<String, dynamic> _$AuthReqToJson(AuthReq instance) => <String, dynamic>{
      'id': instance.id,
      'password': instance.password,
      'domain': instance.domain,
    };
