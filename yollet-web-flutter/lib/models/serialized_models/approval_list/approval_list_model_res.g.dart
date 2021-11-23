// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_list_model_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalListRes _$ApprovalListResFromJson(Map<String, dynamic> json) =>
    ApprovalListRes(
      pageNo: json['pageNo'] as int?,
      pageSize: json['pageSize'] as int?,
      pageTotal: json['pageTotal'] as int?,
      itemCount: json['itemCount'] as int?,
      amountSum: (json['amountSum'] as num?)?.toDouble(),
      approvalList: json['approvalList'] as List<dynamic>?,
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
      resultCode: json['resultCode'] as String?,
    );

Map<String, dynamic> _$ApprovalListResToJson(ApprovalListRes instance) =>
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
      'resultCode': instance.resultCode,
      'pageNo': instance.pageNo,
      'pageTotal': instance.pageTotal,
      'pageSize': instance.pageSize,
      'itemCount': instance.itemCount,
      'approvalAmount': instance.approvalAmount,
      'amountSum': instance.amountSum,
      'approvalList': instance.approvalList,
    };
