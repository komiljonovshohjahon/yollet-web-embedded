import 'package:json_annotation/json_annotation.dart';

part 'store_payment_method_update_model_req.g.dart';

@JsonSerializable()
class StorePaymentMethodUpdateReq {
  String paymentMethodId;
  String code;
  String name;

  String? description;
  String? tid;
  String? apiKey;
  double? fee;
  String? otherInput;
  @override
  StorePaymentMethodUpdateReq({
    required this.paymentMethodId,
    required this.code,
    required this.name,
    this.description,
    this.fee,
    this.tid,
    this.apiKey,
    this.otherInput,
  });

  factory StorePaymentMethodUpdateReq.fromJson(Map<String, dynamic> json) =>
      _$StorePaymentMethodUpdateReqFromJson(json);

  Map<String, dynamic> toJson() => _$StorePaymentMethodUpdateReqToJson(this);
}
