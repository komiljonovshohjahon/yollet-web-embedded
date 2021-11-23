// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_update_model_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreUpdateReq _$StoreUpdateReqFromJson(Map<String, dynamic> json) =>
    StoreUpdateReq(
      storeId: json['storeId'] as String,
      storeName: json['storeName'] as String?,
      ownerName: json['ownerName'] as String?,
      password: json['password'] as String,
      newPassword: json['newPassword'] as String?,
      businessRegistrationNo: json['businessRegistrationNo'] as String?,
      telNo: json['telNo'] as String?,
      primaryAddress: json['primaryAddress'] as String?,
      detailAddress: json['detailAddress'] as String?,
    );

Map<String, dynamic> _$StoreUpdateReqToJson(StoreUpdateReq instance) =>
    <String, dynamic>{
      'storeId': instance.storeId,
      'storeName': instance.storeName,
      'ownerName': instance.ownerName,
      'password': instance.password,
      'newPassword': instance.newPassword,
      'businessRegistrationNo': instance.businessRegistrationNo,
      'telNo': instance.telNo,
      'primaryAddress': instance.primaryAddress,
      'detailAddress': instance.detailAddress,
    };
