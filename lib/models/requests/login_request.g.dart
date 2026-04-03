// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'role': _$UserTypeEnumMap[instance.role]!,
    };

const _$UserTypeEnumMap = {
  UserType.client: 'client',
  UserType.surveyor: 'surveyor',
  UserType.admin: 'admin',
};
