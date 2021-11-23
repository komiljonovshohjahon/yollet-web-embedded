// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_details_model_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalDetailsRes _$ApprovalDetailsResFromJson(Map<String, dynamic> json) =>
    ApprovalDetailsRes(
      terminalId: json['terminalId'] as String?,
      paymentMethodCode: json['paymentMethodCode'] as String?,
      paymentMethodName: json['paymentMethodName'] as String?,
      approvalDatetime: json['approvalDatetime'] as String?,
      transactionType: json['transactionType'] as String?,
      approvalNo: json['approvalNo'] as String?,
      cardNo: json['cardNo'] as String?,
      rrn: json['rrn'] as String?,
      approvalAmount: (json['approvalAmount'] as num?)?.toDouble(),
      supllyValue: (json['supllyValue'] as num?)?.toDouble(),
      tax: (json['tax'] as num?)?.toDouble(),
      tip: (json['tip'] as num?)?.toDouble(),
      store: json['store'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ApprovalDetailsResToJson(ApprovalDetailsRes instance) =>
    <String, dynamic>{
      'terminalId': instance.terminalId,
      'paymentMethodCode': instance.paymentMethodCode,
      'paymentMethodName': instance.paymentMethodName,
      'approvalDatetime': instance.approvalDatetime,
      'transactionType': instance.transactionType,
      'approvalNo': instance.approvalNo,
      'cardNo': instance.cardNo,
      'rrn': instance.rrn,
      'approvalAmount': instance.approvalAmount,
      'supllyValue': instance.supllyValue,
      'tax': instance.tax,
      'tip': instance.tip,
      'store': instance.store,
    };
