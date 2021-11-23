// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_list_model_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreListRes _$StoreListResFromJson(Map<String, dynamic> json) => StoreListRes(
      storeName: json['storeName'] as String?,
      businessRegistrationNo: json['businessRegistrationNo'] as String?,
      creationTime: json['creationTime'] as String?,
      detailAddress: json['detailAddress'] as String?,
      itemCount: json['itemCount'] as int?,
      licenseUrl: json['licenseUrl'] as String?,
      loginId: json['loginId'] as String?,
      pageNo: json['pageNo'] as int?,
      pageSize: json['pageSize'] as int?,
      pageTotal: json['pageTotal'] as int?,
      primaryAddress: json['primaryAddress'] as String?,
      storeId: json['storeId'] as String?,
      storeList: json['storeList'] as List<dynamic>?,
    );

Map<String, dynamic> _$StoreListResToJson(StoreListRes instance) =>
    <String, dynamic>{
      'pageNo': instance.pageNo,
      'pageTotal': instance.pageTotal,
      'pageSize': instance.pageSize,
      'itemCount': instance.itemCount,
      'storeList': instance.storeList,
      'storeId': instance.storeId,
      'businessRegistrationNo': instance.businessRegistrationNo,
      'storeName': instance.storeName,
      'licenseUrl': instance.licenseUrl,
      'loginId': instance.loginId,
      'creationTime': instance.creationTime,
      'primaryAddress': instance.primaryAddress,
      'detailAddress': instance.detailAddress,
    };
