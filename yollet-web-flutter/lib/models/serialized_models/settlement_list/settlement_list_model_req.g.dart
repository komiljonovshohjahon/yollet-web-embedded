// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_list_model_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettlementListReq _$SettlementListReqFromJson(Map<String, dynamic> json) =>
    SettlementListReq(
      businessRegistrationNo: json['businessRegistrationNo'] as String?,
      paymentMethodCode: json['paymentMethodCode'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      pageNo: json['pageNo'] as int?,
      pageSize: json['pageSize'] as int?,
    );

Map<String, dynamic> _$SettlementListReqToJson(SettlementListReq instance) =>
    <String, dynamic>{
      'businessRegistrationNo': instance.businessRegistrationNo,
      'paymentMethodCode': instance.paymentMethodCode,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'pageNo': instance.pageNo,
      'pageSize': instance.pageSize,
    };
