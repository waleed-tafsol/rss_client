import 'base_response.dart';

class UserHistoryResponse extends BaseResponse {
  final List<HistoryData>? data;
  UserHistoryResponse({super.success, super.message, this.data});

  factory UserHistoryResponse.fromJson(Map<String, dynamic> json) =>
      UserHistoryResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<HistoryData>.from(
                json["data"]!.map((x) => HistoryData.fromJson(x)),
              ),
      );
      
        @override
        Map<String, dynamic> toJson() {
          throw UnimplementedError();
        }
}

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

  factory HistoryData.fromJson(Map<String, dynamic> json) => HistoryData(
    id: json["id"],
    uid: json["uid"],
    name: json["name"],
    userId: json["user_id"],
    status: json["status"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    propertiesCount: json["properties_count"],
    totalInspections: json["total_inspections"],
    inprogressInspections: json["inprogress_inspections"],
    properties: json["properties"] == null
        ? []
        : List<Property>.from(
            json["properties"]!.map((x) => Property.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uid": uid,
    "name": name,
    "user_id": userId,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "properties_count": propertiesCount,
    "total_inspections": totalInspections,
    "inprogress_inspections": inprogressInspections,
    "properties": properties == null
        ? []
        : List<dynamic>.from(properties!.map((x) => x.toJson())),
  };
}

class Property {
  final int? id;
  final String? uprn;
  final String? address1;
  final DateTime? date;
  final int? tenantId;
  final int? surveyorId;
  final List<dynamic>? checklistDetails;
  final String? tenantName;
  final String? surveyorName;

  Property({
    this.id,
    this.uprn,
    this.address1,
    this.date,
    this.tenantId,
    this.surveyorId,
    this.checklistDetails,
    this.tenantName,
    this.surveyorName,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
    id: json["id"],
    uprn: json["uprn"],
    address1: json["address_1"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    tenantId: json["tenant_id"],
    surveyorId: json["surveyor_id"],
    checklistDetails: json["checklist_details"] == null
        ? []
        : List<dynamic>.from(json["checklist_details"]!.map((x) => x)),
    tenantName: json["tenant_name"],
    surveyorName: json["surveyor_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uprn": uprn,
    "address_1": address1,
    "date": date?.toIso8601String(),
    "tenant_id": tenantId,
    "surveyor_id": surveyorId,
    "checklist_details": checklistDetails == null
        ? []
        : List<dynamic>.from(checklistDetails!.map((x) => x)),
    "tenant_name": tenantName,
    "surveyor_name": surveyorName,
  };
}
