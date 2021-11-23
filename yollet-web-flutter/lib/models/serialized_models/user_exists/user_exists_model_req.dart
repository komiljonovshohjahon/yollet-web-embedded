import 'package:json_annotation/json_annotation.dart';

part 'user_exists_model_req.g.dart';

@JsonSerializable()
class UserExistsReq {
  final String id;
  UserExistsReq({
    required this.id,
  });

  factory UserExistsReq.fromJson(Map<String, dynamic> json) =>
      _$UserExistsReqFromJson(json);

  Map<String, dynamic> toJson() => _$UserExistsReqToJson(this);
}
