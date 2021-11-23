import 'package:json_annotation/json_annotation.dart';

part 'store_account_method_update_model_req.g.dart';

@JsonSerializable()
class StoreAccountMethodUpdateReq {
  String accountId;
  String transferMethodCode;

  String? accountName;
  String? holderName;
  String? accountNo;
  String? depositBank;
  @override
  StoreAccountMethodUpdateReq({
    required this.accountId,
    required this.transferMethodCode,
    this.depositBank,
    this.holderName,
    this.accountNo,
    this.accountName,
  });

  factory StoreAccountMethodUpdateReq.fromJson(Map<String, dynamic> json) =>
      _$StoreAccountMethodUpdateReqFromJson(json);

  Map<String, dynamic> toJson() => _$StoreAccountMethodUpdateReqToJson(this);
}
