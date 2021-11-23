import 'package:json_annotation/json_annotation.dart';

part 'store_delete_model_req.g.dart';

@JsonSerializable()
class StoreDeleteReq {
  String storeId;
  String? password;

  @override
  StoreDeleteReq({
    required this.storeId,
    this.password,
  });

  factory StoreDeleteReq.fromJson(Map<String, dynamic> json) =>
      _$StoreDeleteReqFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDeleteReqToJson(this);
}
