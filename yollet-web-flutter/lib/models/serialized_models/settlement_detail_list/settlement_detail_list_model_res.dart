import 'package:json_annotation/json_annotation.dart';

part 'settlement_detail_list_model_res.g.dart';

@JsonSerializable()
class SettlementDetailListRes {
  final String? transactionId;
  final String? businessRegistrationNo;
  final String? settlementId;
  final String? paymentMethodCode;
  final String? paymentMethodName;
  final String? settlementDatetime;
  final String? approvalDatetime;
  final String? acquirerCode;
  final String? acquirerName;
  final String? transactionType;
  final String? orderId;
  final String? transferId;

  final double? approvalAmount;
  final double? commision;
  final double? settlementTax;
  final double? transferAmount;

  final int? pageNo;
  final int? pageTotal;
  final int? pageSize;
  final int? itemCount;
  final double? amountSum;
  final List? transactionList;

  SettlementDetailListRes({
    this.pageNo,
    this.pageTotal,
    this.pageSize,
    this.itemCount,
    this.amountSum,
    this.transactionList,
    this.transactionId,
    this.businessRegistrationNo,
    this.settlementId,
    this.paymentMethodCode,
    this.paymentMethodName,
    this.settlementDatetime,
    this.approvalDatetime,
    this.acquirerCode,
    this.acquirerName,
    this.transactionType,
    this.approvalAmount,
    this.commision,
    this.settlementTax,
    this.transferAmount,
    this.orderId,
    this.transferId,
  });

  factory SettlementDetailListRes.fromJson(Map<String, dynamic> json) =>
      _$SettlementDetailListResFromJson(json);

  Map<String, dynamic> toJson() => _$SettlementDetailListResToJson(this);
}
