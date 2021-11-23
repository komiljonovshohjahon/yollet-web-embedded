import 'package:json_annotation/json_annotation.dart';
part 'transfer_method_list_global_model_res.g.dart';

@JsonSerializable()
class TransferMethodGlobalListRes {
  List? transferMethodList;

  TransferMethodGlobalListRes({
    this.transferMethodList,
  });

  factory TransferMethodGlobalListRes.fromJson(Map<String, dynamic> json) =>
      _$TransferMethodGlobalListResFromJson(json);

  Map<String, dynamic> toJson() => _$TransferMethodGlobalListResToJson(this);
}
