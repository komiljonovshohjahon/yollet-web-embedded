import 'package:json_annotation/json_annotation.dart';

part 'settlement_detail_list_model_req.g.dart';

@JsonSerializable()
class SettlementDetailListReq {
  String? businessRegistrationNo;
  String? settlementId;
  String? paymentMethodCode;
  String? startDate;
  String? endDate;
  String? transactionId;
  String? orderId;
  int? pageNo;
  int? pageSize;

  @override
  SettlementDetailListReq({
    this.businessRegistrationNo,
    this.settlementId,
    this.paymentMethodCode,
    this.startDate,
    this.endDate,
    this.transactionId,
    this.orderId,
    this.pageNo = 1,
    this.pageSize = 10,
  });

  factory SettlementDetailListReq.fromJson(Map<String, dynamic> json) =>
      _$SettlementDetailListReqFromJson(json);

  Map<String, dynamic> toJson() => _$SettlementDetailListReqToJson(this);
}
