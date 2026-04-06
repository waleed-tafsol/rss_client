// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
  success: json['success'] as bool?,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : AuthData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

AuthData _$AuthDataFromJson(Map<String, dynamic> json) => AuthData(
  token: json['token'] as String?,
  user: json['user'] == null
      ? null
      : User.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthDataToJson(AuthData instance) => <String, dynamic>{
  'token': instance.token,
  'user': instance.user,
};

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  email: json['email'] as String?,
  emailVerifiedAt: json['email_verified_at'] == null
      ? null
      : DateTime.parse(json['email_verified_at'] as String),
  status: (json['status'] as num?)?.toInt(),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  profile: json['profile'],
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'email_verified_at': instance.emailVerifiedAt?.toIso8601String(),
  'status': instance.status,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'profile': instance.profile,
};
