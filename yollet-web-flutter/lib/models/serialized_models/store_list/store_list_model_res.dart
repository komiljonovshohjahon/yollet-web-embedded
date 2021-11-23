import 'package:json_annotation/json_annotation.dart';

part 'store_list_model_res.g.dart';

@JsonSerializable()
class StoreListRes {
  final int? pageNo;
  final int? pageTotal;
  final int? pageSize;
  final int? itemCount;
  final List? storeList;

  final String? storeId;
  final String? businessRegistrationNo;
  final String? storeName;
  final String? licenseUrl;
  final String? loginId;
  final String? creationTime;
  final String? primaryAddress;
  final String? detailAddress;

  StoreListRes({
    this.storeName,
    this.businessRegistrationNo,
    this.creationTime,
    this.detailAddress,
    this.itemCount,
    this.licenseUrl,
    this.loginId,
    this.pageNo,
    this.pageSize,
    this.pageTotal,
    this.primaryAddress,
    this.storeId,
    this.storeList,
  });

  factory StoreListRes.fromJson(Map<String, dynamic> json) =>
      _$StoreListResFromJson(json);

  Map<String, dynamic> toJson() => _$StoreListResToJson(this);
}
