import 'package:json_annotation/json_annotation.dart';

part 'store_create_model_req.g.dart';

@JsonSerializable()
class StoreCreateReq {
  String agencyId;
  String? storeName;
  String? ownerName;
  String id;
  String password;
  String? businessRegistrationNo;
  String? telNo;
  String? primaryAddress;
  String? detailAddress;

  @override
  StoreCreateReq({
    required this.agencyId,
    this.storeName,
    this.ownerName,
    required this.id,
    required this.password,
    this.businessRegistrationNo,
    this.telNo,
    this.primaryAddress,
    this.detailAddress,
  });

  factory StoreCreateReq.fromJson(Map<String, dynamic> json) =>
      _$StoreCreateReqFromJson(json);

  Map<String, dynamic> toJson() => _$StoreCreateReqToJson(this);
}
