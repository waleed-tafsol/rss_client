import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'base_view_model.dart';

final appProvider = NotifierProvider(() => AppViewModel._());

class AppViewModel extends BaseViewModel<AppState> {
  AppViewModel._() : super(const AppState());

  void setIsLoggedIn(bool value) {
    state = state.copyWith(isLoggedIn: value);
  }
}

class AppState {
  final bool isLoggedIn;

  const AppState({this.isLoggedIn = false});

  AppState copyWith({bool? isLoggedIn}) {
    return AppState(isLoggedIn: isLoggedIn ?? this.isLoggedIn);
  }
}
