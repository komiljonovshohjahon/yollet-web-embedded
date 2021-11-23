// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acquirement_list_model_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcquirementListRes _$AcquirementListResFromJson(Map<String, dynamic> json) =>
    AcquirementListRes(
      pageNo: json['pageNo'] as int?,
      pageSize: json['pageSize'] as int?,
      pageTotal: json['pageTotal'] as int?,
      itemCount: json['itemCount'] as int?,
      amountSum: (json['amountSum'] as num?)?.toDouble(),
      acquirementList: json['acquirementList'] as List<dynamic>?,
      transactionId: json['transactionId'] as String?,
      businessRegistrationNo: json['businessRegistrationNo'] as String?,
      paymentMethodCode: json['paymentMethodCode'] as String?,
      paymentMethodName: json['paymentMethodName'] as String?,
      approvalDatetime: json['approvalDatetime'] as String?,
      transactionType: json['transactionType'] as String?,
      acquirerName: json['acquirerName'] as String?,
      cardNo: json['cardNo'] as String?,
      approvalNo: json['approvalNo'] as String?,
      approvalAmount: (json['approvalAmount'] as num?)?.toDouble(),
      requestDatetime: json['requestDatetime'] as String?,
      doneDatetime: json['doneDatetime'] as String?,
      acquirementState: json['acquirementState'] as String?,
    );

Map<String, dynamic> _$AcquirementListResToJson(AcquirementListRes instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'businessRegistrationNo': instance.businessRegistrationNo,
      'paymentMethodCode': instance.paymentMethodCode,
      'paymentMethodName': instance.paymentMethodName,
      'approvalDatetime': instance.approvalDatetime,
      'transactionType': instance.transactionType,
      'acquirerName': instance.acquirerName,
      'cardNo': instance.cardNo,
      'approvalNo': instance.approvalNo,
      'requestDatetime': instance.requestDatetime,
      'doneDatetime': instance.doneDatetime,
      'acquirementState': instance.acquirementState,
      'approvalAmount': instance.approvalAmount,
      'pageNo': instance.pageNo,
      'pageTotal': instance.pageTotal,
      'pageSize': instance.pageSize,
      'itemCount': instance.itemCount,
      'amountSum': instance.amountSum,
      'acquirementList': instance.acquirementList,
    };
