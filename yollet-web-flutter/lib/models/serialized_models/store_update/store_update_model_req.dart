import 'package:json_annotation/json_annotation.dart';

part 'store_update_model_req.g.dart';

@JsonSerializable()
class StoreUpdateReq {
  String storeId;
  String? storeName;
  String? ownerName;
  String password;
  String? newPassword;
  String? businessRegistrationNo;
  String? telNo;
  String? primaryAddress;
  String? detailAddress;

  @override
  StoreUpdateReq({
    required this.storeId,
    this.storeName,
    this.ownerName,
    required this.password,
    this.newPassword,
    this.businessRegistrationNo,
    this.telNo,
    this.primaryAddress,
    this.detailAddress,
  });

  factory StoreUpdateReq.fromJson(Map<String, dynamic> json) =>
      _$StoreUpdateReqFromJson(json);

  Map<String, dynamic> toJson() => _$StoreUpdateReqToJson(this);
}
