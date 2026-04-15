import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import '../api/api_constants.dart';
import '../api/auth_api.dart';
import '../api/project_api.dart';
import '../exceptions/app_exception.dart';
import '../models/requests/email_request.dart';
import '../models/requests/login_request.dart';
import '../models/requests/reset_password_request.dart';
import '../models/requests/verify_otp_request.dart';
import '../models/responses/base_response.dart';
import '../models/responses/get_me_response.dart';
import '../models/responses/project_list_response.dart';
import '../models/responses/user_history_response.dart';

part 'auth_service.dart';
part 'project_service.dart';
part 'storage_service.dart';

final locator = GetIt.instance;

Future<void> initializeServices() async {
  await locator.reset();
  final dio = Dio();
  dio.options = BaseOptions(
    validateStatus: (_) => true,
    baseUrl: ApiConstants.baseUrl,
  );
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = await locator<StorageService>().getAccessToken();
        log('ACCESS TOKEN: $accessToken');
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        log('URL: ${options.uri}');
        log('REQUEST: ${options.data}');
        handler.next(options);
      },
      onResponse: (response, handler) {
        log('RESPONSE: ${response.data}');
        handler.next(response);
      },
    ),
  );

  // APIS
  locator..registerLazySingleton(() => AuthApi(dio));
  locator..registerLazySingleton(() => ProjectApi(dio));

  // Services
  locator
    ..registerLazySingleton(() => StorageService._())
    ..registerLazySingleton(() => AuthService._())
    ..registerLazySingleton(() => ProjectService._());
}
