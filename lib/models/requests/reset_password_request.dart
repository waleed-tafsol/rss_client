import 'package:json_annotation/json_annotation.dart';

import 'base_request.dart';

part 'reset_password_request.g.dart';

@JsonSerializable()
class ResetPasswordRequest extends BaseRequest {
  final String resetToken;
  final String password;
  final String passwordConfirmation;

  const ResetPasswordRequest({
    required this.resetToken,
    required this.password,
    required this.passwordConfirmation,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) {
    return _$ResetPasswordRequestFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ResetPasswordRequestToJson(this);
  }
}
