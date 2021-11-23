import 'package:json_annotation/json_annotation.dart';

part 'payment_method_list_model_req.g.dart';

@JsonSerializable()
class StorePaymentMethodListReq {
  String storeId;
  @override
  StorePaymentMethodListReq({
    required this.storeId,
  });

  factory StorePaymentMethodListReq.fromJson(Map<String, dynamic> json) =>
      _$StorePaymentMethodListReqFromJson(json);

  Map<String, dynamic> toJson() => _$StorePaymentMethodListReqToJson(this);
}
