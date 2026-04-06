import '../../utils/enums.dart';
import 'base_view_model.dart';

class SettingsViewModel extends BaseViewModel {
  SettingsType _settingsType = SettingsType.profile;

  SettingsType get settingsType => _settingsType;

  void updateSettingsType(SettingsType newSettingsType) {
    if (_settingsType == newSettingsType) {
      return;
    }
    _settingsType = newSettingsType;
    notifyListeners();
  }
}
