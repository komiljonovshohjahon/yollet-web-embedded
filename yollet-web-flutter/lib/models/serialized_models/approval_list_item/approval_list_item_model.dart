import 'package:json_annotation/json_annotation.dart';

part 'approval_list_item_model.g.dart';

@JsonSerializable()
class ApprovalListItemModel {
  final String? transactionId;
  final String? businessRegistrationNo;
  final String? paymentMethodCode;
  final String? paymentMethodName;
  final String? approvalDatetime;
  final String? transactionType;
  final String? acquirerName;
  final String? cardNo;
  final String? approvalNo;
  final double? approvalAmount;
  final String? resultCode;

  ApprovalListItemModel({
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

  factory ApprovalListItemModel.fromJson(Map<String, dynamic> json) =>
      _$ApprovalListItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApprovalListItemModelToJson(this);
}
