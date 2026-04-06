import 'package:json_annotation/json_annotation.dart';

import 'base_request.dart';

part 'email_request.g.dart';

@JsonSerializable()
class EmailRequest extends BaseRequest {
  final String email;

  const EmailRequest({required this.email});

  factory EmailRequest.fromJson(Map<String, dynamic> json) {
    return _$EmailRequestFromJson(json);
  }
  @override
  Map<String, dynamic> toJson() {
    return _$EmailRequestToJson(this);
  }
}
