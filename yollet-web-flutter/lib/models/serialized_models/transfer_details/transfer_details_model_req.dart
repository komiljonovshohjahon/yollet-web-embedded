import 'package:json_annotation/json_annotation.dart';

part 'transfer_details_model_req.g.dart';

@JsonSerializable()
class TransferDetailsReq {
  String? transferId;

  @override
  TransferDetailsReq({
    this.transferId,
  });

  factory TransferDetailsReq.fromJson(Map<String, dynamic> json) =>
      _$TransferDetailsReqFromJson(json);

  Map<String, dynamic> toJson() => _$TransferDetailsReqToJson(this);
}
