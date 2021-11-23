import 'package:json_annotation/json_annotation.dart';

part 'auth_model_req.g.dart';

@JsonSerializable()
class AuthReq {
  String id;
  String password;
  String domain;

  @override
  AuthReq({
    required this.id,
    required this.password,
    required this.domain,
  });

  factory AuthReq.fromJson(Map<String, dynamic> json) =>
      _$AuthReqFromJson(json);

  Map<String, dynamic> toJson() => _$AuthReqToJson(this);
}
