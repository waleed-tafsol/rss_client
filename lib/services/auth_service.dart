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

  Future<GetMeResponse> getMe() async {
    final response = await locator<AuthApi>().getMe();

    if (!response.success!) {
      throw const AppException('Something went wrong!');
    }
    await locator<StorageService>().saveUser(response.data);
    return response;
  }

  Future<void> logout() async {
    final response = await locator<AuthApi>().logout();
    if (!(response.success ?? false)) {
      throw AppException(response.message ?? 'Something went wrong!');
    }
    await locator<StorageService>().clear();
  }

  Future<BaseResponse> forgotPassword({required String email}) async {
    final response = await locator<AuthApi>().forgotPassword(
      EmailRequest(email: email),
    );
    if (!(response.success ?? false)) {
      throw AppException(response.message ?? 'Something went wrong!');
    }
    return response;
  }

  Future<String?> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final response = await locator<AuthApi>().verifyOtp(
      VerifyOtpRequest(email: email, otp: otp),
    );
    if (!(response.success ?? false)) {
      throw AppException(response.message ?? 'Something went wrong!');
    }
    return response!.data!.resetToken;
  }

  Future<void> resetPassword({
    required String resetToken,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await locator<AuthApi>().resetPassword(
      ResetPasswordRequest(
        resetToken: resetToken,
        password: password,
        passwordConfirmation: passwordConfirmation,
      ),
    );
    if (!(response.success ?? false)) {
      throw AppException(response.message ?? 'Something went wrong!');
    }
  }

  Future<BaseResponse> updateUser({
    required String? name,
    required String? phone,
    required XFile? file,
    String? newPassword,
    String? currentPassword,
    String? confirmPassword,
  }) async {
    if (file != null) {
      final bytes = await file?.readAsBytes();
      final multipartFile = MultipartFile.fromBytes(
        bytes!,
        filename: 'profile_image',
      );
      final response = await locator<AuthApi>().updateUser(
        name: name,
        contactNumber: phone,
        profileImage: multipartFile,
        currentPassword: currentPassword,
        confirmPassword: confirmPassword,
        password: newPassword,
      );
      if (!(response.success ?? false)) {
        throw AppException(response.message ?? 'Something went wrong!');
      }

      return response;
    } else {
      final response = await locator<AuthApi>().updateUser(
        name: name,
        contactNumber: phone,
        currentPassword: currentPassword,
        confirmPassword: confirmPassword,
        password: newPassword,
      );
      if (!(response.success ?? false)) {
        throw AppException(response.message ?? 'Something went wrong!');
      }

      return response;
    }
  }
}
