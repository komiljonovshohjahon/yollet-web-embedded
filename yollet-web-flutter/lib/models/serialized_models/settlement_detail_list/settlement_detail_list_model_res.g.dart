// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_detail_list_model_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettlementDetailListRes _$SettlementDetailListResFromJson(
        Map<String, dynamic> json) =>
    SettlementDetailListRes(
      pageNo: json['pageNo'] as int?,
      pageTotal: json['pageTotal'] as int?,
      pageSize: json['pageSize'] as int?,
      itemCount: json['itemCount'] as int?,
      amountSum: (json['amountSum'] as num?)?.toDouble(),
      transactionList: json['transactionList'] as List<dynamic>?,
      transactionId: json['transactionId'] as String?,
      businessRegistrationNo: json['businessRegistrationNo'] as String?,
      settlementId: json['settlementId'] as String?,
      paymentMethodCode: json['paymentMethodCode'] as String?,
      paymentMethodName: json['paymentMethodName'] as String?,
      settlementDatetime: json['settlementDatetime'] as String?,
      approvalDatetime: json['approvalDatetime'] as String?,
      acquirerCode: json['acquirerCode'] as String?,
      acquirerName: json['acquirerName'] as String?,
      transactionType: json['transactionType'] as String?,
      approvalAmount: (json['approvalAmount'] as num?)?.toDouble(),
      commision: (json['commision'] as num?)?.toDouble(),
      settlementTax: (json['settlementTax'] as num?)?.toDouble(),
      transferAmount: (json['transferAmount'] as num?)?.toDouble(),
      orderId: json['orderId'] as String?,
      transferId: json['transferId'] as String?,
    );

Map<String, dynamic> _$SettlementDetailListResToJson(
        SettlementDetailListRes instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'businessRegistrationNo': instance.businessRegistrationNo,
      'settlementId': instance.settlementId,
      'paymentMethodCode': instance.paymentMethodCode,
      'paymentMethodName': instance.paymentMethodName,
      'settlementDatetime': instance.settlementDatetime,
      'approvalDatetime': instance.approvalDatetime,
      'acquirerCode': instance.acquirerCode,
      'acquirerName': instance.acquirerName,
      'transactionType': instance.transactionType,
      'orderId': instance.orderId,
      'transferId': instance.transferId,
      'approvalAmount': instance.approvalAmount,
      'commision': instance.commision,
      'settlementTax': instance.settlementTax,
      'transferAmount': instance.transferAmount,
      'pageNo': instance.pageNo,
      'pageTotal': instance.pageTotal,
      'pageSize': instance.pageSize,
      'itemCount': instance.itemCount,
      'amountSum': instance.amountSum,
      'transactionList': instance.transactionList,
    };
