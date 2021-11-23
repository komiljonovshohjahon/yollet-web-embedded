import 'package:json_annotation/json_annotation.dart';

part 'bank_list_model_res.g.dart';

@JsonSerializable()
class BankListRes {
  final List? bankList;

  BankListRes({
    this.bankList,
  });

  factory BankListRes.fromJson(Map<String, dynamic> json) =>
      _$BankListResFromJson(json);

  Map<String, dynamic> toJson() => _$BankListResToJson(this);
}
