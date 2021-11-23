// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_detail_list_model_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettlementDetailListReq _$SettlementDetailListReqFromJson(
        Map<String, dynamic> json) =>
    SettlementDetailListReq(
      businessRegistrationNo: json['businessRegistrationNo'] as String?,
      settlementId: json['settlementId'] as String?,
      paymentMethodCode: json['paymentMethodCode'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      transactionId: json['transactionId'] as String?,
      orderId: json['orderId'] as String?,
      pageNo: json['pageNo'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? 10,
    );

Map<String, dynamic> _$SettlementDetailListReqToJson(
        SettlementDetailListReq instance) =>
    <String, dynamic>{
      'businessRegistrationNo': instance.businessRegistrationNo,
      'settlementId': instance.settlementId,
      'paymentMethodCode': instance.paymentMethodCode,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'transactionId': instance.transactionId,
      'orderId': instance.orderId,
      'pageNo': instance.pageNo,
      'pageSize': instance.pageSize,
    };
