import 'package:json_annotation/json_annotation.dart';

part 'store_account_method_add_model_req.g.dart';

@JsonSerializable()
class StoreAccountMethodAddReq {
  String storeId;

  String? accountName;
  String? holderName;
  String? accountNo;
  String? depositBank;

  String transferMethodCode;

  @override
  StoreAccountMethodAddReq({
    required this.storeId,
    required this.transferMethodCode,
    this.depositBank,
    this.holderName,
    this.accountNo,
    this.accountName,
  });

  factory StoreAccountMethodAddReq.fromJson(Map<String, dynamic> json) =>
      _$StoreAccountMethodAddReqFromJson(json);

  Map<String, dynamic> toJson() => _$StoreAccountMethodAddReqToJson(this);
}
