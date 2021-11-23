// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_list_model_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferListRes _$TransferListResFromJson(Map<String, dynamic> json) =>
    TransferListRes(
      pageNo: json['pageNo'] as int?,
      pageTotal: json['pageTotal'] as int?,
      pageSize: json['pageSize'] as int?,
      itemCount: json['itemCount'] as int?,
      amountSum: (json['amountSum'] as num?)?.toDouble(),
      transferList: json['transferList'] as List<dynamic>?,
    );

Map<String, dynamic> _$TransferListResToJson(TransferListRes instance) =>
    <String, dynamic>{
      'pageNo': instance.pageNo,
      'pageTotal': instance.pageTotal,
      'pageSize': instance.pageSize,
      'itemCount': instance.itemCount,
      'amountSum': instance.amountSum,
      'transferList': instance.transferList,
    };
