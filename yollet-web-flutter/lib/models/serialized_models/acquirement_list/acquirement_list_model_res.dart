import 'package:json_annotation/json_annotation.dart';

part 'acquirement_list_model_res.g.dart';

@JsonSerializable()
class AcquirementListRes {
  final String? transactionId;
  final String? businessRegistrationNo;
  final String? paymentMethodCode;
  final String? paymentMethodName;
  final String? approvalDatetime;
  final String? transactionType;
  final String? acquirerName;
  final String? cardNo;
  final String? approvalNo;
  final String? requestDatetime;
  final String? doneDatetime;
  final String? acquirementState;
  final double? approvalAmount;

  final int? pageNo;
  final int? pageTotal;
  final int? pageSize;
  final int? itemCount;
  final double? amountSum;
  final List? acquirementList;

  AcquirementListRes({
    this.pageNo,
    this.pageSize,
    this.pageTotal,
    this.itemCount,
    this.amountSum,
    this.acquirementList,
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
    this.requestDatetime,
    this.doneDatetime,
    this.acquirementState,
  });

  factory AcquirementListRes.fromJson(Map<String, dynamic> json) =>
      _$AcquirementListResFromJson(json);

  Map<String, dynamic> toJson() => _$AcquirementListResToJson(this);
}
