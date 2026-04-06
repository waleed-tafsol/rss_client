import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/locator.dart';
import 'base_view_model.dart';

final themeProvider = NotifierProvider(() => ThemeViewModel._());

class ThemeViewModel extends BaseViewModel<ThemeMode> {
  ThemeViewModel._() : super(ThemeMode.light);

  @override
  void init() async {
    super.init();
    final theme = await locator<StorageService>().getTheme();
    if (theme != null) {
      state = theme;
    }
  }

  void toggleTheme() {
    final newTheme = state == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    state = newTheme;
  }
}
