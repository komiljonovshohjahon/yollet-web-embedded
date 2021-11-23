import 'package:json_annotation/json_annotation.dart';

part 'acquirement_list_model_req.g.dart';

@JsonSerializable()
class AcquirementListReq {
  String? businessRegistrationNo;
  String? paymentMethodCode;
  String? startDate;
  String? endDate;
  String? acquirementState;
  int? pageNo;
  int? pageSize;
  @override
  AcquirementListReq({
    this.businessRegistrationNo,
    this.paymentMethodCode,
    this.startDate,
    this.endDate,
    this.acquirementState,
    this.pageNo,
    this.pageSize,
  });

  factory AcquirementListReq.fromJson(Map<String, dynamic> json) =>
      _$AcquirementListReqFromJson(json);

  Map<String, dynamic> toJson() => _$AcquirementListReqToJson(this);
}
