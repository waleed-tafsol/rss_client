import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';

part 'verify_otp_response.g.dart';

@JsonSerializable()
class VerifyOtpResponse extends BaseResponse {
  final VerifyOtpData data;

  const VerifyOtpResponse({
    required this.data,
    required super.success,
    required super.message,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return _$VerifyOtpResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$VerifyOtpResponseToJson(this);
  }
}

@JsonSerializable()
class VerifyOtpData {
  final String resetToken;

  const VerifyOtpData({required this.resetToken});

  factory VerifyOtpData.fromJson(Map<String, dynamic> json) {
    return _$VerifyOtpDataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VerifyOtpDataToJson(this);
  }
}
