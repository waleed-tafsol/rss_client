import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../exceptions/app_exception.dart';
import '../../models/requests/login_request.dart';
import '../../models/responses/auth_response.dart';
import '../../services/locator.dart';
import '../../utils/enums.dart';
import 'base_view_model.dart';

class AuthViewModel extends BaseViewModel {
  bool _loading = false;
  User? _user;
  AuthView? _authView = AuthView.login;
  String? _resetToken;

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

  Future<void> logout() async {
    return await runSafely(() async {
      EasyLoading.show(status: 'Logging out...');
      await locator<AuthService>().logout();
      _user = null;
      notifyListeners();
      EasyLoading.dismiss();
    });
  }

  Future<void> forgotPassword({required String email}) async {
    return await runSafely(() async {
      setLoading(true);
      await locator<AuthService>().forgotPassword(email: email);
      _loading = false;
      _authView = AuthView.otp;
      notifyListeners();
    });
  }

  Future<void> verifyOtp({required String email, required String otp}) async {
    return await runSafely(() async {
      setLoading(true);
      final resetToken = await locator<AuthService>().verifyOtp(
        email: email,
        otp: otp,
      );
      _authView = AuthView.otp;
      _loading = false;
      _resetToken = resetToken;
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
