import 'package:json_annotation/json_annotation.dart';
part 'transfer_settlement_list_model_req.g.dart';

@JsonSerializable()
class TransferSettlementListReq {
  String? transferId;

  @override
  TransferSettlementListReq({
    this.transferId,
  });

  factory TransferSettlementListReq.fromJson(Map<String, dynamic> json) =>
      _$TransferSettlementListReqFromJson(json);

  Map<String, dynamic> toJson() => _$TransferSettlementListReqToJson(this);
}
