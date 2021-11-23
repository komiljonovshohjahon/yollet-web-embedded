import 'package:json_annotation/json_annotation.dart';
part 'transfer_state_list_model_req.g.dart';

@JsonSerializable()
class TransferStateListReq {
  String? transferId;

  @override
  TransferStateListReq({
    this.transferId,
  });

  factory TransferStateListReq.fromJson(Map<String, dynamic> json) =>
      _$TransferStateListReqFromJson(json);

  Map<String, dynamic> toJson() => _$TransferStateListReqToJson(this);
}
