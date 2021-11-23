import 'package:json_annotation/json_annotation.dart';

part 'settlement_list_model_req.g.dart';

@JsonSerializable()
class SettlementListReq {
  String? businessRegistrationNo;
  String? paymentMethodCode;
  String? startDate;
  String? endDate;
  int? pageNo;
  int? pageSize;
  @override
  SettlementListReq({
    this.businessRegistrationNo,
    this.paymentMethodCode,
    this.startDate,
    this.endDate,
    this.pageNo,
    this.pageSize,
  });

  factory SettlementListReq.fromJson(Map<String, dynamic> json) =>
      _$SettlementListReqFromJson(json);

  Map<String, dynamic> toJson() => _$SettlementListReqToJson(this);
}
