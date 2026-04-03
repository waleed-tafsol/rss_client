import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  final bool? success;
  final String? message;

  const BaseResponse({this.success, this.message});

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  @mustBeOverridden
  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
