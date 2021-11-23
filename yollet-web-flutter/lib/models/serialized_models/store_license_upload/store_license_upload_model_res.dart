import 'package:json_annotation/json_annotation.dart';

part 'store_license_upload_model_res.g.dart';

@JsonSerializable()
class StoreLicenseUploadRes {
  final String? licenseUrl;
  StoreLicenseUploadRes({
    this.licenseUrl,
  });

  factory StoreLicenseUploadRes.fromJson(Map<String, dynamic> json) =>
      _$StoreLicenseUploadResFromJson(json);

  Map<String, dynamic> toJson() => _$StoreLicenseUploadResToJson(this);
}
