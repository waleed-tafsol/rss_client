import 'package:flutter/material.dart';

import '../../services/locator.dart';
import 'base_view_model.dart';

class ThemeViewModel extends BaseViewModel {
  ThemeMode themeMode = ThemeMode.light;

  @override
  void init() async {
    super.init();
    final theme = await locator<StorageService>().getTheme();
    if (theme != null) {
      themeMode = theme;
      notifyListeners();
    }
  }

  void toggleTheme() {
    final newTheme = themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    themeMode = newTheme;
    notifyListeners();
  }
}
