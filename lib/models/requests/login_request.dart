import 'package:json_annotation/json_annotation.dart';

import '../../utils/enums.dart';
import 'base_request.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest extends BaseRequest {
  final String email;
  final String password;
  final UserType role;

  const LoginRequest({
    required this.email,
    required this.password,
    required this.role,
  });

  @override
  Map<String, dynamic> toJson() {
    return _$LoginRequestToJson(this);
  }
}
