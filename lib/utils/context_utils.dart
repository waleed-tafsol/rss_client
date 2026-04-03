import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'string_utils.dart';

import '../l10n/app_localizations.dart';
import '../l10n/app_localizations_en.dart';

extension ContextUtils on BuildContext {
  AppLocalizations get localization {
    return AppLocalizations.of(this) ?? AppLocalizationsEn();
  }

  bool get isMobile => MediaQuery.of(this).size.width < 600;

  bool get isTablet =>
      MediaQuery.of(this).size.width >= 600 &&
      MediaQuery.of(this).size.width < 1024;

  bool get isDesktop => MediaQuery.of(this).size.width >= 1024;

  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  String get displayPath {
    final words = GoRouter.of(this).state.uri.toString().split('/');
    return words.last.split('-').map((w) => w.capitalize).join(' ');
  }
}
