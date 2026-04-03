part of 'locator.dart';

class AuthService {
  AuthService._();

  Future<User?> login({required LoginRequest request}) async {
    final response = await locator<AuthApi>().login(request);
    if (!(response.success ?? false)) {
      throw AppException(response.message ?? 'Something went wrong!');
    }
    if (response.data?.token == null) {
      throw const AppException('Something went wrong!');
    }
    await locator<StorageService>().saveAccessToken(response.data?.token);
    await locator<StorageService>().saveUser(response.data?.user);
    return response.data?.user;
  }
}
