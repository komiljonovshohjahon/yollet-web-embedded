import 'package:json_annotation/json_annotation.dart';

part 'approval_list_model_res.g.dart';

@JsonSerializable()
class ApprovalListRes {
  final String? transactionId;
  final String? businessRegistrationNo;
  final String? paymentMethodCode;
  final String? paymentMethodName;
  final String? approvalDatetime;
  final String? transactionType;
  final String? acquirerName;
  final String? cardNo;
  final String? approvalNo;
  final String? resultCode;

  final int? pageNo;
  final int? pageTotal;
  final int? pageSize;
  final int? itemCount;
  final double? approvalAmount;
  final double? amountSum;
  final List? approvalList;

  ApprovalListRes({
    this.pageNo,
    this.pageSize,
    this.pageTotal,
    this.itemCount,
    this.amountSum,
    this.approvalList,
    this.transactionId,
    this.businessRegistrationNo,
    this.paymentMethodCode,
    this.paymentMethodName,
    this.approvalDatetime,
    this.transactionType,
    this.acquirerName,
    this.cardNo,
    this.approvalNo,
    this.approvalAmount,
    this.resultCode,
  });

  factory ApprovalListRes.fromJson(Map<String, dynamic> json) =>
      _$ApprovalListResFromJson(json);

  Map<String, dynamic> toJson() => _$ApprovalListResToJson(this);
}
