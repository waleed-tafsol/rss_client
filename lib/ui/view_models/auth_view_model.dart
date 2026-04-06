import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          role: UserType.client,
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

  const AuthState({
    this.loading = false,
    this.user,
    this.authView = AuthView.login,
  });

  AuthState copyWith({bool? loading, User? user, AuthView? authView}) {
    return AuthState(
      loading: loading ?? this.loading,
      user: user ?? this.user,
      authView: authView ?? this.authView,
    );
  }
}
