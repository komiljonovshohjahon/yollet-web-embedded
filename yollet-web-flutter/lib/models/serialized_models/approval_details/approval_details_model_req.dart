import 'package:json_annotation/json_annotation.dart';

part 'approval_details_model_req.g.dart';

@JsonSerializable()
class ApprovalDetailsReq {
  String? transactionId;

  @override
  ApprovalDetailsReq({
    this.transactionId,
  });

  factory ApprovalDetailsReq.fromJson(Map<String, dynamic> json) =>
      _$ApprovalDetailsReqFromJson(json);

  Map<String, dynamic> toJson() => _$ApprovalDetailsReqToJson(this);
}
