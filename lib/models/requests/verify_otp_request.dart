import 'package:json_annotation/json_annotation.dart';

import 'base_request.dart';

part 'verify_otp_request.g.dart';

@JsonSerializable()
class VerifyOtpRequest extends BaseRequest {
  final String email;
  final String otp;
  const VerifyOtpRequest({required this.email, required this.otp});

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) {
    return _$VerifyOtpRequestFromJson(json);
  }
  @override
  Map<String, dynamic> toJson() {
    return _$VerifyOtpRequestToJson(this);
  }
}
