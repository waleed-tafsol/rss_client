import 'package:json_annotation/json_annotation.dart';
import 'base_response.dart';

part 'project_list_response.g.dart';

@JsonSerializable()
class ProjectListResponse extends BaseResponse {
  final List<Project>? data;
  final int? currentPage;
  final int? totalPages;
  final int? totalItems;
  final int? perPage;

  const ProjectListResponse({
    super.success,
    super.message,
    this.data,
    this.currentPage,
    this.totalPages,
    this.totalItems,
    this.perPage,
  });

  factory ProjectListResponse.fromJson(Map<String, dynamic> json) =>
      _$ProjectListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProjectListResponseToJson(this);
}

@JsonSerializable()
class Project {
  final int? id;
  final String? uid;
  final String? name;
  final int? userId;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Project({
    this.id,
    this.uid,
    this.name,
    this.userId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
