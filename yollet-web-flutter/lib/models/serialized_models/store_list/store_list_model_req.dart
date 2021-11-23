import 'package:json_annotation/json_annotation.dart';

part 'store_list_model_req.g.dart';

@JsonSerializable()
class StoreListReq {
  int? pageNo;
  int? pageSize;
  @override
  StoreListReq({
    this.pageNo = 1,
    this.pageSize = 10,
  });

  factory StoreListReq.fromJson(Map<String, dynamic> json) =>
      _$StoreListReqFromJson(json);

  Map<String, dynamic> toJson() => _$StoreListReqToJson(this);
}
