import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../exceptions/app_exception.dart';
import '../../models/requests/login_request.dart';
import '../../models/responses/auth_response.dart';
import '../../services/locator.dart';
import '../../utils/enums.dart';
import 'base_view_model.dart';

class AuthViewModel extends BaseViewModel {
  bool loading = false;
  User? user;
  AuthView? authView = AuthView.login;
  String? resetToken;

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void setUser(User? user) {
    user = user;
  }

  void setAuthView(AuthView view) {
    authView = view;
    notifyListeners();
  }

  void setRestToken(String? token) {
    resetToken = token;
    notifyListeners();
  }

  Future<void> login({required String email, required String password}) async {
    return await runSafely(() async {
      setLoading(true);

      final user = await locator<AuthService>().login(
        request: LoginRequest(
          email: email,
          password: password,
          role: UserType.admin,
        ),
      );
      loading = false;
      this.user = user;
      notifyListeners();
     
    });
  }

  Future<void> checkAuthentication() async {
    return await runSafely(() async {
      final user = await locator<StorageService>().getUser();
      this.user = user;
      loading = false;
      notifyListeners();
      // setUser(user);
      // setLoading(false);
    });
  }

  Future<void> logout() async {
    return await runSafely(() async {
      EasyLoading.show(status: 'Logging out...');
      await locator<AuthService>().logout();
      EasyLoading.dismiss();
    });
  }

  Future<void> forgotPassword({required String email}) async {
    return await runSafely(() async {
      setLoading(true);
      await locator<AuthService>().forgotPassword(email: email);
      loading = false;
      authView = AuthView.otp;
      notifyListeners();
      // setLoading(false);
      // setAuthView(AuthView.otp);
      // state = state.copyWith(loading: false, authView: AuthView.otp);
    });
  }

  Future<void> verifyOtp({required String email, required String otp}) async {
    return await runSafely(() async {
      //  state = state.copyWith(loading: true);
      setLoading(true);
      final resetToken = await locator<AuthService>().verifyOtp(
        email: email,
        otp: otp,
      );
      authView = AuthView.otp;
      loading = false;
      this.resetToken = resetToken;

      // state = state.copyWith(
      //   loading: false,
      //   authView: AuthView.resetPassword,
      //   resetToken: resetToken,
      // );
      EasyLoading.showSuccess('Email verified!');
      notifyListeners();
    });
  }

  Future<void> resetPassword({
    required String password,
    required String passwordConfirmation,
  }) async {
    return await runSafely(() async {
      //  final resetToken = state.resetToken;
      if (resetToken == null) {
        throw const AppException(
          'Resend token not found, please send otp again!',
        );
      }
      setLoading(true);
      // state = state.copyWith(loading: true);
      await locator<AuthService>().resetPassword(
        resetToken: resetToken ?? "",
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      loading = false;
      authView = AuthView.login;
      resetToken = null;
      // state = state.copyWith(
      //   loading: false,
      //   authView: AuthView.login,
      //   resetToken: null,
      // );
      EasyLoading.showSuccess('Password reset successfully!');
      notifyListeners();
    });
  }

  @override
  void handleError(String message) {
    loading = false;
    //  state = state.copyWith(loading: false);
    EasyLoading.dismiss();
    super.handleError(message);
    notifyListeners();
  }
}

// class AuthState {
//   const AuthState({
//     this.loading = false,
//     this.user,
//     this.authView = AuthView.login,
//     this.resetToken,
//   });

//   AuthState copyWith({
//     bool? loading,
//     User? user,
//     AuthView? authView,
//     String? resetToken,
//   }) {
//     return AuthState(
//       loading: loading ?? this.loading,
//       user: user ?? this.user,
//       authView: authView ?? this.authView,
//       resetToken: resetToken,
//     );
//   }
// }
