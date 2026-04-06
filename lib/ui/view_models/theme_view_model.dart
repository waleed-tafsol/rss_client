import 'package:flutter/material.dart';

import '../../services/locator.dart';
import 'base_view_model.dart';

class ThemeViewModel extends BaseViewModel {
  ThemeMode _themeMode = ThemeMode.light;


  ThemeMode get themeMode => _themeMode;

  @override
  void init() async {
    super.init();
    final theme = await locator<StorageService>().getTheme();
    if (theme != null) {
      _themeMode = theme;
      notifyListeners();
    }
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }
}
