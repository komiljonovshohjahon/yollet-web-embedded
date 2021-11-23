// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_details_model_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferDetailsRes _$TransferDetailsResFromJson(Map<String, dynamic> json) =>
    TransferDetailsRes(
      transferState: json['transferState'] as String?,
      deposit: json['deposit'] as Map<String, dynamic>?,
      withdrawal: json['withdrawal'] as Map<String, dynamic>?,
      depositAmount: (json['depositAmount'] as num?)?.toDouble(),
      transferDatetime: json['transferDatetime'] as String?,
    );

Map<String, dynamic> _$TransferDetailsResToJson(TransferDetailsRes instance) =>
    <String, dynamic>{
      'transferState': instance.transferState,
      'depositAmount': instance.depositAmount,
      'transferDatetime': instance.transferDatetime,
      'deposit': instance.deposit,
      'withdrawal': instance.withdrawal,
    };
