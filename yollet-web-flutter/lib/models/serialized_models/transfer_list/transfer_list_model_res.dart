import 'package:json_annotation/json_annotation.dart';

part 'transfer_list_model_res.g.dart';

@JsonSerializable()
class TransferListRes {
  final int? pageNo;
  final int? pageTotal;
  final int? pageSize;
  final int? itemCount;
  final double? amountSum;
  final List? transferList;

  TransferListRes({
    this.pageNo,
    this.pageTotal,
    this.pageSize,
    this.itemCount,
    this.amountSum,
    this.transferList,
  });

  factory TransferListRes.fromJson(Map<String, dynamic> json) =>
      _$TransferListResFromJson(json);

  Map<String, dynamic> toJson() => _$TransferListResToJson(this);
}
