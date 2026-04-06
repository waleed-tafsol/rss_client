import 'base_view_model.dart';

class AppViewModel extends BaseViewModel {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void setIsLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }
}
