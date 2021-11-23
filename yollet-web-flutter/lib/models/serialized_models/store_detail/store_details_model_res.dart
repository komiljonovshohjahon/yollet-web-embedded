import 'package:json_annotation/json_annotation.dart';

part 'store_details_model_res.g.dart';

@JsonSerializable()
class StoreDetailsRes {
  final String? storeName;
  final String? businessRegistrationNo;
  final String? ownerName;
  final String? licenseUrl;
  final String? loginId;
  final String? telNo;
  final String? primaryAddress;
  final String? detailAddress;

  StoreDetailsRes({
    this.storeName,
    this.ownerName,
    this.businessRegistrationNo,
    this.telNo,
    this.primaryAddress,
    this.loginId,
    this.licenseUrl,
    this.detailAddress,
  });

  factory StoreDetailsRes.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailsResFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDetailsResToJson(this);
}
