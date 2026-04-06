
import 'base_view_model.dart';

class AppViewModel extends BaseViewModel {
  bool isLoggedIn = false;

  void setIsLoggedIn(bool value) {
    isLoggedIn = value;
    notifyListeners();
  }
}

// class AppState {
//   final bool isLoggedIn;

//   const AppState({this.isLoggedIn = false});

//   AppState copyWith({bool? isLoggedIn}) {
//     return AppState(isLoggedIn: isLoggedIn ?? this.isLoggedIn);
//   }
// }
