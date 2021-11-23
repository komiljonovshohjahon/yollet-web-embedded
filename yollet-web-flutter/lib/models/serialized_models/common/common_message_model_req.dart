import 'package:json_annotation/json_annotation.dart';

part 'common_message_model_req.g.dart';

@JsonSerializable()
class CommonMessageReq {
  String? targetSvc;
  String? targetPackage;
  final String targetApi;
  String? sourceSvc;
  String? sourceVer;
  String? sourceAddr;
  final String reqTimestamp;
  String? tranNo;

  CommonMessageReq({
    this.targetSvc = 'admin.yoshop.net',
    this.targetPackage = 'admin.v1',
    required this.targetApi,
    this.sourceSvc = 'YolletAdmin',
    this.sourceVer = '1.0.0',
    this.sourceAddr = '127.0.0.1',
    required this.reqTimestamp,
    this.tranNo = '10716',
  });

  factory CommonMessageReq.fromJson(Map<String, dynamic> json) =>
      _$CommonMessageReqFromJson(json);

  Map<String, dynamic> toJson() => _$CommonMessageReqToJson(this);
}
