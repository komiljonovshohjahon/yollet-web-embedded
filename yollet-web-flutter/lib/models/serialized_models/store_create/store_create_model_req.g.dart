// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_create_model_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreCreateReq _$StoreCreateReqFromJson(Map<String, dynamic> json) =>
    StoreCreateReq(
      agencyId: json['agencyId'] as String,
      storeName: json['storeName'] as String?,
      ownerName: json['ownerName'] as String?,
      id: json['id'] as String,
      password: json['password'] as String,
      businessRegistrationNo: json['businessRegistrationNo'] as String?,
      telNo: json['telNo'] as String?,
      primaryAddress: json['primaryAddress'] as String?,
      detailAddress: json['detailAddress'] as String?,
    );

Map<String, dynamic> _$StoreCreateReqToJson(StoreCreateReq instance) =>
    <String, dynamic>{
      'agencyId': instance.agencyId,
      'storeName': instance.storeName,
      'ownerName': instance.ownerName,
      'id': instance.id,
      'password': instance.password,
      'businessRegistrationNo': instance.businessRegistrationNo,
      'telNo': instance.telNo,
      'primaryAddress': instance.primaryAddress,
      'detailAddress': instance.detailAddress,
    };
