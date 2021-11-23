import 'package:json_annotation/json_annotation.dart';

part 'agency_list_model_req.g.dart';

@JsonSerializable()
class AgencyListReq {
  final String distributorId;
  AgencyListReq({
    required this.distributorId,
  });

  factory AgencyListReq.fromJson(Map<String, dynamic> json) =>
      _$AgencyListReqFromJson(json);

  Map<String, dynamic> toJson() => _$AgencyListReqToJson(this);
}
