// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_list_model_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferListReq _$TransferListReqFromJson(Map<String, dynamic> json) =>
    TransferListReq(
      businessRegistrationNo: json['businessRegistrationNo'] as String?,
      paymentMethodCode: json['paymentMethodCode'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      transferState: json['transferState'] as String?,
      pageNo: json['pageNo'] as int?,
      pageSize: json['pageSize'] as int?,
    );

Map<String, dynamic> _$TransferListReqToJson(TransferListReq instance) =>
    <String, dynamic>{
      'businessRegistrationNo': instance.businessRegistrationNo,
      'paymentMethodCode': instance.paymentMethodCode,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'transferState': instance.transferState,
      'pageNo': instance.pageNo,
      'pageSize': instance.pageSize,
    };
