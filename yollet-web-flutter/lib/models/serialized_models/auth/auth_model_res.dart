import 'package:json_annotation/json_annotation.dart';

part 'auth_model_res.g.dart';

@JsonSerializable()
class AuthRes {
  String? token;

  @override
  AuthRes({
    this.token,
  });

  factory AuthRes.fromJson(Map<String, dynamic> json) =>
      _$AuthResFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResToJson(this);
}
