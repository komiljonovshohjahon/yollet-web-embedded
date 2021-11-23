// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_details_model_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreDetailsRes _$StoreDetailsResFromJson(Map<String, dynamic> json) =>
    StoreDetailsRes(
      storeName: json['storeName'] as String?,
      ownerName: json['ownerName'] as String?,
      businessRegistrationNo: json['businessRegistrationNo'] as String?,
      telNo: json['telNo'] as String?,
      primaryAddress: json['primaryAddress'] as String?,
      loginId: json['loginId'] as String?,
      licenseUrl: json['licenseUrl'] as String?,
      detailAddress: json['detailAddress'] as String?,
    );

Map<String, dynamic> _$StoreDetailsResToJson(StoreDetailsRes instance) =>
    <String, dynamic>{
      'storeName': instance.storeName,
      'businessRegistrationNo': instance.businessRegistrationNo,
      'ownerName': instance.ownerName,
      'licenseUrl': instance.licenseUrl,
      'loginId': instance.loginId,
      'telNo': instance.telNo,
      'primaryAddress': instance.primaryAddress,
      'detailAddress': instance.detailAddress,
    };
