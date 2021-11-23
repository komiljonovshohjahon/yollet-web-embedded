// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_list_model_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreListReq _$StoreListReqFromJson(Map<String, dynamic> json) => StoreListReq(
      pageNo: json['pageNo'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? 10,
    );

Map<String, dynamic> _$StoreListReqToJson(StoreListReq instance) =>
    <String, dynamic>{
      'pageNo': instance.pageNo,
      'pageSize': instance.pageSize,
    };
