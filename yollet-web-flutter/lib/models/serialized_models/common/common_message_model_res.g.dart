// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_message_model_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonMessageRes _$CommonMessageResFromJson(Map<String, dynamic> json) =>
    CommonMessageRes(
      targetSvc: json['targetSvc'] as String?,
      targetPackage: json['targetPackage'] as String?,
      targetApi: json['targetApi'] as String?,
      sourceSvc: json['sourceSvc'] as String?,
      sourceVer: json['sourceVer'] as String?,
      sourceAddr: json['sourceAddr'] as String?,
      reqTimestamp: json['reqTimestamp'] as String?,
      tranNo: json['tranNo'] as String?,
      resTimestamp: json['resTimestamp'] as String?,
      resCode: json['resCode'] as String?,
      resMessage: json['resMessage'] as String?,
    );

Map<String, dynamic> _$CommonMessageResToJson(CommonMessageRes instance) =>
    <String, dynamic>{
      'targetSvc': instance.targetSvc,
      'targetPackage': instance.targetPackage,
      'targetApi': instance.targetApi,
      'sourceSvc': instance.sourceSvc,
      'sourceVer': instance.sourceVer,
      'sourceAddr': instance.sourceAddr,
      'reqTimestamp': instance.reqTimestamp,
      'tranNo': instance.tranNo,
      'resTimestamp': instance.resTimestamp,
      'resCode': instance.resCode,
      'resMessage': instance.resMessage,
    };
