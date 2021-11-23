import 'package:json_annotation/json_annotation.dart';
part 'payment_method_list_global_model_res.g.dart';

@JsonSerializable()
class PaymentMethodGlobalListRes {
  List? paymentMethodList;

  PaymentMethodGlobalListRes({
    this.paymentMethodList,
  });

  factory PaymentMethodGlobalListRes.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodGlobalListResFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodGlobalListResToJson(this);
}
