import 'package:json_annotation/json_annotation.dart';

part 'store_payment_method_remove_model_req.g.dart';

@JsonSerializable()
class StorePaymentMethodRemoveReq {
  String paymentMethodId;
  @override
  StorePaymentMethodRemoveReq({
    required this.paymentMethodId,
  });

  factory StorePaymentMethodRemoveReq.fromJson(Map<String, dynamic> json) =>
      _$StorePaymentMethodRemoveReqFromJson(json);

  Map<String, dynamic> toJson() => _$StorePaymentMethodRemoveReqToJson(this);
}
