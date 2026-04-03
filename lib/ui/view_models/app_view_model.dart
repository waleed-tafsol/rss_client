import 'base_view_model.dart';

class AppViewModel extends BaseViewModel {
  bool isLoggedIn = false;

  void setIsLoggedIn(bool value) {
    isLoggedIn = value;
    notifyListeners();
  }
}
