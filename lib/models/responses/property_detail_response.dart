import 'package:json_annotation/json_annotation.dart';

import '../../utils/enums.dart';

part 'property_detail_response.g.dart';

@JsonSerializable()
class PropertyDetailResponse {
  @JsonKey(name: "success")
  final bool? success;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "data")
  final Data? data;

  PropertyDetailResponse({this.success, this.message, this.data});

  factory PropertyDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$PropertyDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyDetailResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "property")
  final PropertyData? property;
   @JsonKey(name: "inspection_data")
    final List<InspectionDatum>? inspectionData;

  Data({this.property,
   this.inspectionData,});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class PropertyData {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "uid")
  final String? uid;
  @JsonKey(name: "project_id")
  final int? projectId;
  @JsonKey(name: "uprn")
  final String? uprn;
  @JsonKey(name: "post_code")
  final String? postCode;
  @JsonKey(name: "town")
  final String? town;
  @JsonKey(name: "year_build")
  final int? yearBuild;
  @JsonKey(name: "property_type")
  final int? propertyType;
  @JsonKey(name: "address")
  final String? address;
  @JsonKey(name: "client_id")
  final int? clientId;
  @JsonKey(name: "surveyor_id")
  final String? surveyorId;
  @JsonKey(name: "status")
  final Status? status;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;
  @JsonKey(name: "slot")
  final String? slot;
  @JsonKey(name: "inspection_date")
  final String? inspectionDate;
  @JsonKey(name: "client_name")
  final String? clientName;
  @JsonKey(name: "surveyor_name")
  final String? surveyorName;
  @JsonKey(name: "get_tenant")
  final Client? getTenant;
  @JsonKey(name: "surveyor")
  final Client? surveyor;
  @JsonKey(name: "get_type")
  final GetType? getType;
  @JsonKey(name: "client")
  final Client? client;

  PropertyData({
    this.id,
    this.uid,
    this.projectId,
    this.uprn,
    this.postCode,
    this.town,
    this.yearBuild,
    this.propertyType,
    this.address,
    this.clientId,
    this.surveyorId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.slot,
    this.inspectionDate,
    this.clientName,
    this.surveyorName,
    this.getTenant,
    this.surveyor,
    this.getType,
    this.client,
  });

  factory PropertyData.fromJson(Map<String, dynamic> json) =>
      _$PropertyDataFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyDataToJson(this);
}

@JsonSerializable()
class InspectionDatum {
    @JsonKey(name: "id")
    final int? id;
    @JsonKey(name: "section_name")
    final String? sectionName;
    @JsonKey(name: "sub_categories")
    final List<SubCategory>? subCategories;

    InspectionDatum({
        this.id,
        this.sectionName,
        this.subCategories,
    });

    factory InspectionDatum.fromJson(Map<String, dynamic> json) => _$InspectionDatumFromJson(json);

    Map<String, dynamic> toJson() => _$InspectionDatumToJson(this);
}

@JsonSerializable()
class SubCategory {
    @JsonKey(name: "id")
    final int? id;
    @JsonKey(name: "sub_section_name")
    final String? subSectionName;
    @JsonKey(name: "items")
    final List<Item>? items;

    SubCategory({
        this.id,
        this.subSectionName,
        this.items,
    });

    factory SubCategory.fromJson(Map<String, dynamic> json) => _$SubCategoryFromJson(json);

    Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
}

@JsonSerializable()
class Item {
    @JsonKey(name: "id")
    final int? id;
    @JsonKey(name: "name")
    final String? name;

    Item({
        this.id,
        this.name,
    });

    factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

    Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Client {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "uid")
  final String? uid;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;
  @JsonKey(name: "profile")
  final Profile? profile;
  @JsonKey(name: "property_id")
  final int? propertyId;
  @JsonKey(name: "phone_number")
  final String? phoneNumber;

  Client({
    this.id,
    this.uid,
    this.name,
    this.email,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.profile,
    this.propertyId,
    this.phoneNumber,
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);
}

@JsonSerializable()
class Profile {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "user_id")
  final int? userId;
  @JsonKey(name: "dob")
  final DateTime? dob;
  @JsonKey(name: "contact_number")
  final String? contactNumber;
  @JsonKey(name: "address")
  final String? address;
  @JsonKey(name: "profile_image")
  final String? profileImage;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;

  Profile({
    this.id,
    this.userId,
    this.dob,
    this.contactNumber,
    this.address,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonSerializable()
class GetType {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "uid")
  final String? uid;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "created_at")
  final DateTime? createdAt;
  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;

  GetType({this.id, this.uid, this.name, this.createdAt, this.updatedAt});

  factory GetType.fromJson(Map<String, dynamic> json) =>
      _$GetTypeFromJson(json);

  Map<String, dynamic> toJson() => _$GetTypeToJson(this);
}
