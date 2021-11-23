// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_list_model_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalListReq _$ApprovalListReqFromJson(Map<String, dynamic> json) =>
    ApprovalListReq(
      businessRegistrationNo: json['businessRegistrationNo'] as String?,
      paymentMethodCode: json['paymentMethodCode'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      transactionType: json['transactionType'] as String?,
      approvalNo: json['approvalNo'] as String?,
      approvalAmount: (json['approvalAmount'] as num?)?.toDouble(),
      pageNo: json['pageNo'] as int?,
      pageSize: json['pageSize'] as int?,
    );

Map<String, dynamic> _$ApprovalListReqToJson(ApprovalListReq instance) =>
    <String, dynamic>{
      'businessRegistrationNo': instance.businessRegistrationNo,
      'paymentMethodCode': instance.paymentMethodCode,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'transactionType': instance.transactionType,
      'approvalNo': instance.approvalNo,
      'approvalAmount': instance.approvalAmount,
      'pageNo': instance.pageNo,
      'pageSize': instance.pageSize,
    };
