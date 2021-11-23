// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_payment_method_add_model_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StorePaymentMethodAddReq _$StorePaymentMethodAddReqFromJson(
        Map<String, dynamic> json) =>
    StorePaymentMethodAddReq(
      storeId: json['storeId'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      fee: (json['fee'] as num?)?.toDouble(),
      tid: json['tid'] as String?,
      apiKey: json['apiKey'] as String?,
      otherInput: json['otherInput'] as String?,
    );

Map<String, dynamic> _$StorePaymentMethodAddReqToJson(
        StorePaymentMethodAddReq instance) =>
    <String, dynamic>{
      'storeId': instance.storeId,
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'tid': instance.tid,
      'apiKey': instance.apiKey,
      'fee': instance.fee,
      'otherInput': instance.otherInput,
    };
