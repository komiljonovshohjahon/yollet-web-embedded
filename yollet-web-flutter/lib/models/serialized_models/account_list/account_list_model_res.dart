import 'package:json_annotation/json_annotation.dart';

part 'account_list_model_res.g.dart';

@JsonSerializable()
class StoreAccountListRes {
  final List? accountList;

  StoreAccountListRes({
    this.accountList,
  });

  factory StoreAccountListRes.fromJson(Map<String, dynamic> json) =>
      _$StoreAccountListResFromJson(json);

  Map<String, dynamic> toJson() => _$StoreAccountListResToJson(this);
}
