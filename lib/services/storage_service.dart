part of 'locator.dart';

class StorageService {
  StorageService._();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _themeModeKey = 'theme-mode';
  static const String _accessTokenKey = 'access-token';
  static const String _userKey = 'user-key';
  //static const String _selectedProjectIdKey = 'selected-project-id';
  static const String _selectedPropertyIdKey = 'selected-property-id';

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

  Future<void> saveAccessToken(String? accessToken) async {
    if (accessToken == null) {
      return;
    }
    await _storage.write(key: _accessTokenKey, value: accessToken);
  }

  Future<void> saveSelectedPropertyId(String? id) async {
    if (id == null) {
      await _storage.delete(key: _selectedPropertyIdKey);
    } else {
      await _storage.write(key: _selectedPropertyIdKey, value: id);
    }
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  Future<void> saveUser(User? user) async {
    if (user == null) {
      return;
    }
    await _storage.write(key: _userKey, value: jsonEncode(user.toJson()));
  }

  Future<User?> getUser() async {
    final userString = await _storage.read(key: _userKey);
    if (userString == null) {
      return null;
    }
    return User.fromJson(jsonDecode(userString));
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
