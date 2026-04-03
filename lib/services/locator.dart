import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

part 'auth_service.dart';
part 'storage_service.dart';

final locator = GetIt.instance;

Future<void> initializeServices() async {
  await locator.reset();
  locator
    ..registerLazySingleton(() => StorageService._())
    ..registerLazySingleton(() => AuthService._());
}
