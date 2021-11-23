import 'package:json_annotation/json_annotation.dart';

part 'account_list_model_req.g.dart';

@JsonSerializable()
class StoreAccountListReq {
  String storeId;

  @override
  StoreAccountListReq({
    required this.storeId,
  });

  factory StoreAccountListReq.fromJson(Map<String, dynamic> json) =>
      _$StoreAccountListReqFromJson(json);

  Map<String, dynamic> toJson() => _$StoreAccountListReqToJson(this);
}
