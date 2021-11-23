import 'package:json_annotation/json_annotation.dart';

part 'distributor_list_model_res.g.dart';

@JsonSerializable()
class DistributorListRes {
  final List? distributorList;
  DistributorListRes({
    this.distributorList,
  });

  factory DistributorListRes.fromJson(Map<String, dynamic> json) =>
      _$DistributorListResFromJson(json);

  Map<String, dynamic> toJson() => _$DistributorListResToJson(this);
}
