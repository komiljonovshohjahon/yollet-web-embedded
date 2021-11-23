import 'package:json_annotation/json_annotation.dart';

part 'transfer_details_model_res.g.dart';

@JsonSerializable()
class TransferDetailsRes {
  final String? transferState;
  final double? depositAmount;
  final String? transferDatetime;
  final Map? deposit;
  final Map? withdrawal;

  TransferDetailsRes({
    this.transferState,
    this.deposit,
    this.withdrawal,
    this.depositAmount,
    this.transferDatetime,
  });

  factory TransferDetailsRes.fromJson(Map<String, dynamic> json) =>
      _$TransferDetailsResFromJson(json);

  Map<String, dynamic> toJson() => _$TransferDetailsResToJson(this);
}
