// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_account_method_add_model_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreAccountMethodAddReq _$StoreAccountMethodAddReqFromJson(
        Map<String, dynamic> json) =>
    StoreAccountMethodAddReq(
      storeId: json['storeId'] as String,
      transferMethodCode: json['transferMethodCode'] as String,
      depositBank: json['depositBank'] as String?,
      holderName: json['holderName'] as String?,
      accountNo: json['accountNo'] as String?,
      accountName: json['accountName'] as String?,
    );

Map<String, dynamic> _$StoreAccountMethodAddReqToJson(
        StoreAccountMethodAddReq instance) =>
    <String, dynamic>{
      'storeId': instance.storeId,
      'accountName': instance.accountName,
      'holderName': instance.holderName,
      'accountNo': instance.accountNo,
      'depositBank': instance.depositBank,
      'transferMethodCode': instance.transferMethodCode,
    };
