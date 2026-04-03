part of 'locator.dart';

class StorageService {
  StorageService._();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _themeModeKey = 'theme-mode';

  Future<void> saveTheme(ThemeMode themeMode) async {
    await _storage.write(key: _themeModeKey, value: themeMode.name);
  }

  Future<ThemeMode?> getTheme() async {
    final themeString = await _storage.read(key: _themeModeKey);
    if (themeString == null) {
      return null;
    }
    return ThemeMode.values.byName(themeString);
  }
}
