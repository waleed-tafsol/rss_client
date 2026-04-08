import 'package:json_annotation/json_annotation.dart';
import 'base_response.dart';

part 'get_me_response.g.dart';

@JsonSerializable()
class GetMeResponse extends BaseResponse {
  final User? data;
  const GetMeResponse({super.success, super.message, this.data});

  factory GetMeResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMeResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetMeResponseToJson(this);
}

@JsonSerializable()
class User {
  final int? id;
  final String? uid;
  final String? name;
  final String? email;
  final DateTime? emailVerifiedAt;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Profile? profile;

  const User({
    this.id,
    this.uid,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Profile {
  final int? id;
  final int? userId;
  final String? dob;
  final String? contactNumber;
  final String? address;
  final String? profileImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Profile({
    this.id,
    this.userId,
    this.dob,
    this.contactNumber,
    this.address,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}