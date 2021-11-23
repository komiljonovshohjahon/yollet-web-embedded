import 'package:json_annotation/json_annotation.dart';

part 'common_message_model_res.g.dart';

@JsonSerializable()
class CommonMessageRes {
  String? targetSvc;
  String? targetPackage;
  String? targetApi;
  String? sourceSvc;
  String? sourceVer;
  String? sourceAddr;
  String? reqTimestamp;
  String? tranNo;
  String? resTimestamp;
  String? resCode;
  String? resMessage;

  CommonMessageRes({
    this.targetSvc,
    this.targetPackage,
    this.targetApi,
    this.sourceSvc,
    this.sourceVer,
    this.sourceAddr,
    this.reqTimestamp,
    this.tranNo,
    this.resTimestamp,
    this.resCode,
    this.resMessage,
  });

  factory CommonMessageRes.fromJson(Map<String, dynamic> json) =>
      _$CommonMessageResFromJson(json);

  Map<String, dynamic> toJson() => _$CommonMessageResToJson(this);
}
