// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_message_model_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonMessageReq _$CommonMessageReqFromJson(Map<String, dynamic> json) =>
    CommonMessageReq(
      targetSvc: json['targetSvc'] as String? ?? 'admin.yoshop.net',
      targetPackage: json['targetPackage'] as String? ?? 'admin.v1',
      targetApi: json['targetApi'] as String,
      sourceSvc: json['sourceSvc'] as String? ?? 'YolletAdmin',
      sourceVer: json['sourceVer'] as String? ?? '1.0.0',
      sourceAddr: json['sourceAddr'] as String? ?? '127.0.0.1',
      reqTimestamp: json['reqTimestamp'] as String,
      tranNo: json['tranNo'] as String? ?? '10716',
    );

Map<String, dynamic> _$CommonMessageReqToJson(CommonMessageReq instance) =>
    <String, dynamic>{
      'targetSvc': instance.targetSvc,
      'targetPackage': instance.targetPackage,
      'targetApi': instance.targetApi,
      'sourceSvc': instance.sourceSvc,
      'sourceVer': instance.sourceVer,
      'sourceAddr': instance.sourceAddr,
      'reqTimestamp': instance.reqTimestamp,
      'tranNo': instance.tranNo,
    };
