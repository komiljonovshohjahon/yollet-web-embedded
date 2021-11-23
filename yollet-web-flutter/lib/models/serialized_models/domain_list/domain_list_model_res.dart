import 'package:json_annotation/json_annotation.dart';
part 'domain_list_model_res.g.dart';

@JsonSerializable()
class DomainListRes {
  final List? domainList;

  DomainListRes({
    this.domainList,
  });

  factory DomainListRes.fromJson(Map<String, dynamic> json) =>
      _$DomainListResFromJson(json);

  Map<String, dynamic> toJson() => _$DomainListResToJson(this);
}
