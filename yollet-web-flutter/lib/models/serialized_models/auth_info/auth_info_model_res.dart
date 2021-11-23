import 'package:json_annotation/json_annotation.dart';

part 'auth_info_model_res.g.dart';

@JsonSerializable()
class AuthInfoRes {
  String? id;
  String? role;
  String? domain;
  String? distributorId;
  String? agencyId;
  String? storeId;

  @override
  AuthInfoRes({
    this.id,
    this.role,
    this.domain,
    this.agencyId,
    this.distributorId,
    this.storeId,
  });

  factory AuthInfoRes.fromJson(Map<String, dynamic> json) =>
      _$AuthInfoResFromJson(json);

  Map<String, dynamic> toJson() => _$AuthInfoResToJson(this);
}
