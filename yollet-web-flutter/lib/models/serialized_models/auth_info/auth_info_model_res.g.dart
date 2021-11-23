// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_info_model_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthInfoRes _$AuthInfoResFromJson(Map<String, dynamic> json) => AuthInfoRes(
      id: json['id'] as String?,
      role: json['role'] as String?,
      domain: json['domain'] as String?,
      agencyId: json['agencyId'] as String?,
      distributorId: json['distributorId'] as String?,
      storeId: json['storeId'] as String?,
    );

Map<String, dynamic> _$AuthInfoResToJson(AuthInfoRes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'domain': instance.domain,
      'distributorId': instance.distributorId,
      'agencyId': instance.agencyId,
      'storeId': instance.storeId,
    };
