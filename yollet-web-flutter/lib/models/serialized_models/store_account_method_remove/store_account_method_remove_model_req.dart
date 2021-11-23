import 'package:json_annotation/json_annotation.dart';

part 'store_account_method_remove_model_req.g.dart';

@JsonSerializable()
class StoreAccountMethodRemoveReq {
  String accountId;
  @override
  StoreAccountMethodRemoveReq({
    required this.accountId,
  });

  factory StoreAccountMethodRemoveReq.fromJson(Map<String, dynamic> json) =>
      _$StoreAccountMethodRemoveReqFromJson(json);

  Map<String, dynamic> toJson() => _$StoreAccountMethodRemoveReqToJson(this);
}
