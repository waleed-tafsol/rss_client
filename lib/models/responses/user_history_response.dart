import 'package:json_annotation/json_annotation.dart';
import 'base_response.dart';

part 'user_history_response.g.dart';

@JsonSerializable()
class UserHistoryResponse extends BaseResponse {
  final List<HistoryData>? data;

  UserHistoryResponse({super.success, super.message, this.data});

  factory UserHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$UserHistoryResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserHistoryResponseToJson(this);
}

@JsonSerializable()
class HistoryData {
  final int? id;
  final String? uid;
  final String? name;
  final int? userId;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? propertiesCount;
  final int? totalInspections;
  final int? inprogressInspections;
  final List<Property>? properties;

  HistoryData({
    this.id,
    this.uid,
    this.name,
    this.userId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.propertiesCount,
    this.totalInspections,
    this.inprogressInspections,
    this.properties,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) =>
      _$HistoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryDataToJson(this);
}

@JsonSerializable()
class Property {
  final int? id;
  final String? uprn;
  final String? address;
  final String? clientName;
  final DateTime? date;
  final int? tenantId;
  final int? surveyorId;
  final List<dynamic>? checklistDetails;
  final String? tenantName;
  final String? surveyorName;

  Property({
    this.id,
    this.uprn,
    this.address,
    this.date,
    this.tenantId,
    this.surveyorId,
    this.checklistDetails,
    this.tenantName,
    this.surveyorName,
    this.clientName
  });

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyToJson(this);
}