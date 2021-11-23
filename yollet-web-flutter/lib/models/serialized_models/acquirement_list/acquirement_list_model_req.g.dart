// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acquirement_list_model_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcquirementListReq _$AcquirementListReqFromJson(Map<String, dynamic> json) =>
    AcquirementListReq(
      businessRegistrationNo: json['businessRegistrationNo'] as String?,
      paymentMethodCode: json['paymentMethodCode'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      acquirementState: json['acquirementState'] as String?,
      pageNo: json['pageNo'] as int?,
      pageSize: json['pageSize'] as int?,
    );

Map<String, dynamic> _$AcquirementListReqToJson(AcquirementListReq instance) =>
    <String, dynamic>{
      'businessRegistrationNo': instance.businessRegistrationNo,
      'paymentMethodCode': instance.paymentMethodCode,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'acquirementState': instance.acquirementState,
      'pageNo': instance.pageNo,
      'pageSize': instance.pageSize,
    };
