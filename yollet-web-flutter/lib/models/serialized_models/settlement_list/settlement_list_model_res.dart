import 'package:json_annotation/json_annotation.dart';
part 'settlement_list_model_res.g.dart';

@JsonSerializable()
class SettlementListRes {
  final String? settlementId;
  final String? businessRegistrationNo;
  final String? paymentMethodCode;
  final String? paymentMethodName;
  final String? settlementDatetime;
  final String? expectedTransferDate;
  final String? transferDate;
  final int? transactionCount;
  final double? settlementAmount;
  final double? settlementFee;
  final double? settlementTax;
  final double? depositAmount;
  final String? transferMethod;
  final String? transferId;

  final int? pageNo;
  final int? pageTotal;
  final int? pageSize;
  final int? itemCount;
  final double? amountSum;
  final List? settlementList;

  SettlementListRes(
      {this.businessRegistrationNo,
      this.paymentMethodCode,
      this.settlementDatetime,
      this.settlementId,
      this.transactionCount,
      this.depositAmount,
      this.transferDate,
      this.transferId,
      this.settlementList,
      this.settlementTax,
      this.transferMethod,
      this.itemCount,
      this.pageNo,
      this.pageSize,
      this.pageTotal,
      this.paymentMethodName,
      this.amountSum,
      this.settlementAmount,
      this.settlementFee,
      this.expectedTransferDate});

  factory SettlementListRes.fromJson(Map<String, dynamic> json) =>
      _$SettlementListResFromJson(json);

  Map<String, dynamic> toJson() => _$SettlementListResToJson(this);
}
