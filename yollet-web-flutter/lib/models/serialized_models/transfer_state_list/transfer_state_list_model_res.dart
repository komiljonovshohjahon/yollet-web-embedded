import 'package:json_annotation/json_annotation.dart';

part 'transfer_state_list_model_res.g.dart';

@JsonSerializable()
class TransferStateListRes {
  final List? stateList;

  TransferStateListRes({
    this.stateList,
  });

  factory TransferStateListRes.fromJson(Map<String, dynamic> json) =>
      _$TransferStateListResFromJson(json);

  Map<String, dynamic> toJson() => _$TransferStateListResToJson(this);
}
