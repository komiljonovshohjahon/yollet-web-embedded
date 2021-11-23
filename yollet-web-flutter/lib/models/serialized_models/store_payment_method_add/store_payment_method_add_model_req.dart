import 'package:json_annotation/json_annotation.dart';

part 'store_payment_method_add_model_req.g.dart';

@JsonSerializable()
class StorePaymentMethodAddReq {
  String storeId;
  String code;
  String name;

  String? description;
  String? tid;
  String? apiKey;
  double? fee;
  String? otherInput;
  @override
  StorePaymentMethodAddReq({
    required this.storeId,
    required this.code,
    required this.name,
    this.description,
    this.fee,
    this.tid,
    this.apiKey,
    this.otherInput,
  });

  factory StorePaymentMethodAddReq.fromJson(Map<String, dynamic> json) =>
      _$StorePaymentMethodAddReqFromJson(json);

  Map<String, dynamic> toJson() => _$StorePaymentMethodAddReqToJson(this);
}
