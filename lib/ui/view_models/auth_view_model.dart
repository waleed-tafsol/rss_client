import 'dart:async';
import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../../exceptions/app_exception.dart';
import '../../models/requests/login_request.dart';
import '../../models/responses/get_me_response.dart';
import '../../services/locator.dart';
import '../../utils/enums.dart';
import 'base_view_model.dart';

class AuthViewModel extends BaseViewModel {
  AuthViewModel() {
    _hydrate();
  }

  Future<void> _hydrate() async {
    final savedAuth = await locator<StorageService>().getUser();
    if (savedAuth != null) {
      _user = savedAuth;
      notifyListeners();
    }
  }

  bool _loading = false;
  User? _user;
  AuthView? _authView = AuthView.login;
  String? _resetToken;
  XFile? profileImage;

  // Getters
  bool get loading => _loading;
  User? get user => _user;
  AuthView? get authView => _authView;
  String? get resetToken => _resetToken;

  bool get isLoggedIn => _user != null;
  bool get isLoginView => _authView == AuthView.login;
  bool get isForgotPasswordView => _authView == AuthView.forgotPassword;
  bool get isOtpView => _authView == AuthView.otp;
  bool get isResetPasswordView => _authView == AuthView.resetPassword;

  // Convenience Getters
  String get userName => _user?.name ?? 'N/A';
  String get userEmail => _user?.email ?? 'N/A';

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  void setAuthView(AuthView view) {
    _authView = view;
    notifyListeners();
  }

  void setResetToken(String? token) {
    _resetToken = token;
    notifyListeners();
  }

  void updateProfileImage(XFile? imageBytes) {
    profileImage = imageBytes;
    notifyListeners();
  }

  CountryCode? country = CountryCode.tryFromCountryCode('GB');

  void setCountry(CountryCode value) {
    country = value;
    log("Country === ${country?.dialCode}");
    notifyListeners();
  }

  Timer? _otpTimer;
  int _remainingTime = 120;
  bool _isResendButtonEnabled = true;
  bool get getIsResendButtonEnabled => _isResendButtonEnabled;
  String get formattedTime {
    log('_remainingTime: $_remainingTime'); // Debug print

    if (_remainingTime.isNaN || _remainingTime <= 0) {
      return "00:00s";
    }

    final minutes = (_remainingTime / 60).toInt();
    final seconds = (_remainingTime % 60).toInt();
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}s";
  }

  void startOtpTimer() {
    _remainingTime = 120;
    _isResendButtonEnabled = false;
    notifyListeners();
    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        notifyListeners();
      } else {
        _otpTimer?.cancel();
        _isResendButtonEnabled = true;
        notifyListeners();
      }
    });
  }

  Future<void> login({required String email, required String password}) async {
    return await runSafely(() async {
      setLoading(true);

      final user = await locator<AuthService>().login(
        request: LoginRequest(
          email: email,
          password: password,
          role: UserType.client,
        ),
      );
      _loading = false;
      _user = user;
      notifyListeners();
    });
  }

  Future<void> checkAuthentication() async {
    return await runSafely(() async {
      final user = await locator<StorageService>().getUser();
      _user = user;
      _loading = false;
      notifyListeners();
    });
  }

  Future<bool?> logout() async {
    return await runSafely(() async {
      EasyLoading.show(status: 'Logging out...');
      await locator<AuthService>().logout();
      _user = null;
      notifyListeners();
      EasyLoading.dismiss();
      return true;
    });
  }

  Future<void> forgotPassword({
    required String email,
    required bool showEasyLoading,
  }) async {
    return await runSafely(() async {
      if (showEasyLoading) {
        EasyLoading.show(status: 'Resending OTP...');
      } else {
        _loading = true;
      }
      notifyListeners();
      final response = await locator<AuthService>().forgotPassword(
        email: email,
      );
      if (showEasyLoading) {
        EasyLoading.showSuccess(response.message ?? 'OTP resent successfully');
      } else {
        _loading = false;
      }

      _authView = AuthView.otp;
      startOtpTimer();
      notifyListeners();
    });
  }

  Future<bool?> getMe() async {
    return await runSafely(() async {
      final user = await locator<AuthService>().getMe();
      if (user.data != null) {
        _user = user.data;
      }
      return true;
    });
  }

  Future<bool?> updateProfile({String? name, String? phone,String? newPassword,String? currentPassword, String? confirmPassword}) async {
    return await runSafely(() async {
      setLoading(true);
      final response = await locator<AuthService>().updateUser(
        name: name,
        phone: phone,
        file: profileImage,
        newPassword: newPassword,
        currentPassword: currentPassword,
        confirmPassword: confirmPassword,
      );
      await getMe();
      _loading = false;
      profileImage = null;
      notifyListeners();
      EasyLoading.showSuccess(response.message ?? 'Profile updated!');
      return true;
    });
  }

  Future<void> verifyOtp({required String email, required String otp}) async {
    return await runSafely(() async {
      setLoading(true);
      final resetToken = await locator<AuthService>().verifyOtp(
        email: email,
        otp: otp,
      );
      _authView = AuthView.resetPassword;
      _loading = false;
      _resetToken = resetToken;
      _otpTimer?.cancel();
      EasyLoading.showSuccess('Email verified!');
      notifyListeners();
    });
  }

  Future<void> resetPassword({
    required String password,
    required String passwordConfirmation,
  }) async {
    return await runSafely(() async {
      if (_resetToken == null) {
        throw const AppException(
          'Resend token not found, please send otp again!',
        );
      }
      setLoading(true);
      await locator<AuthService>().resetPassword(
        resetToken: _resetToken ?? "",
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      _loading = false;
      _authView = AuthView.login;
      _resetToken = null;
      EasyLoading.showSuccess('Password reset successfully!');
      notifyListeners();
    });
  }

  @override
  void handleError(String message) {
    _loading = false;
    EasyLoading.dismiss();
    super.handleError(message);
    notifyListeners();
  }
}
