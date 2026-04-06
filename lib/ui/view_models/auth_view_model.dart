import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../exceptions/app_exception.dart';
import '../../models/requests/login_request.dart';
import '../../models/responses/auth_response.dart';
import '../../services/locator.dart';
import '../../utils/enums.dart';
import 'base_view_model.dart';

final authProvider = NotifierProvider(() => AuthViewModel());

class AuthViewModel extends BaseViewModel<AuthState> {
  AuthViewModel() : super(const AuthState());

  Future<void> login({required String email, required String password}) async {
    return await runSafely(() async {
      state = state.copyWith(loading: true);
      final user = await locator<AuthService>().login(
        request: LoginRequest(
          email: email,
          password: password,
          role: UserType.admin,
        ),
      );
      state = state.copyWith(loading: false, user: user);
    });
  }

  Future<void> checkAuthentication() async {
    return await runSafely(() async {
      final user = await locator<StorageService>().getUser();
      state = state.copyWith(loading: false, user: user);
    });
  }

  Future<void> logout() async {
    return await runSafely(() async {
      EasyLoading.show(status: 'Logging out...');
      await locator<AuthService>().logout();
      state = const AuthState();
      EasyLoading.dismiss();
    });
  }

  Future<void> forgotPassword({required String email}) async {
    return await runSafely(() async {
      state = state.copyWith(loading: true);
      await locator<AuthService>().forgotPassword(email: email);
      state = state.copyWith(loading: false, authView: AuthView.otp);
    });
  }

  Future<void> verifyOtp({required String email, required String otp}) async {
    return await runSafely(() async {
      state = state.copyWith(loading: true);
      final resetToken = await locator<AuthService>().verifyOtp(
        email: email,
        otp: otp,
      );
      state = state.copyWith(
        loading: false,
        authView: AuthView.resetPassword,
        resetToken: resetToken,
      );
      EasyLoading.showSuccess('Email verified!');
    });
  }

  Future<void> resetPassword({
    required String password,
    required String passwordConfirmation,
  }) async {
    return await runSafely(() async {
      final resetToken = state.resetToken;
      if (resetToken == null) {
        throw const AppException(
          'Resend token not found, please send otp again!',
        );
      }
      state = state.copyWith(loading: true);
      await locator<AuthService>().resetPassword(
        resetToken: resetToken,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      state = state.copyWith(
        loading: false,
        authView: AuthView.login,
        resetToken: null,
      );
      EasyLoading.showSuccess('Password reset successfully!');
    });
  }

  void changeView(AuthView authView) async {
    state = state.copyWith(authView: authView);
  }

  @override
  void handleError(String message) {
    state = state.copyWith(loading: false);
    EasyLoading.dismiss();
    super.handleError(message);
  }
}

class AuthState {
  final bool loading;
  final User? user;
  final AuthView authView;
  final String? resetToken;

  const AuthState({
    this.loading = false,
    this.user,
    this.authView = AuthView.login,
    this.resetToken,
  });

  AuthState copyWith({
    bool? loading,
    User? user,
    AuthView? authView,
    String? resetToken,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      user: user ?? this.user,
      authView: authView ?? this.authView,
      resetToken: resetToken,
    );
  }
}
