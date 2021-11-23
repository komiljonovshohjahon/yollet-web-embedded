// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_list_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalListItemModel _$ApprovalListItemModelFromJson(
        Map<String, dynamic> json) =>
    ApprovalListItemModel(
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

Map<String, dynamic> _$ApprovalListItemModelToJson(
        ApprovalListItemModel instance) =>
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
      'approvalAmount': instance.approvalAmount,
      'resultCode': instance.resultCode,
    };
