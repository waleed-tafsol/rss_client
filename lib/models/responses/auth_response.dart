import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';
import 'get_me_response.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse extends BaseResponse {
  final AuthData? data;
  const AuthResponse({super.success, super.message, this.data});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

@JsonSerializable()
class AuthData {
  final String? token;
  final User? user;

  AuthData({this.token, this.user});

  factory AuthData.fromJson(Map<String, dynamic> json) =>
      _$AuthDataFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDataToJson(this);
}
