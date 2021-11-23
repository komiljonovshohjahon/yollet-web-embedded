import 'package:json_annotation/json_annotation.dart';

part 'store_details_model_req.g.dart';

@JsonSerializable()
class StoreDetailsReq {
  String storeId;

  @override
  StoreDetailsReq({
    required this.storeId,
  });

  factory StoreDetailsReq.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailsReqFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDetailsReqToJson(this);
}
