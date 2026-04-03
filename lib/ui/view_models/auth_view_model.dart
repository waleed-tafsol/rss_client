import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/requests/login_request.dart';
import '../../models/responses/auth_response.dart';
import '../../services/locator.dart';
import 'base_view_model.dart';

final authProvider = NotifierProvider(() => AuthViewModel());

class AuthViewModel extends BaseViewModel<AuthState> {
  AuthViewModel() : super(const AuthState());

  Future<void> login({required String email, required String password}) async {
    return await runSafely(() async {
      state = state.copyWith(loading: true);
      final user = await locator<AuthService>().login(
        request: LoginRequest(email: email, password: password),
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
      locator<StorageService>().clear();
      state = const AuthState();
    });
  }

  @override
  void handleError(String message) {
    state = state.copyWith(loading: false);
    super.handleError(message);
  }
}

class AuthState {
  final bool loading;
  final User? user;

  const AuthState({this.loading = false, this.user});

  AuthState copyWith({bool? loading, User? user}) {
    return AuthState(loading: loading ?? this.loading, user: user ?? this.user);
  }
}
