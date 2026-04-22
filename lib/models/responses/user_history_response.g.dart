// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserHistoryResponse _$UserHistoryResponseFromJson(Map<String, dynamic> json) =>
    UserHistoryResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => HistoryData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserHistoryResponseToJson(
  UserHistoryResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

HistoryData _$HistoryDataFromJson(Map<String, dynamic> json) => HistoryData(
  id: (json['id'] as num?)?.toInt(),
  uid: json['uid'] as String?,
  name: json['name'] as String?,
  userId: (json['user_id'] as num?)?.toInt(),
  status: (json['status'] as num?)?.toInt(),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  propertiesCount: (json['properties_count'] as num?)?.toInt(),
  totalInspections: (json['total_inspections'] as num?)?.toInt(),
  inprogressInspections: (json['inprogress_inspections'] as num?)?.toInt(),
  properties: (json['properties'] as List<dynamic>?)
      ?.map((e) => Property.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$HistoryDataToJson(HistoryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'name': instance.name,
      'user_id': instance.userId,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'properties_count': instance.propertiesCount,
      'total_inspections': instance.totalInspections,
      'inprogress_inspections': instance.inprogressInspections,
      'properties': instance.properties,
    };

Property _$PropertyFromJson(Map<String, dynamic> json) => Property(
  id: (json['id'] as num?)?.toInt(),
  uprn: json['uprn'] as String?,
  address: json['address'] as String?,
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  tenantId: (json['tenant_id'] as num?)?.toInt(),
  surveyorId: (json['surveyor_id'] as num?)?.toInt(),
  checklistDetails: json['checklist_details'] as List<dynamic>?,
  tenantName: json['tenant_name'] as String?,
  surveyorName: json['surveyor_name'] as String?,
  clientName: json['client_name'] as String?,
);

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
  'id': instance.id,
  'uprn': instance.uprn,
  'address': instance.address,
  'client_name': instance.clientName,
  'date': instance.date?.toIso8601String(),
  'tenant_id': instance.tenantId,
  'surveyor_id': instance.surveyorId,
  'checklist_details': instance.checklistDetails,
  'tenant_name': instance.tenantName,
  'surveyor_name': instance.surveyorName,
};
