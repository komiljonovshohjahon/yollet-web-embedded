import 'package:json_annotation/json_annotation.dart';

part 'approval_details_model_res.g.dart';

@JsonSerializable()
class ApprovalDetailsRes {
  final String? terminalId;
  final String? paymentMethodCode;
  final String? paymentMethodName;
  final String? approvalDatetime;
  final String? transactionType;
  final String? approvalNo;
  final String? cardNo;
  final String? rrn;

  final double? approvalAmount;
  final double? supllyValue;
  final double? tax;
  final double? tip;

  final Map? store;

  ApprovalDetailsRes({
    this.terminalId,
    this.paymentMethodCode,
    this.paymentMethodName,
    this.approvalDatetime,
    this.transactionType,
    this.approvalNo,
    this.cardNo,
    this.rrn,
    this.approvalAmount,
    this.supllyValue,
    this.tax,
    this.tip,
    this.store,
  });

  factory ApprovalDetailsRes.fromJson(Map<String, dynamic> json) =>
      _$ApprovalDetailsResFromJson(json);

  Map<String, dynamic> toJson() => _$ApprovalDetailsResToJson(this);
}
