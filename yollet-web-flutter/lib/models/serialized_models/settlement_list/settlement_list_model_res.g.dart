// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_list_model_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettlementListRes _$SettlementListResFromJson(Map<String, dynamic> json) =>
    SettlementListRes(
      businessRegistrationNo: json['businessRegistrationNo'] as String?,
      paymentMethodCode: json['paymentMethodCode'] as String?,
      settlementDatetime: json['settlementDatetime'] as String?,
      settlementId: json['settlementId'] as String?,
      transactionCount: json['transactionCount'] as int?,
      depositAmount: (json['depositAmount'] as num?)?.toDouble(),
      transferDate: json['transferDate'] as String?,
      transferId: json['transferId'] as String?,
      settlementList: json['settlementList'] as List<dynamic>?,
      settlementTax: (json['settlementTax'] as num?)?.toDouble(),
      transferMethod: json['transferMethod'] as String?,
      itemCount: json['itemCount'] as int?,
      pageNo: json['pageNo'] as int?,
      pageSize: json['pageSize'] as int?,
      pageTotal: json['pageTotal'] as int?,
      paymentMethodName: json['paymentMethodName'] as String?,
      amountSum: (json['amountSum'] as num?)?.toDouble(),
      settlementAmount: (json['settlementAmount'] as num?)?.toDouble(),
      settlementFee: (json['settlementFee'] as num?)?.toDouble(),
      expectedTransferDate: json['expectedTransferDate'] as String?,
    );

Map<String, dynamic> _$SettlementListResToJson(SettlementListRes instance) =>
    <String, dynamic>{
      'settlementId': instance.settlementId,
      'businessRegistrationNo': instance.businessRegistrationNo,
      'paymentMethodCode': instance.paymentMethodCode,
      'paymentMethodName': instance.paymentMethodName,
      'settlementDatetime': instance.settlementDatetime,
      'expectedTransferDate': instance.expectedTransferDate,
      'transferDate': instance.transferDate,
      'transactionCount': instance.transactionCount,
      'settlementAmount': instance.settlementAmount,
      'settlementFee': instance.settlementFee,
      'settlementTax': instance.settlementTax,
      'depositAmount': instance.depositAmount,
      'transferMethod': instance.transferMethod,
      'transferId': instance.transferId,
      'pageNo': instance.pageNo,
      'pageTotal': instance.pageTotal,
      'pageSize': instance.pageSize,
      'itemCount': instance.itemCount,
      'amountSum': instance.amountSum,
      'settlementList': instance.settlementList,
    };
