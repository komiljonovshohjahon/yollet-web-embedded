import 'package:json_annotation/json_annotation.dart';

part 'approval_list_model_req.g.dart';

@JsonSerializable()
class ApprovalListReq {
  String? businessRegistrationNo;
  String? paymentMethodCode;
  String? startDate;
  String? endDate;
  String? transactionType;
  String? approvalNo;
  double? approvalAmount;
  int? pageNo;
  int? pageSize;
  @override
  ApprovalListReq({
    this.businessRegistrationNo,
    this.paymentMethodCode,
    this.startDate,
    this.endDate,
    this.transactionType,
    this.approvalNo,
    this.approvalAmount,
    this.pageNo,
    this.pageSize,
  });

  factory ApprovalListReq.fromJson(Map<String, dynamic> json) =>
      _$ApprovalListReqFromJson(json);

  Map<String, dynamic> toJson() => _$ApprovalListReqToJson(this);
}
