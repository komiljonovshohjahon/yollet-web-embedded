// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_account_method_update_model_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreAccountMethodUpdateReq _$StoreAccountMethodUpdateReqFromJson(
        Map<String, dynamic> json) =>
    StoreAccountMethodUpdateReq(
      accountId: json['accountId'] as String,
      transferMethodCode: json['transferMethodCode'] as String,
      depositBank: json['depositBank'] as String?,
      holderName: json['holderName'] as String?,
      accountNo: json['accountNo'] as String?,
      accountName: json['accountName'] as String?,
    );

Map<String, dynamic> _$StoreAccountMethodUpdateReqToJson(
        StoreAccountMethodUpdateReq instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'transferMethodCode': instance.transferMethodCode,
      'accountName': instance.accountName,
      'holderName': instance.holderName,
      'accountNo': instance.accountNo,
      'depositBank': instance.depositBank,
    };
