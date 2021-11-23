import 'package:json_annotation/json_annotation.dart';
part 'payment_method_list_model_res.g.dart';

@JsonSerializable()
class StorePaymentMethodListRes {
  final List? methodList;

  StorePaymentMethodListRes({
    this.methodList,
  });

  factory StorePaymentMethodListRes.fromJson(Map<String, dynamic> json) =>
      _$StorePaymentMethodListResFromJson(json);

  Map<String, dynamic> toJson() => _$StorePaymentMethodListResToJson(this);
}
