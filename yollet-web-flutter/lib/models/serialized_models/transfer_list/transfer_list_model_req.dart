import 'package:json_annotation/json_annotation.dart';

part 'transfer_list_model_req.g.dart';

@JsonSerializable()
class TransferListReq {
  String? businessRegistrationNo;
  String? paymentMethodCode;
  String? startDate;
  String? endDate;
  String? transferState;
  int? pageNo;
  int? pageSize;
  @override
  TransferListReq({
    this.businessRegistrationNo,
    this.paymentMethodCode,
    this.startDate,
    this.endDate,
    this.transferState,
    this.pageNo,
    this.pageSize,
  });

  factory TransferListReq.fromJson(Map<String, dynamic> json) =>
      _$TransferListReqFromJson(json);

  Map<String, dynamic> toJson() => _$TransferListReqToJson(this);
}
