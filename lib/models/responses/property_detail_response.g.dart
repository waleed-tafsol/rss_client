// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyDetailResponse _$PropertyDetailResponseFromJson(
  Map<String, dynamic> json,
) => PropertyDetailResponse(
  success: json['success'] as bool?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : Data.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PropertyDetailResponseToJson(
  PropertyDetailResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  property: json['property'] == null
      ? null
      : PropertyData.fromJson(json['property'] as Map<String, dynamic>),
  inspectionData: (json['inspection_data'] as List<dynamic>?)
      ?.map((e) => InspectionDatum.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'property': instance.property,
  'inspection_data': instance.inspectionData,
};

PropertyData _$PropertyDataFromJson(Map<String, dynamic> json) => PropertyData(
  id: (json['id'] as num?)?.toInt(),
  uid: json['uid'] as String?,
  projectId: (json['project_id'] as num?)?.toInt(),
  uprn: json['uprn'] as String?,
  postCode: json['post_code'] as String?,
  town: json['town'] as String?,
  yearBuild: (json['year_build'] as num?)?.toInt(),
  propertyType: (json['property_type'] as num?)?.toInt(),
  address: json['address'] as String?,
  clientId: (json['client_id'] as num?)?.toInt(),
  surveyorId: json['surveyor_id'] as String?,
  status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  slot: json['slot'] as String?,
  inspectionDate: json['inspection_date'] as String?,
  clientName: json['client_name'] as String?,
  surveyorName: json['surveyor_name'] as String?,
  getTenant: json['get_tenant'] == null
      ? null
      : Client.fromJson(json['get_tenant'] as Map<String, dynamic>),
  surveyor: json['surveyor'] == null
      ? null
      : Client.fromJson(json['surveyor'] as Map<String, dynamic>),
  getType: json['get_type'] == null
      ? null
      : GetType.fromJson(json['get_type'] as Map<String, dynamic>),
  client: json['client'] == null
      ? null
      : Client.fromJson(json['client'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PropertyDataToJson(PropertyData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'project_id': instance.projectId,
      'uprn': instance.uprn,
      'post_code': instance.postCode,
      'town': instance.town,
      'year_build': instance.yearBuild,
      'property_type': instance.propertyType,
      'address': instance.address,
      'client_id': instance.clientId,
      'surveyor_id': instance.surveyorId,
      'status': _$StatusEnumMap[instance.status],
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'slot': instance.slot,
      'inspection_date': instance.inspectionDate,
      'client_name': instance.clientName,
      'surveyor_name': instance.surveyorName,
      'get_tenant': instance.getTenant,
      'surveyor': instance.surveyor,
      'get_type': instance.getType,
      'client': instance.client,
    };

const _$StatusEnumMap = {
  Status.inprogress: 'inprogress',
  Status.upcoming: 'upcoming',
  Status.completed: 'completed',
};

InspectionDatum _$InspectionDatumFromJson(Map<String, dynamic> json) =>
    InspectionDatum(
      id: (json['id'] as num?)?.toInt(),
      sectionName: json['section_name'] as String?,
      subCategories: (json['sub_categories'] as List<dynamic>?)
          ?.map((e) => SubCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InspectionDatumToJson(InspectionDatum instance) =>
    <String, dynamic>{
      'id': instance.id,
      'section_name': instance.sectionName,
      'sub_categories': instance.subCategories,
    };

SubCategory _$SubCategoryFromJson(Map<String, dynamic> json) => SubCategory(
  id: (json['id'] as num?)?.toInt(),
  subSectionName: json['sub_section_name'] as String?,
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SubCategoryToJson(SubCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sub_section_name': instance.subSectionName,
      'items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) =>
    Item(id: (json['id'] as num?)?.toInt(), name: json['name'] as String?);

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
  id: (json['id'] as num?)?.toInt(),
  uid: json['uid'] as String?,
  name: json['name'] as String?,
  email: json['email'] as String?,
  status: (json['status'] as num?)?.toInt(),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  profile: json['profile'] == null
      ? null
      : Profile.fromJson(json['profile'] as Map<String, dynamic>),
  propertyId: (json['property_id'] as num?)?.toInt(),
  phoneNumber: json['phone_number'] as String?,
);

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
  'id': instance.id,
  'uid': instance.uid,
  'name': instance.name,
  'email': instance.email,
  'status': instance.status,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'profile': instance.profile,
  'property_id': instance.propertyId,
  'phone_number': instance.phoneNumber,
};

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
  id: (json['id'] as num?)?.toInt(),
  userId: (json['user_id'] as num?)?.toInt(),
  dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
  contactNumber: json['contact_number'] as String?,
  address: json['address'] as String?,
  profileImage: json['profile_image'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'dob': instance.dob?.toIso8601String(),
  'contact_number': instance.contactNumber,
  'address': instance.address,
  'profile_image': instance.profileImage,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};

GetType _$GetTypeFromJson(Map<String, dynamic> json) => GetType(
  id: (json['id'] as num?)?.toInt(),
  uid: json['uid'] as String?,
  name: json['name'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$GetTypeToJson(GetType instance) => <String, dynamic>{
  'id': instance.id,
  'uid': instance.uid,
  'name': instance.name,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};
