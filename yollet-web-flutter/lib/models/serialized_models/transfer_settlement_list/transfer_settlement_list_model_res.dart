import 'package:json_annotation/json_annotation.dart';

part 'transfer_settlement_list_model_res.g.dart';

@JsonSerializable()
class TransferSettlementListRes {
  final List? settlementList;

  TransferSettlementListRes({
    this.settlementList,
  });

  factory TransferSettlementListRes.fromJson(Map<String, dynamic> json) =>
      _$TransferSettlementListResFromJson(json);

  Map<String, dynamic> toJson() => _$TransferSettlementListResToJson(this);
}
