import 'package:json_annotation/json_annotation.dart';

part 'agency_list_model_res.g.dart';

@JsonSerializable()
class AgencyListRes {
  final List? agencyList;
  AgencyListRes({
    this.agencyList,
  });

  factory AgencyListRes.fromJson(Map<String, dynamic> json) =>
      _$AgencyListResFromJson(json);

  Map<String, dynamic> toJson() => _$AgencyListResToJson(this);
}
